

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
       
    </head>
    <body>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%@page import="MyPack.MyDb"%>
<%@ page import="java.io.File"%>
<%@ page import="java.io.InputStream"%>
<%@ page import="java.io.FileInputStream"%>
<%@ page import="javax.servlet.ServletException"%>
<%@ page import="javax.servlet.http.*"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.util.Vector"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="java.util.Date"%>

<%@ page import="java.util.Locale"%>

<%@ page import="java.text.DateFormat"%>
<%@ page import="java.text.SimpleDateFormat"%>

<%@ page import="java.sql.SQLException"%>
<%@ page import="java.sql.DriverManager"%>
<jsp:useBean id="lo" class="beanclass.applyproductbeen"/>
<jsp:setProperty name="lo" property="*"/>
<%
    
   out.print("hello");
    
    FileInputStream fis,fis1,fis2;
        PreparedStatement psmt=null,psmt1=null,psmt2=null;
        try{
        Class.forName("com.mysql.jdbc.Driver");
        
   MyDb db = new MyDb();
  Connection con =db.getCon();         //////////////////////////////////////////////
response.setContentType("text/html");  


Locale locale = request.getLocale( );
	String date = DateFormat.getDateTimeInstance(
		  DateFormat.FULL, 
		  DateFormat.SHORT, 
		  locale).format(new Date( ));
							  
	Calendar cal = Calendar.getInstance();
	SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
    String strDate = sdf.format(cal.getTime());

String photo_name=lo.getphoto_name();//String photo_name1=m.getParameter("photo_name1");
out.print("hello");
out.print(photo_name);

String unitid=lo.getunitid();
String pname=lo.getpname();
String descri=lo.getdescri();


//image data
File image1=new File(photo_name);
//File image2=new File(photo_name1);
ResultSet rs;
   out.print("hello");    
psmt1=con.prepareStatement("insert into tbl_product(unitid,pname,descri,status,photo)"+"values(?,?,?,?,?)");
psmt1.setString(1,unitid);
psmt1.setString(2,pname);
psmt1.setString(3,descri);
psmt1.setString(4,"Applied");

fis=new FileInputStream(image1);

psmt1.setBinaryStream(5, (InputStream)fis, (int)(image1.length()));

//fis1=new FileInputStream(image2);
//psmt1.setBinaryStream(21, (InputStream)fis1, (int)(image2.length()));
int res=psmt1.executeUpdate();


response.sendRedirect("applyproducts.jsp?msg=Successfully Applied New product");

con.close();

psmt.close();

 }
        catch(ClassNotFoundException e)
        {
            e.printStackTrace();
        }
catch (SQLException e)
    {
        // do something appropriate with the exception, *at least*:
        e.printStackTrace();
    }
         catch(NullPointerException e)
        {
            e.printStackTrace();
        }
 %>

    </body>
</html>
