using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;

namespace WpfApp
{
    /// <summary>
    /// Interaction logic for Window2.xaml
    /// </summary>
    public partial class Window2 : Window
    {
        public MainWindow mainWindow;

        public Window2(MainWindow mainWindow)
        {
            InitializeComponent();
            this.mainWindow = mainWindow;
            SetDetails();
        }

        private void SetDetails()
        {
            try
            {
                SqlConnection thisConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["conn"].ConnectionString);
                thisConnection.Open();

                string query = "select *, lkLookups.Description OrgType, lkOrganizationSubTypes.Description SubType from tblOrgEntities " +
                    "left join lkLookups on lkLookups.IDLookup = tblOrgEntities.OrgEntityTypeID " +
                    "left join lkOrganizationSubTypes on lkOrganizationSubTypes.IDOrganizationSubType = tblOrgEntities.OrgEntitySubTypeID where IDOrgEntities = " + this.mainWindow.selectedId;
                
                using (SqlCommand command = new SqlCommand(query, thisConnection))
                {
                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            name.Text = reader["OrgName"].ToString();
                            orgtype.Text = reader["OrgType"].ToString();
                            subtype.Text = reader["SubType"].ToString();
                            zip.Text = reader["Zip"].ToString();
                            address1.Text = reader["Address1"].ToString();
                            address2.Text = reader["Address2"].ToString();
                            tin.Text = reader["TIN"].ToString();
                            npi.Text = reader["NPI"].ToString();
                            city.Text = reader["City"].ToString();
                            st.Text = reader["State"].ToString();
                            county.Text = reader["OrgEntityTypeID"].ToString();
                            phone.Text = reader["ContactPhone_Format"].ToString();
                            ext.Text = reader["Ext"].ToString();
                            fax.Text = reader["Fax"].ToString();
                            beeper.Text = reader["Beeper"].ToString();
                            active.IsChecked = reader["active"].ToString() == "1" ? true : false;
                            title.Text = reader["ContactTitle"].ToString();
                            contactprefix.Text = reader["ContactPrefix"].ToString();
                            contactfirstname.Text = reader["ContactFirstName"].ToString();
                            contactlastname.Text = reader["ContactLastName"].ToString();
                            contactemail.Text = reader["EmailAddress"].ToString();
                            contactphone.Text = reader["ContactPhone"].ToString();
                            contactext.Text = reader["ContactExt"].ToString();
                            contactnotes.Text = reader["Notes"].ToString();
                        }
                    }
                }

                thisConnection.Close();
            }
            catch
            {
                MessageBox.Show("db error");
            }
            //id.Text = this.mainWindow.selectedId.ToString();
        }

    }
}
