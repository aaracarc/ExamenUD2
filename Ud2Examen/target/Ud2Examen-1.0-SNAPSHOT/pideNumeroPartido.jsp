<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    </head>
<body>
<%
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection conexion = DriverManager.getConnection("jdbc:mysql://localhost:3306/juego","root", "user");
    Statement s = conexion.createStatement();

    ResultSet listado = s.executeQuery ("SELECT * FROM partido");
%>
<table>
    <tr><th>Código</th><th>Nombre</th><th>Estatura</th><th>Edad</th><th>Localidad</th></tr>
    <%
        Integer partidoIDADestacar = (Integer)session.getAttribute("partidoIDADestacar");
        String claseDestacar = "";
        while (listado.next()) {
            claseDestacar = (partidoIDADestacar != null
                    && partidoIDADestacar ==listado.getInt("id") ) ?
                    "destacar" :  "";
    %>


    <tr class="<%= claseDestacar%>" >
        <td >
            <%=listado.getInt("id")%>
        </td>
        <td><%=listado.getString("fecha")%>
        </td>
        <td><%=listado.getString("equipo1")%>
        </td>
        <td><%=listado.getInt("puntos_equipo1")%>
        </td>
        <td><%=listado.getString("equipo2")%>
        <td><%=listado.getInt("puntos_equipo2")%>
        </td>
        <td>
            <form method="get" action="borraPartido.jsp">
                <input type="hidden" name="codigo" value="<%=listado.getString("id") %>"/>
                <input type="submit" value="borrar">
            </form>
        </td>
    </tr>
    <%
        } // while
        conexion.close();
    %>
</table>
</body>
</html>