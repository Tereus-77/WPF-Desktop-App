using System;
using System.Collections.Generic;
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
using System.Windows.Navigation;
using System.Windows.Shapes;
using System.Data.SqlClient;
using System.Data;
using System.ComponentModel;
using System.Configuration;

namespace WpfApp
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    /// 

    public partial class MainWindow : Window
    {
        public string[][] toMergeDatas;
        public int selectedId;
        public string m_orgValue = null;
        public string m_subValue = null;

        public MainWindow()
        {
            InitializeComponent();
            FillDataGrid();
            FillOrgList();
            FillSubList();
        }

        private void DataGrid_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {

        }

        public void GetData(string query)
        {
            try
            {
                SqlConnection thisConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["conn"].ConnectionString);
                thisConnection.Open();

                SqlCommand cmd = new SqlCommand(query);
                cmd.Connection = thisConnection;
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable("tblOrgEntities");
                dt.Columns.Add("IsChecked", typeof(bool));
                dt.Columns["IsChecked"].DefaultValue = false;

                sda.Fill(dt);
                grdData.ItemsSource = dt.DefaultView;

                thisConnection.Close();
            }
            catch
            {
                MessageBox.Show("db error");
            }
        }

        public void GetList(string query, string table)
        {
            try
            {
                SqlConnection thisConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["conn"].ConnectionString);
                thisConnection.Open();

                SqlCommand cmd = new SqlCommand(query);
                cmd.Connection = thisConnection;
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable(table);
                sda.Fill(dt);
                if (table == "lkLookups")
                {
                    foreach (DataRow dr in dt.Rows)
                    {
                        orgType.Items.Add(dr["Description"].ToString());
                    }
                } else if (table == "lkOrganizationSubTypes")
                {
                    foreach (DataRow dr in dt.Rows)
                    {
                        subType.Items.Add(dr["Description"].ToString());
                    }
                }

                thisConnection.Close();
            }
            catch
            {
                MessageBox.Show("db error");
            }
        }

        public void FillDataGrid()
        {
            string getQuery = "SELECT IDOrgEntities, lkLookups.Description Type, lkOrganizationSubTypes.Description SubType, OrgName, " +
                "Address1, City, State, Zip, Phone, ContactTitle, ContactFirstName, ContactLastName, tblOrgEntities.Active " +
                "FROM tblOrgEntities LEFT JOIN lkLookups ON lkLookups.IDLookup = tblOrgEntities.OrgEntityTypeID " +
                "LEFT JOIN lkOrganizationSubTypes on lkOrganizationSubTypes.IDOrganizationSubType = tblOrgEntities.OrgEntitySubTypeID";

            GetData(getQuery);
        }

        public void FillOrgList()
        {
            string listQuery = "SELECT Description FROM lkLookups WHERE LookupTableName = 'LUP_ORGANIZATIONTYPES' ORDER BY Description";
            string table = "lkLookups";

            GetList(listQuery, table);
        }

        public void FillSubList()
        {
            string listQuery = "SELECT Description FROM lkOrganizationSubTypes ORDER BY Description";
            string table = "lkOrganizationSubTypes";

            GetList(listQuery, table);
        }

        private void TextBox_TextChanged_2(object sender, TextChangedEventArgs e)
        {
            TextBox objTextBox = (TextBox)sender;
            string searchText = objTextBox.Text;
            string searchQuery;

            if (m_orgValue != null && m_subValue == null)
            {
                searchQuery = "SELECT IDOrgEntities, lkLookups.Description Type, lkOrganizationSubTypes.Description SubType, OrgName, " +
                "Address1, City, State, Zip, Phone, ContactTitle, ContactFirstName, ContactLastName, tblOrgEntities.Active " +
                "FROM tblOrgEntities LEFT JOIN lkLookups ON lkLookups.IDLookup = tblOrgEntities.OrgEntityTypeID " +
                "LEFT JOIN lkOrganizationSubTypes on lkOrganizationSubTypes.IDOrganizationSubType = tblOrgEntities.OrgEntitySubTypeID" +
                " WHERE (OrgName LIKE '%" + searchText + "%'"
                 + "OR Address1 LIKE '%" + searchText + "%'"
                 + "OR Phone LIKE '%" + searchText + "%'"
                 + "OR ContactFirstName LIKE '%" + searchText + "%'"
                 + "OR ContactLastName LIKE '%" + searchText + "%')"
                 + "AND lkLookups.Description LIKE '%" + m_orgValue + "%'";
            } else if (m_orgValue == null && m_subValue != null) {
                searchQuery = "SELECT IDOrgEntities, lkLookups.Description Type, lkOrganizationSubTypes.Description SubType, OrgName, " +
                "Address1, City, State, Zip, Phone, ContactTitle, ContactFirstName, ContactLastName, tblOrgEntities.Active " +
                "FROM tblOrgEntities LEFT JOIN lkLookups ON lkLookups.IDLookup = tblOrgEntities.OrgEntityTypeID " +
                "LEFT JOIN lkOrganizationSubTypes on lkOrganizationSubTypes.IDOrganizationSubType = tblOrgEntities.OrgEntitySubTypeID" +
                " WHERE (OrgName LIKE '%" + searchText + "%'"
                 + "OR Address1 LIKE '%" + searchText + "%'"
                 + "OR Phone LIKE '%" + searchText + "%'"
                 + "OR ContactFirstName LIKE '%" + searchText + "%'"
                 + "OR ContactLastName LIKE '%" + searchText + "%')"
                 + "AND lkOrganizationSubTypes.Description LIKE '%" + m_subValue + "%'";
            } else if (m_orgValue != null && m_subValue != null) {
                searchQuery = "SELECT IDOrgEntities, lkLookups.Description Type, lkOrganizationSubTypes.Description SubType, OrgName, " +
                "Address1, City, State, Zip, Phone, ContactTitle, ContactFirstName, ContactLastName, tblOrgEntities.Active " +
                "FROM tblOrgEntities LEFT JOIN lkLookups ON lkLookups.IDLookup = tblOrgEntities.OrgEntityTypeID " +
                "LEFT JOIN lkOrganizationSubTypes on lkOrganizationSubTypes.IDOrganizationSubType = tblOrgEntities.OrgEntitySubTypeID" +
                " WHERE (OrgName LIKE '%" + searchText + "%'"
                 + "OR Address1 LIKE '%" + searchText + "%'"
                 + "OR Phone LIKE '%" + searchText + "%'"
                 + "OR ContactFirstName LIKE '%" + searchText + "%'"
                 + "OR ContactLastName LIKE '%" + searchText + "%')"
                 + "AND lkLookups.Description LIKE '%" + m_orgValue + "%'"
                 + "AND lkOrganizationSubTypes.Description LIKE '%" + m_subValue + "%'";
            } else {
                searchQuery = "SELECT IDOrgEntities, lkLookups.Description Type, lkOrganizationSubTypes.Description SubType, OrgName, " +
                "Address1, City, State, Zip, Phone, ContactTitle, ContactFirstName, ContactLastName, tblOrgEntities.Active " +
                "FROM tblOrgEntities LEFT JOIN lkLookups ON lkLookups.IDLookup = tblOrgEntities.OrgEntityTypeID " +
                "LEFT JOIN lkOrganizationSubTypes on lkOrganizationSubTypes.IDOrganizationSubType = tblOrgEntities.OrgEntitySubTypeID" +
                " WHERE OrgName LIKE '%" + searchText + "%'"
                 + "OR Address1 LIKE '%" + searchText + "%'"
                 + "OR Phone LIKE '%" + searchText + "%'"
                 + "OR ContactFirstName LIKE '%" + searchText + "%'"
                 + "OR ContactLastName LIKE '%" + searchText + "%'";
            }
            
            GetData(searchQuery);
        }

        private void OrgTypeList(object sender, SelectionChangedEventArgs e)
        {
            string filterQuery;

            if (orgType.SelectedIndex >= 0)
                m_orgValue = orgType.SelectedValue.ToString();

            if (subType.SelectedValue != null && m_orgValue != null)
                filterQuery = "SELECT IDOrgEntities, lkLookups.Description Type, lkOrganizationSubTypes.Description SubType, OrgName, " +
                    "Address1, City, State, Zip, Phone, ContactTitle, ContactFirstName, ContactLastName, tblOrgEntities.Active " +
                    "FROM tblOrgEntities LEFT JOIN lkLookups ON lkLookups.IDLookup = tblOrgEntities.OrgEntityTypeID " +
                    "LEFT JOIN lkOrganizationSubTypes on lkOrganizationSubTypes.IDOrganizationSubType = tblOrgEntities.OrgEntitySubTypeID" +
                    " WHERE lkLookups.Description LIKE '%" + m_orgValue + "%'" +
                    " AND lkOrganizationSubTypes.Description LIKE '%" + subType.SelectedValue.ToString() + "%'";
            else
                filterQuery = "SELECT IDOrgEntities, lkLookups.Description Type, lkOrganizationSubTypes.Description SubType, OrgName, " +
                    "Address1, City, State, Zip, Phone, ContactTitle, ContactFirstName, ContactLastName, tblOrgEntities.Active " +
                    "FROM tblOrgEntities LEFT JOIN lkLookups ON lkLookups.IDLookup = tblOrgEntities.OrgEntityTypeID " +
                    "LEFT JOIN lkOrganizationSubTypes on lkOrganizationSubTypes.IDOrganizationSubType = tblOrgEntities.OrgEntitySubTypeID" +
                    " WHERE lkLookups.Description LIKE '%" + m_orgValue + "%'";

            GetData(filterQuery);
        }

        private void SubTypeList(object sender, SelectionChangedEventArgs e)
        {
            string filterQuery;

            if (subType.SelectedIndex >= 0)
                m_subValue = subType.SelectedValue.ToString();

            if (orgType.SelectedValue != null && m_subValue != null)
                filterQuery = "SELECT IDOrgEntities, lkLookups.Description Type, lkOrganizationSubTypes.Description SubType, OrgName, " +
                    "Address1, City, State, Zip, Phone, ContactTitle, ContactFirstName, ContactLastName, tblOrgEntities.Active " +
                    "FROM tblOrgEntities LEFT JOIN lkLookups ON lkLookups.IDLookup = tblOrgEntities.OrgEntityTypeID " +
                    "LEFT JOIN lkOrganizationSubTypes on lkOrganizationSubTypes.IDOrganizationSubType = tblOrgEntities.OrgEntitySubTypeID" +
                    " WHERE lkOrganizationSubTypes.Description LIKE '%" + m_subValue + "%'" +
                    " AND lkLookups.Description LIKE '%" + orgType.SelectedValue.ToString() + "%'";
            else
                filterQuery = "SELECT IDOrgEntities, lkLookups.Description Type, lkOrganizationSubTypes.Description SubType, OrgName, " +
                    "Address1, City, State, Zip, Phone, ContactTitle, ContactFirstName, ContactLastName, tblOrgEntities.Active " +
                    "FROM tblOrgEntities LEFT JOIN lkLookups ON lkLookups.IDLookup = tblOrgEntities.OrgEntityTypeID " +
                    "LEFT JOIN lkOrganizationSubTypes on lkOrganizationSubTypes.IDOrganizationSubType = tblOrgEntities.OrgEntitySubTypeID" +
                    " WHERE lkOrganizationSubTypes.Description LIKE '%" + m_subValue + "%'";

            GetData(filterQuery);
        }

        private void clearFilter_Click(object sender, RoutedEventArgs e)
        {
            textBox.Text = null;
            orgType.SelectedIndex = -1;
            subType.SelectedIndex = -1;
            FillDataGrid();
        }

        private void merge_Click(object sender, RoutedEventArgs e)
        {
            if (toMergeDatas != null && toMergeDatas.Length >= 2)
            {
                Window1 subWindow = new Window1(this);
                subWindow.Show();
            }
            else
            {
                MessageBox.Show("Please select 2 or more Org Entities.");
            }
        }

        private void OnChecked(object sender, RoutedEventArgs e)
        {
            string[] row;
            var listOfArrays = new List<string[]>();

            foreach (DataRowView dt in grdData.ItemsSource)
            {
                if(dt.Row["IsChecked"].ToString() == "True")
                {
                    row = new string[] {
                        dt.Row["IDOrgEntities"].ToString(),
                        dt.Row["OrgName"].ToString(),
                        dt.Row["Address1"].ToString(), 
                        dt.Row["City"].ToString(), 
                        dt.Row["State"].ToString(), 
                        dt.Row["Zip"].ToString()
                    };
                    listOfArrays.Add(row);
                    toMergeDatas = listOfArrays.ToArray();                    
                }
            }
        }

        private void Row_DoubleClick(object sender, MouseButtonEventArgs e)
        {
            foreach (DataRowView row in grdData.SelectedItems)
            {
                System.Data.DataRow MyRow = row.Row;
                string value = MyRow["IDOrgEntities"].ToString();
                selectedId = Int32.Parse(value);
                Window2 subWindow = new Window2(this);
                subWindow.Show();
            }
        }
    }
}
