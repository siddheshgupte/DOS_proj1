## DOS Project 1 - Finding perfect squares that are sums of consecutive squares on distributed Elixir nodes

### Group info
  Siddhesh Gupte(UFID 2975-1118) and Sagar Prabhu(UFID 8915-4951)

### Instructions

  * To run the program on a **single machine** use the command- *mix run proj1.exs arg1 arg2*, where arg1 is n and arg2 is k.
  For example, *mix run proj1.exs 40 24*

  * To run the program on **multiple machines**: 
    * First start the iex sessions on individual machines using ip address, name, and cookie. For example: *iex --name machine1@192.168.0.7 --cookie somecookie  -S mix*
      
    * Then establish a connection using the function *Node.connect/1* : *Node.connect :"machine2@192.168.0.5"* 
      
    * Finally to run the program in an iex session use: *Proj1.driver(n,k)*

### No. of machines
  The program has been tested on **3 machines**. 


iex(machine1@192.168.0.5)7> Proj1.driver(10000000, 50)
7, 245.0, machine3@192.168.0.6
28, 385.0, machine3@192.168.0.6
44, 495.0, machine3@192.168.0.6
67, 655.0, machine3@192.168.0.6
87, 795.0, machine3@192.168.0.6
124, 1055.0, machine3@192.168.0.6
168, 1365.0, machine3@192.168.0.6
287, 2205.0, machine3@192.168.0.6
379, 2855.0, machine3@192.168.0.6
1001139, 7079295.0, machine3@192.168.0.6
512, 3795.0, machine3@192.168.0.6
628, 4615.0, machine3@192.168.0.6
2714784, 19196595.0, machine3@192.168.0.6
843, 6135.0, machine3@192.168.0.6
1099, 7945.0, machine3@192.168.0.6
1792, 12845.0, machine3@192.168.0.6
2328, 16635.0, machine3@192.168.0.6
3103, 22115.0, machine3@192.168.0.6
3779, 26895.0, machine3@192.168.0.6
5032, 35755.0, machine3@192.168.0.6
6524, 46305.0, machine3@192.168.0.6
10563, 74865.0, machine3@192.168.0.6
13687, 96955.0, machine3@192.168.0.6
2096248, 14822885.0, machine3@192.168.0.6
18204, 128895.0, machine3@192.168.0.6
5835184, 41261155.0, machine2@192.168.0.7
22144, 156755.0, machine3@192.168.0.6
29447, 208395.0, machine3@192.168.0.6
38143, 269885.0, machine3@192.168.0.6
61684, 436345.0, machine3@192.168.0.6
1296547, 9168145.0, machine3@192.168.0.6
79892, 565095.0, machine3@192.168.0.6
106219, 751255.0, machine3@192.168.0.6
129183, 913635.0, machine3@192.168.0.6
4389227, 31036695.0, machine2@192.168.0.7
iex(machine1@192.168.0.5)8> 3609127, 25520555.0, machine2@192.168.0.7
iex(machine1@192.168.0.5)8> 171748, 1214615.0, machine3@192.168.0.6
iex(machine1@192.168.0.5)8> 222432, 1573005.0, machine3@192.168.0.6
iex(machine1@192.168.0.5)8> 359639, 2543205.0, machine3@192.168.0.6
iex(machine1@192.168.0.5)8> 465763, 3293615.0, machine3@192.168.0.6
iex(machine1@192.168.0.5)8> 7556948, 53435865.0, machine1@192.168.0.5
iex(machine1@192.168.0.5)8> 619208, 4378635.0, machine3@192.168.0.6
iex(machine1@192.168.0.5)8> 753052, 5325055.0, machine3@192.168.0.6

where the output is in the format *start_number, square_number, Node.self*
### Performance
  * To determine the size of the work unit, we first computed a list of integers which perfectly divides the input n. Then we checked the ratio-CPU time/Real time at various indices of the list, and for different inputs. We found that the ratio is highest at 3/4th position in the list. For n= 1000000, the 3/4th position in the list and hence the size of work unit is 15625. 

  * There are no sequence of numbers for input n=1000000 and k=4 which satisfies the requirement. Hence on running the command *mix run proj1.exs 1000000 4*, there is no output.

  * *time mix run proj1.exs 1000000 4*
    Compiling 1 file (.ex)
    [
      ok: #PID<0.130.0>,
      ok: #PID<0.131.0>,
      ok: #PID<0.132.0>,
      ok: #PID<0.133.0>,
      ok: #PID<0.134.0>,
      ok: #PID<0.135.0>,
      ok: #PID<0.136.0>,
      ok: #PID<0.137.0>,
      ok: #PID<0.138.0>,
      ok: #PID<0.139.0>,
      ...
    ]
    real    0m1.067s
    user    0m2.527s
    sys     0m0.128s

    Total CPU time / Real time = 2.527s/1.067s = 2.368

  * The largest problem we managed to solve is for n=10000000 and k=50 . 

### Specific requirements 
  The program makes use of the function *find_best_task_division(n)* inorder to find the optimal no. of divisions of n. The function computes a list and return the value at 3/4th postion as mentioned in the performance section above. The default no. of divisions in proj1.exs is 4. Hence inorder to run smaller inputs like n=3 k=2 , first run *Proj1.find_best_task_division(n)*. Enter the output at line 37 of proj1.ex and then run the program.
