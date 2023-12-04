<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<h2>Introduzca los datos del nuevo partido:</h2>
<form method="post" action="grabaPartido.jsp">
    Nº Partido <input type="text" name="numero"/></br>
    Fecha <input type="text" name="fecha"/></br>
    Equipo 1 <input type="text" name="equipo1"/></br>
    Puntos Equipo 1 <input type="text" name="puntos_equipo1"/></br>
    Equipo 2 <input type="text" name="equipo2"/></br>
    Puntos Equipo 2 <input type="text" name="puntos_equipo2"/></br>
    Tipo de Partido <input type="text" name="tipo_partido"/></br>
    <input type="submit" value="Aceptar">
</form>

<%
    String error = (String)session.getAttribute("error");
    if ( error != null) {
%>
<span style="background-color: red;color: yellow"><%=error%></span>
<%
        session.removeAttribute("error");
    }
%>
</body>
</html>