class ContactsController < ApplicationController
    
#form sends data as query string parameter

   def new
    @contact = Contact.new #create a new Contact object
   end
   
  def create
    @contact = Contact.new(contact_params) #this code creates a new Contact object populated with form data or contact_params which is a variable defined in private section
    
    if @contact.save #so save it and if it worked or didnt work, run whatever part of if statement needs to be run
        
        name = params[:contact][:name] #New contact's name
        email = params[:contact][:email] #New contact's email
        body = params[:contact][:comments] #New contact's comments
        ContactMailer.contact_email(name, email, body).deliver
        
        flash[:success] = 'Message sent.'
        redirect_to new_contact_path
    else
        flash[:danger] = 'Error occured, message has not been sent.'
        redirect_to new_contact_path
    end
  end
  
  private
  
    def contact_params #passes in query string parameters from form via URL 
      params.require(:contact).permit(:name, :email, :comments) #have to write for security purposes (whitelisting)
    end
   
end