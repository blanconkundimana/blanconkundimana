<%@page import="project.ConnectionProvider" %>
<%@page import="java.sql.*" %>
<%@include file="header.jsp" %>
<%@include file="footer.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>My Cart</title>
<style>
h3
{
	color: yellow;
	text-align: center;
}
</style>
</head>
<body>
<div style="color: white; text-align: center; font-size: 30px;">My Cart <svg xmlns="http://www.w3.org/2000/svg" style="width:28;" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-6 h-6">
  <path stroke-linecap="round" stroke-linejoin="round" d="M2.25 3h1.386c.51 0 .955.343 1.087.835l.383 1.437M7.5 14.25a3 3 0 00-3 3h15.75m-12.75-3h11.218c1.121-2.3 2.1-4.684 2.924-7.138a60.114 60.114 0 00-16.536-1.84M7.5 14.25L5.106 5.272M6 20.25a.75.75 0 11-1.5 0 .75.75 0 011.5 0zm12.75 0a.75.75 0 11-1.5 0 .75.75 0 011.5 0z" />
</svg>
</div>

<%
String msg=request.getParameter("msg");
if("notPossible".equals(msg))
{
%>

<h3 class="alert">There is only one Quantity! So click on remove!</h3>
	
<%}%>
<%
if("inc".equals(msg))
{
	%>
<h3 class="alert">Quantity  Increased Successfully!</h3>

<% }%>
<%
if("dec".equals(msg))
{
	%>

<h3 class="alert">Quantity  Decreased Successfully!</h3>

<% }%>

