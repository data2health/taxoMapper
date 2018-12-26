<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>taxoMapper</title>
<style type="text/css" media="all">
@import "<util:applicationRoot/>/resources/style.css";
</style>
</head>
<body>
    <div id="content"><jsp:include page="/header.jsp" flush="true" />
        <jsp:include page="/menu.jsp" flush="true"><jsp:param
                name="caller" value="research" /></jsp:include><div id="centerCol">
            <h3>Mappings</h3>

        <sql:query var="mappings" dataSource="jdbc/taxoMapper">
            select eid,database_name,schema_name,table_name,attribute_name,value
            from taxonomy.entity
            order by 2,3,4,5,6;
        </sql:query>
        <table>
        <tr><th>ID</th><th>Database</th><th>Schema</th><th>Table</th><th>Attribute</th><th>Value</th></tr>
        </table>
        <c:forEach items="${mappings.rows}" var="row" varStatus="rowCounter">
            <tr><td>${row.eid}</td><td>${row.database_name}</td><td>${row.schema_name}</td><td>${row.table_name}</td><td>${row.attribute_name}</td><td>${row.value}</td></tr>
        </c:forEach>
        </table>

            <jsp:include page="/footer.jsp" flush="true" /></div>
    </div>
</body>
</html>

