   M S B A M L   `   `   `  ����A  =WpfApp, Version=1.0.0.0, Culture=neutral, PublicKeyToken=nullclr-namespace:WpfAppWpfApp  5   	       WpfApp.MainWindow   5   	   R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35W SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35\ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35D 9http://schemas.microsoft.com/winfx/2006/xaml/presentation    5   	   R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5   	   @d2http://schemas.microsoft.com/expression/blend/2008     5   	   Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     5   	   &localclr-namespace:WpfApp     5   	     � Title$  
MainWindow��5   	   $	��575��6   $��1379.6��6)   .��5	      �  � ColumnDefinitions 5
      �� 5      $
��645* �6   �� 5      $	��41* �6   .+�5      �� $��Search :��6
   $
��Left=�6   $��
274,47,0,0q�68   $	��Top=�6L   �� 5      $��
Org Type :��6
   $
��Left=�6   $��
261,84,0,0q�6:   $	��Top=�6N    J� RenderTransformOrigin$ 	-7.6,2.24&�6f   �� 5      -   5         ��Name$ clearFilter��5      $��Clear Filter��6    $
��Left=�67   $��
675,50,0,0q�6R   $	��Top=�6f   $��75��6~   $��23��6�   $ 0.473,0.842&�6�   6�   �� 5      -   5        $ merge��5      $��Merge��6   $
��Left=�6*   $��
998,50,0,0q�6E   $	��Top=�6Y   $��75��6q   $��23��6|   6�   �� 5      -   5         ��Name$ textBox��5      $
��Left=�6   $��23��68   $��
330,50,0,0q�6D    �� TextWrapping$
 Wrap=�6X   $	��Top=�6l   $	��309��6�   6�   �� 5      -   5         ��Name$ orgType��5      $
��Left=�6   $��
330,88,0,0q�69   $	��Top=�6M   $	��300��6e   6q   �� 5      $��
Sub Type :��6
   $
��Left=�6   $��
715,86,0,0q�6:   $	��Top=�6N   $��74��6f   �� 5      -   5        $ subType��5      $
��Left=�6   $��
789,88,0,0q�69   $	��Top=�6M   $	��303��6e   6q   &   System.Windows.Controls.DataGrid  5      -   5        $��grdData��5   �   $
��Left=�5      $	��366��5      $��
20,140,0,0q�5         AutoGenerateColumns .  $	��Top=�66   $
��1333��6N   $��2��6�   ��5      ��  �� Path$ itemCollection�	 � 	Resources	 5      )  #System.Windows.Controls.DataGridRow
 �� 
TargetType��%E   '        �� 5      "
  6   .�5      -   5        5      5          Columns 5!      4  .System.Windows.Controls.DataGridCheckBoxColumn  5"      ,  &System.Windows.Controls.DataGridColumn   Header$  ��6      MinWidth$ 30Q�6'      IsThreeState .  1  +System.Windows.Controls.DataGridBoundColumn   Binding 65   �� *	IsChecked+ �� Mode$ TwoWay=� �� UpdateSourceTrigger$ PropertyChanged=�   	CellStyle 5#      �� 5$      .�5%   	   -   5        5&   	   5(      0  *System.Windows.Controls.DataGridTextColumn  5)      $
 Type��6   $	 100Q�6@      
IsReadOnly .  6'   �� *Type+6O     5*      $ Sub Type��6   $	 150Q�6G    .  6+   �� *	SubType+6V     5+      $
 Name��6   $	 150Q�6C    .  6'   �� *	OrgName+6R     5,      $ 	Address 1��6   $	 150Q�6I    .  6,   �� *
Address1+6X     5-      $
 City��6   $	 150Q�6@    .  6'   �� *City+6O     5.      $	 Zip��6   $ 50Q�6>    .  6&   �� *Zip+6L     5/      $ Phone Number��6   $	 100Q�6I    .  6/   �� *Phone+6X     50      $ Contact Title��6   $	 100Q�6Q    .  60   �� *ContactTitle+6`     51      $ Contact First Name��6   $	 150Q�6Z    .  65   �� *ContactFirstName+6i     52      $ Contact Last Name��6   $	 150Q�6X    .  64   �� *ContactLastName+6g     53      $ Active��6   $ 40Q�6H    .  6-   �� *Active+6V   55      57      58      