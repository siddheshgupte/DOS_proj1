## DOS Project 1 - Finding perfect squares that are sums of consecutive squares on distributed Elixir nodes

### Group info
  Siddesh Gupte(UFID 2975-1118)
  Sagar Prabhu(UFID 8915-4951)

### Instructions

  * To run the program on a **single machine** use the command- *mix run proj1.exs arg1 arg2*, where arg1 is n and arg2 is k.
  For example, *mix run proj1.exs 40 24*

  * To run the program on **multiple machines**, first start the iex sessions on individual machines using ip address, name, and cookie.
  For example: *iex --name machine1@192.168.0.7 --cookie somecookie  -S mix*

  Then establish a connection using the function *Node.connect/1* :
  *Node.connect :"machine2@192.168.0.5"* 

  Finally to run the program in an iex session use:
  *Proj1.driver(n,k)*

### No. of machines
  The program has been tested on 3 machines. 

### Performance
  * To determine the size of the work unit, we first computed a list of integers which perfectly divides the input n. Then we checked the ratio-CPU time/Real time at various indices of the list, and for differnt inputs. We found that the ratio is highest at 3/4th position in the list. For n= 1000000, the 3/4th position in the list and hence the size of work unit is 15625. 

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

    No. of Cores = Total CPU time / Real time
                 = 2.527s/1.067s
                 = 2.368

  * The larget problem we managed to solve is for n= and k= .  
