
package com.tech.blog.dao;

import com.tech.blog.entities.Category;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class CategoryDao {
     private Connection con;
    public CategoryDao(Connection con) {
        this.con = con;
    }
   public ArrayList<Category> getCategory()
   {
       ArrayList<Category> list=new ArrayList<>();
       try
       {
           String query="select * from categories";
           PreparedStatement psmt=con.prepareStatement(query);
           ResultSet set=psmt.executeQuery();
           while(set.next())
           {
               int cid=set.getInt("cid");
               String name=set.getString("name");
               String description=set.getString("description");
               Category c=new Category(cid,name,description);
               list.add(c);
               
           }
       }catch(Exception e)
       {
           e.printStackTrace();
       }
       return list;
       
   }
   
    
}
