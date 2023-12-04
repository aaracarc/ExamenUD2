<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>JSP - Hello World</title>
</head>
<body>
<h1><%= "Hello World!" %>
</h1>
<br/>
<a href="hello-servlet">Hello Servlet</a>
<br>
<a href="listadoPartidos.jsp">Listado de Socios</a>
<br>
<a href="formularioPartido.jsp">Fomulario de Socio Nuevo</a>
<br>
<a href="pideNumeroPartido.jsp">Pide de Socios</a>

<form action="detalleSocio.jsp">
    Cargar socio con ID:
    <input type="text" name="socioID">
    <input type="submit" value="Enviar">
</form>
</body>
</html>