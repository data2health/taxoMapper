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
            <h3>Add a Mapping</h3>

                                <form action="addMapping.jsp" method="post">
                            <fieldset>
                                <legend>Select Entity Source</legend>
                                <label for="database">Database:</label> <input type="text" name="database" size="20" value="${param.database}"><br />
                                <label for="schema">Schema:</label> <input type="text" name="schema" size="20" value="${param.schema}"><br/>
                                <label for="table">Table:</label> <input type="text" name="table" size="20" value="${param.table}"><br/>
                                <label for="attribute">Attribute:</label> <input type="text" name="attribute" size="20" value="${param.attribute}"><br/>
                                <label for="value">Value:</label> <input type="text" name="value" size="20" value="${param.value}"><br/>
                                <input type="submit" name="submit" value="Select">
                            </fieldset>
                        </form>
 <c:choose>
    <c:when test="${not empty param.database and empty param.schema}">
       <sql:query var="schemas" dataSource="jdbc/taxoMapper">
            select schema_name from information_schema.schemata where schema_owner != 'postgres' order by 1;
        </sql:query>
        <ol class="bulletedList">
        <c:forEach items="${schemas.rows}" var="row">
            <li><a href="addMapping.jsp?database=${param.database}&schema=${row.schema_name}">${row.schema_name }</a>
       </c:forEach>
       </ol>
    </c:when>
    <c:when test="${not empty param.database and not empty param.schema and empty param.table}">
       <sql:query var="tables" dataSource="jdbc/taxoMapper">
            select table_name,'table' as table_type from information_schema.tables where table_schema = ? and table_type='BASE TABLE'
            union
            select table_name,'view' as table_type from information_schema.tables where table_schema = ? and table_type='VIEW'
            union
            select matviewname as table_name,'materialized_view' as table_type from pg_matviews where schemaname = ?
            order by 1;
            <sql:param>${param.schema}</sql:param>
            <sql:param>${param.schema}</sql:param>
            <sql:param>${param.schema}</sql:param>
        </sql:query>
        <ol class="bulletedList">
        <c:forEach items="${tables.rows}" var="row">
            <li><a href="addMapping.jsp?database=${param.database}&schema=${param.schema}&table=${row.table_name}">${row.table_name}</a> (${row.table_type})
       </c:forEach>
       </ol>
    </c:when>
    <c:when test="${not empty param.database and not empty param.schema and not empty param.table and empty param.attribute}">
       <sql:query var="columns" dataSource="jdbc/taxoMapper">
            select column_name,data_type, ordinal_position from information_schema.columns where table_schema = ? and table_name = ?
            union
            select attname as column_name,typname as data_type,attnum as ordinal_position
            from pg_attribute,pg_type,pg_class,pg_namespace
            where pg_attribute.atttypid=pg_type.oid and attrelid=pg_class.oid and attnum>0 and pg_class.relname = ? and pg_class.relnamespace=pg_namespace.oid and nspname = ?
            order by ordinal_position;
            <sql:param>${param.schema}</sql:param>
            <sql:param>${param.table}</sql:param>
            <sql:param>${param.table}</sql:param>
            <sql:param>${param.schema}</sql:param>
        </sql:query>
        <ol class="bulletedList">
        <c:forEach items="${columns.rows}" var="row">
            <li><a href="addMapping.jsp?database=${param.database}&schema=${param.schema}&table=${param.table}&attribute=${row.column_name}">${row.column_name}</a> (${row.data_type})
       </c:forEach>
       </ol>
    </c:when>
    <c:when test="${not empty param.database and not empty param.schema and not empty param.table and not empty param.attribute and empty param.value}">
        <sql:query var="values" dataSource="jdbc/taxoMapper">
            select ${param.attribute} as attribute,count(*) from ${param.schema}.${param.table} group by 1 order by 2 desc;
        </sql:query>
        <table>
        <tr><th>${param.attribute}</th><th>Count</th></tr>
        <c:forEach items="${values.rows}" var="row">
            <tr><td><a href="addMapping.jsp?database=${param.database}&schema=${param.schema}&table=${param.table}&attribute=${param.attribute}&value=${row.attribute}">${row.attribute}</a></td><td>${row.count}</td></tr>
       </c:forEach>
        </table>
    </c:when>
    <c:when test="${not empty param.database and not empty param.schema and not empty param.table and not empty param.attribute and not empty param.value}">
        <sql:query var="values" dataSource="jdbc/taxoMapper">
            select value,count(*) from ${param.schema}.${param.table} where ${param.attribute} = ? group by 1 order by 2 desc;
            <sql:param>${param.value}</sql:param>
        </sql:query>
        <table>
        <tr><th>${param.value}</th><th>Count</th></tr>
        <c:forEach items="${values.rows}" var="row">
            <tr><td>${row.value}</td><td>${row.count}</td></tr>
       </c:forEach>
        </table>
    </c:when>
 </c:choose>
    <c:if test="${param.submit eq 'Select' }">
        <sql:query var="values" dataSource="jdbc/taxoMapper">
            select ${param.attribute} as attribute,count(*) from ${param.schema}.${param.table} group by 1 order by 2 desc;
        </sql:query>
        <table>
        <tr><th>${param.attribute}</th><th>Count</th></tr>
        <c:forEach items="${values.rows}" var="row">
            <tr><td>${row.attribute}</td><td>${row.count}</td></tr>
       </c:forEach>
        </table>
    </c:if>

            <jsp:include page="/footer.jsp" flush="true" /></div>
    </div>
</body>
</html>