<table>
<thead>
<%
int total=0;
int sno=0;
try{
	Connection con=ConnectionProvider.getCon();
	Statement st=con.createStatement();
	ResultSet rs1= st.executeQuery("select sum(total) from cart where email='"+email+"' and address is NULL");
	while(rs1.next())
	{
		total=rs1.getInt(1);
	}

%>
          <tr>
            <th scope="col" style="background-color: yellow;">Total:<svg xmlns="http://www.w3.org/2000/svg"
             fill="none" viewBox="0 0 24 24" stroke-width="1.5" style="width:18px; " stroke="currentColor" class="w-6 h-6"> 
  			<path  stroke-linecap="round" stroke-linejoin="round" 
  			 d="M12 6v12m-3-2.818l.879.659c1.171.879 3.07.879 4.242 0 1.172-.879 1.172-2.303 0-3.182C13.536 12.219 12.768 12 12 12c-.725 0-1.45-.22-2.003-.659-1.106-.879-1.106-2.303 0-3.182s2.9-.879 4.006 0l.415.33M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
</svg>
             <%out.println(total); %></th>
           <%if(total>0){ %> <th scope="col"><a href="addressPaymentForOrder.jsp">Proceed to order</a></th><%} %>
          </tr>
        </thead>
        <thead>
          <tr>
          <th scope="col">S.No</th>
            <th scope="col">Product Name</th>
            <th scope="col">Category</th>
            <th scope="col"><i class="fa fa-inr"></i> price</th>
            <th scope="col">Quantity</th>
            <th scope="col">Sub Total</th>
            <th scope="col">Remove <svg xmlns="http://www.w3.org/2000/svg" 
            fill="none" viewBox="0 0 24 24" stroke-width="1.5"
             stroke="currentColor" style="width:18;" class="w-6 h-6">
  			<path stroke-linecap="round" stroke-linejoin="round" 
  			d="M14.74 9l-.346 9m-4.788 0L9.26 9m9.968-3.21c.342.052.682.107 1.022.166m-1.022-.165L18.16 19.673a2.25 2.25 0 01-2.244 2.077H8.084a2.25 2.25 0 01-2.244-2.077L4.772 5.79m14.456 0a48.108 48.108 0 00-3.478-.397m-12 .562c.34-.059.68-.114 1.022-.165m0 0a48.11 48.11 0 013.478-.397m7.5 0v-.916c0-1.18-.91-2.164-2.09-2.201a51.964 51.964 0 00-3.32 0c-1.18.037-2.09 1.022-2.09 2.201v.916m7.5 0a48.667 48.667 0 00-7.5 0" />
</svg></th>
          </tr>
        </thead>
        <tbody>
      <%
      ResultSet rs=st.executeQuery("select * from product inner join cart on product.id=cart.product_id and cart.email='"+email+"' and cart.address is NULL");
      while(rs.next()){
    	  
      
      %>
          <tr>
			<%sno=sno+1; %>
           <td><%out.println(sno); %></td>
            <td><%=rs.getString(2) %></td>
            <td><%=rs.getString(3) %></td>
            <td><i><svg xmlns="http://www.w3.org/2000/svg" 
            fill="none" viewBox="0 0 24 24" stroke-width="1.5" style="width:18px" stroke="currentColor" class="w-6 h-6">
 			 <path stroke-linecap="round" stroke-linejoin="round"
  			 d="M12 6v12m-3-2.818l.879.659c1.171.879 3.07.879 4.242 0 1.172-.879 1.172-2.303 0-3.182C13.536 12.219 12.768 12 12 12c-.725 0-1.45-.22-2.003-.659-1.106-.879-1.106-2.303 0-3.182s2.9-.879 4.006 0l.415.33M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
</svg>
            </i> <%=rs.getString(4) %> </td>
            <td><a href="incDecQuantityAction.jsp?id=<%=rs.getString(1) %>&quantity=inc"><svg xmlns="http://www.w3.org/2000/svg"
             fill="none" viewBox="0 0 24 24"
             stroke-width="1.5" style="width:24;" stroke="currentColor" class="w-6 h-6">
  			<path stroke-linecap="round" stroke-linejoin="round"
  			 d="M12 9v6m3-3H9m12 0a9 9 0 11-18 0 9 9 0 0118 0z" />
			</svg> </a>  <%=rs.getString(8) %> <a href="incDecQuantityAction.jsp?id=<%=rs.getString(1) %>&quantity=dec"><svg xmlns="http://www.w3.org/2000/svg"
 			fill="none" viewBox="0 0 24 24" style="width:24;" stroke-width="1.5"
 			 stroke="currentColor" class="w-6 h-6">
  			<path stroke-linecap="round" stroke-linejoin="round"
  			 d="M15 12H9m12 0a9 9 0 11-18 0 9 9 0 0118 0z" />
</svg>  </a></td>
            <td><i><svg xmlns="http://www.w3.org/2000/svg" fill="none" 
            viewBox="0 0 24 24" stroke-width="1.5" style="width:18;" stroke="currentColor" class="w-6 h-6">
  			<path stroke-linecap="round" stroke-linejoin="round"
  			 d="M12 6v12m-3-2.818l.879.659c1.171.879 3.07.879 4.242 0 1.172-.879 1.172-2.303 0-3.182C13.536 12.219 12.768 12 12 12c-.725 0-1.45-.22-2.003-.659-1.106-.879-1.106-2.303 0-3.182s2.9-.879 4.006 0l.415.33M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
</svg>
            </i> <%=rs.getString(10) %> </td>
            <td><a href="removeFromCart.jsp?id=<%=rs.getString(1) %>">Remove <svg xmlns="http://www.w3.org/2000/svg" 
            fill="none" viewBox="0 0 24 24" stroke-width="1.5"
             stroke="currentColor" style="width:18;" class="w-6 h-6">
  			<path stroke-linecap="round" stroke-linejoin="round" 
  			d="M14.74 9l-.346 9m-4.788 0L9.26 9m9.968-3.21c.342.052.682.107 1.022.166m-1.022-.165L18.16 19.673a2.25 2.25 0 01-2.244 2.077H8.084a2.25 2.25 0 01-2.244-2.077L4.772 5.79m14.456 0a48.108 48.108 0 00-3.478-.397m-12 .562c.34-.059.68-.114 1.022-.165m0 0a48.11 48.11 0 013.478-.397m7.5 0v-.916c0-1.18-.91-2.164-2.09-2.201a51.964 51.964 0 00-3.32 0c-1.18.037-2.09 1.022-2.09 2.201v.916m7.5 0a48.667 48.667 0 00-7.5 0" />
</svg>
            </a></td>
          </tr>
<%
      }		
}
catch(Exception e){
	
}
%>
        </tbody>
      </table>
      <br>
      <br>
      <br>

</body>
</html>