<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

 <sql:update dataSource="jdbc/taxoMapper">
     insert into taxonomy.mapping(fid,eid) values(?::int,?::int);
     <sql:param>${param.fid}</sql:param>
     <sql:param>${param.eid}</sql:param>
 </sql:update>
 
<c:redirect url=".."/>
