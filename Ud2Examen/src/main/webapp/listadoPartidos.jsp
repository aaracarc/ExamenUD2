<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <link rel="stylesheet" type="text/css" href="../estilos.css" />
  <title>Listado Entrenamiento de Socios</title>
</head>
<body>

<h1>Listado de Entrenamientos</h1>
<%
  Connection conexion = null;
  Statement s = null;
  ResultSet listado = null;

  try{
    Class.forName("com.mysql.cj.jdbc.Driver");
    conexion = DriverManager.getConnection("jdbc:mysql://localhost:3306/juego","root", "user");
    s = conexion.createStatement();
    listado = s.executeQuery ("SELECT * FROM partido");
%>

<table>
  <tr><th>Codigo</th><th>Socio</th><th>Tipo</th><th>Ubicacion</th><th>Fecha</th><th><a href="formularioEntrenamientoSocio.jsp">+</a></th></tr>
  <%
    while (listado.next()) {
      out.println("<tr><td>"+listado.getString("id") + "</td>");
      out.println("<td>" + listado.getString("fecha") + "</td>");
      out.println("<td>" + listado.getString("equipo1") + "</td>");
      out.println("<td>" + listado.getString("puntos_equipo1") + "</td>");
      out.println("<td>" + listado.getString("equipo2") + "</td>");
      out.println("<td>" + listado.getString("puntos_equipo2") + "</td>");
      out.println("<td>" + listado.getString("tipo_partido") + "</td>");
  %>

  <td>
    <form method="get" action="borraPartido.jsp">
      <input type="hidden" name="codigo" value="<%=listado.getString("id") %>"/>
      <input type="submit" value="borrar">
    </form>
  </td></tr>

  <%
      }
      // Cierre de recursos.
      conexion.close();
      s.close();
      listado.close();

    }catch (Exception e){
      out.println("Error");
    }  finally {
      try {
        conexion.close();
      } catch (Exception e) { /* Ignored */ }
      try {
        s.close();
      } catch (Exception e) { /* Ignored */ }
      try {
        listado.close();
      } catch (Exception e) { /* Ignored */ }
    }
  %>
</table>
<a href="listadoPartidos.jsp">Volver</a>
</body>
</html>