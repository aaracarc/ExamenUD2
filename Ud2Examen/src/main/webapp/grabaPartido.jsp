<%@page import="java.sql.*" %>
<%@page import="java.util.Objects" %>
<%@ page import="java.io.IOException" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<%
    //CÓDIGO DE VALIDACIÓN
    boolean valida = true;
    int numero = -1;
    String fecha = null;
    String equipo1 = null;
    int puntos_equipo1 = -1;
    String equipo2 = null;
    int puntos_equipo2 = -1;
    String tipoPartido = null;

    boolean flagValidaNumero = false;
    boolean flagValidaNombreNull = false;
    boolean flagValidaNombreBlank = false;
    boolean flagValidaPuntos1 = false;
    boolean flagValidaPuntos2 = false;
    boolean flagValidaTipoPartido = false;

    try {

        numero = Integer.parseInt(request.getParameter("id"));
        flagValidaNumero = true;
        //UTILIZO LOS CONTRACTS DE LA CLASE Objects PARA LA VALIDACIÓN
        //             v---- LANZA NullPointerException SI EL PARÁMETRO ES NULL
        Objects.requireNonNull(request.getParameter("equipo1"));
        flagValidaNombreNull = true;
        //CONTRACT nonBlank..
        //UTILIZO isBlank SOBRE EL PARÁMETRO DE TIPO String PARA CHEQUEAR QUE NO ES UN PARÁMETRO VACÍO "" NI CADENA TODO BLANCOS "    "
        //          |                                EN EL CASO DE QUE SEA BLANCO LO RECIBIDO, LANZO UNA EXCEPCIÓN PARA INVALIDAR EL PROCESO DE VALIDACIÓN
        //          -------------------------v                      v---------------------------------------|
        if (request.getParameter("equipo1").isBlank()) throw new RuntimeException("Parámetro vacío o todo espacios blancos.");
        flagValidaNombreBlank = true;
        equipo1 = request.getParameter("equipo1");

        puntos_equipo1 = Integer.parseInt(request.getParameter("puntos_equipo1"));
        flagValidaPuntos1 = true;

        puntos_equipo2 = Integer.parseInt(request.getParameter("puntos_equipo2"));
        flagValidaPuntos2 = true;

        //UTILIZO LOS CONTRACTS DE LA CLASE Objects PARA LA VALIDACIÓN
        //             v---- LANZA NullPointerException SI EL PARÁMETRO ES NULL
        Objects.requireNonNull(request.getParameter("equipo2"));
        //CONTRACT nonBlank
        //UTILIZO isBlank SOBRE EL PARÁMETRO DE TIPO String PARA CHEQUEAR QUE NO ES UN PARÁMETRO VACÍO "" NI CADENA TODO BLANCOS "    "
        //          |                                EN EL CASO DE QUE SEA BLANCO LO RECIBIDO, LANZO UNA EXCEPCIÓN PARA INVALIDAR EL PROCESO DE VALIDACIÓN
        //          -------------------------v                      v---------------------------------------|
        if (request.getParameter("equipo2").isBlank()) throw new RuntimeException("Parámetro vacío o todo espacios blancos.");
        flagValidaTipoPartido = true;
        equipo2 = request.getParameter("equipo2");

    } catch (Exception ex) {
        ex.printStackTrace();

        if (!flagValidaNumero) {
            session.setAttribute("error", "Error en número.");
        } else if (!flagValidaNombreNull || !flagValidaNombreBlank) {
            session.setAttribute("error", "Error en equipo1.");
        } else if (!flagValidaPuntos2) {
            session.setAttribute("error", "Error en puntos_equipo2.");
        } else if (!flagValidaPuntos1) {
            session.setAttribute("error", "Error en puntos_equipo1.");
        } else if (!flagValidaTipoPartido) {
            session.setAttribute("error", "Error en equipo2.");
        }



        valida = false;
    }
    //FIN CÓDIGO DE VALIDACIÓN

    if (valida) {

        Connection conn = null;
        PreparedStatement ps = null;
// 	ResultSet rs = null;

        try {

            //CARGA DEL DRIVER Y PREPARACIÓN DE LA CONEXIÓN CON LA BBDD
            //						v---------UTILIZAMOS LA VERSIÓN MODERNA DE LLAMADA AL DRIVER, no deprecado
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/baloncesto", "root", "user");


//>>>>>>NO UTILIZAR STATEMENT EN QUERIES PARAMETRIZADAS
//       Statement s = conexion.createStatement();
//       String insercion = "INSERT INTO socio VALUES (" + Integer.valueOf(request.getParameter("numero"))
//                          + ", '" + request.getParameter("equipo1")
//                          + "', " + Integer.valueOf(request.getParameter("puntos_equipo1"))
//                          + ", " + Integer.valueOf(request.getParameter("puntos_equipo2"))
//                          + ", '" + request.getParameter("equipo2") + "')";
//       s.execute(insercion);
//<<<<<<

            String sql = "INSERT INTO partido VALUES ( " +
                    "?, " + //socioID
                    "?, " + //equipo1
                    "?, " + //puntos_equipo1
                    "?, " + //puntos_equipo2
                    "?)"; //equipo2

            ps = conn.prepareStatement(sql);
            int idx = 1;
            ps.setInt(idx++, numero);
            ps.setString(idx++, equipo1);
            ps.setInt(idx++, puntos_equipo1);
            ps.setInt(idx++, puntos_equipo2);
            ps.setString(idx++, equipo2);

            int filasAfectadas = ps.executeUpdate();
            System.out.println("SOCIOS GRABADOS:  " + filasAfectadas);


        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            //BLOQUE FINALLY PARA CERRAR LA CONEXIÓN CON PROTECCIÓN DE try-catch
            //SIEMPRE HAY QUE CERRAR LOS ELEMENTOS DE LA  CONEXIÓN DESPUÉS DE UTILIZARLOS
            //try { rs.close(); } catch (Exception e) { /* Ignored */ }
            try {
                ps.close();
            } catch (Exception e) { /* Ignored */ }
            try {
                conn.close();
            } catch (Exception e) { /* Ignored */ }
        }

        //out.println("Socio dado de alta.");

        //response.sendRedirect("detalleSocio.jsp?socioID="+numero);
        //response.sendRedirect("pideNumeroSocio.jsp?socioIDADestacar="+numero);
        session.setAttribute("partidoIDADestacar", numero);
        response.sendRedirect("pideNumeroPartido.jsp");

    } else {
        //out.println("Error de validación!");
        response.sendRedirect("formularioPartido.jsp");
    }
%>

</body>
</html>