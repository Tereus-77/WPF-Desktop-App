   M S B A M L   `   `   `  ����A  =WpfApp, Version=1.0.0.0, Culture=neutral, PublicKeyToken=nullclr-namespace:WpfAppWpfApp  5   	       WpfApp.Window1   5   	   R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35W SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35\ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35D 9http://schemas.microsoft.com/winfx/2006/xaml/presentation    5   	   R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5   	   @d2http://schemas.microsoft.com/expression/blend/2008     5   	   Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     5   	   &localclr-namespace:WpfApp     5   	     � Title$  Window��5   	   $��443.5��6   $	��800��6'   .��5	      � -   5         �Name$ cancel��5	       � ColumnDefinitions 5
   
   �� 5      $
��107* �6   �� 5      $	��91* �6   .+�5   
   �� $i��cPlease select the Primary Org Entity to Keep.  The remaining orgs
will be merged into the primary.��6   $
��Left=�6�   $��
156,26,0,0q�6�   $	��Top=�6�    J� RenderTransformOrigin$ -0.026,0.045&�6�   $��59��6�   $	��496��6�   $��16(�6
  $��2��6  &   System.Windows.Controls.DataGrid  5   
   -   5        $��subGridData��5   O   $
��Left=�6   $	��234��6.   $��
42,102,0,0q�6;   $	��Top=�6b   $	��710��6z   $��2��6�      AutoGenerateColumns .     Columns 5      0  *System.Windows.Controls.DataGridTextColumn  5      ,  &System.Windows.Controls.DataGridColumn   Header$ Org Name��6%      MinWidth$	 150Q�6S   1  +System.Windows.Controls.DataGridBoundColumn   Binding 67   �� *	OrgName+6S     5      $ 	Address 1��6%   $	 200Q�6U    68   �� *
Address1+6U     5      $
 City��6%   $	 150Q�6L    63   �� *City+6L     5      $ State��6%   $	 100Q�6N    64   �� *State+6N     5      $	 Zip��6%   $ 50Q�6J    62   �� *Zip+6J   4  .System.Windows.Controls.DataGridCheckBoxColumn  5      $ Primary��6)   	   IsThreeState	 .   6:   �� *	Primary+
 �� Mode$
 TwoWay=� �� UpdateSourceTrigger$ PropertyChanged=�   	CellStyle 5      �� 5      .�5      -   5        5      5      5      �� 5   
   -   5         ��Name$ Merge��5      $��Merge Entities��6    $��1��69   $
��Left=�6I   $��215,361,0,0q�6d   $	��Top=�6y   $	��102��6�   $��28��6�   $��13(�6�   6�   �� 5    
   -   5        $ cancel1��5       $��Cancel��6"   $��1��63   $
��Left=�6C   $��
68,361,0,0q�6^   $	��Top=�6r   $	��103��6�   $��28��6�   6�   5"      5#      