using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Diagnostics;
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
    /// Interaction logic for Window1.xaml
    /// </summary>
    public partial class Window1 : Window
    {
        string[][] m_toMergeDatas;
        int m_primaryId = -1;
        int[] m_groupId;

        public MainWindow mainWindow;

        public Window1(MainWindow _mainWindow)
        {
            InitializeComponent();
            this.mainWindow = _mainWindow;
            initial();
        }

        public void initial()
        {
            m_toMergeDatas = this.mainWindow.toMergeDatas;

            DataTable dt = new DataTable();
            if (dt.Columns.Count == 0)
            {
                dt.Columns.Add("OrgName", typeof(string));
                dt.Columns.Add("Address1", typeof(string));
                dt.Columns.Add("City", typeof(string));
                dt.Columns.Add("State", typeof(string));
                dt.Columns.Add("Zip", typeof(string));
                dt.Columns.Add("Primary", typeof(bool));
                dt.Columns.Add("IDOrgEntities", typeof(int));
            }

            for (int i = 0; i < m_toMergeDatas.Length; i++)
            {
                DataRow NewRow = dt.NewRow();
                NewRow[0] = m_toMergeDatas[i][1];
                NewRow[1] = m_toMergeDatas[i][2];
                NewRow[2] = m_toMergeDatas[i][3];
                NewRow[3] = m_toMergeDatas[i][4];
                NewRow[4] = m_toMergeDatas[i][5];
                NewRow[5] = false;
                NewRow[6] = m_toMergeDatas[i][0];

                dt.Rows.Add(NewRow);
            }
            subGridData.ItemsSource = dt.DefaultView;
        }

        private void OnCheckedPrimary(object sender, RoutedEventArgs e)
        {            
            List<int> termsList = new List<int>();

            foreach (DataRowView dt in subGridData.ItemsSource)
            {
                if (dt.Row["Primary"].ToString() == "True")
                {
                    m_primaryId = Int32.Parse(dt.Row["IDOrgEntities"].ToString());
                } 
                else
                {
                    termsList.Add(Int32.Parse(dt.Row["IDOrgEntities"].ToString()));
                }
            }
            m_groupId = termsList.ToArray();
        }

        public void saveMerge(int primaryId, int[] groupId)
        {
                SqlConnection thisConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["conn"].ConnectionString);
                thisConnection.Open();
                SqlCommand cmd;

                string strGroup = string.Join("", groupId);
                int intGroup = Int32.Parse(strGroup);
                string time = DateTime.Now.ToString("MM/dd/yyyy H:mm:ss");

                string queryPrimary = "UPDATE tblOrgEntities SET MergedOrgId = " + intGroup + " WHERE IDOrgEntities = " + primaryId;
                cmd = new SqlCommand(queryPrimary);
                cmd.Connection = thisConnection;
                cmd.ExecuteNonQuery();
                
                for (int i = 0; i < groupId.Length; i++)
                {
                    string queryGroup = "UPDATE tblOrgEntities SET MergedOrgId = " + primaryId + " WHERE IDOrgEntities = " + groupId[i];
                    cmd = new SqlCommand(queryGroup);
                    cmd.Connection = thisConnection;
                    cmd.ExecuteScalar();
                }
                
                thisConnection.Close();

                MessageBox.Show("Merge Entities are done successfully!");
            
        }

        private void Merge_Click(object sender, RoutedEventArgs e)
        {
            if (m_primaryId != -1 && m_groupId.Length > 0)
            {
                saveMerge(m_primaryId, m_groupId);
                this.Close();
            }
            else
                MessageBox.Show("Please select a Primary.");
        }

        private void Button_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
        }
    }
}