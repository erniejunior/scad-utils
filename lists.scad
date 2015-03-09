// List helpers

/*!
  Flattens a list one level:

  flatten([[0,1],[2,3]]) => [0,1,2,3]
*/
function flatten(list) = [ for (i = list, v = i) v ];


/*!
  Creates a list from a range:

  range([0:2:6]) => [0,2,4,6]
*/
function range(r) = [ for(x=r) x ];

/*!
  Reverses a list:

  reverse([1,2,3]) => [3,2,1]
*/
function reverse(list) = [for (i = [len(list)-1:-1:0]) list[i]];

/*!
  Extracts a subarray from index begin (inclusive) to end (exclusive)
  FIXME: Change name to use list instead of array?

  subarray([1,2,3,4], 1, 2) => [2,3]
*/
function subarray(list,begin=0,end=-1) = [
    let(end = end < 0 ? len(list) : end)
      for (i = [begin : 1 : end-1])
        list[i]
];

/*!
  Returns a copy of a list with the element at index i set to x

  set([1,2,3,4], 2, 5) => [1,2,5,4]
*/
function set(list, i, x) = [for (i_=[0:len(list)-1]) i == i_ ? x : list[i_]];

/*!
  Moves all values in the list one position to the right. The rightmost goes first
  
  shift_right([1, 2, 3, 4]) => [4, 1, 2, 3]
 */
function shift_right(list) = 
            [for (i = [0:len(list)-1]) 
                list[(i == 0 ? len(list)-1 : i-1 )]
            ];
/*!
  Moves all values in the list 'distance' positions to the right. Rightmost items are inserted at the beginning
  TODO: This is probably a stupid and slow implementation!
  
  shift_right_d(["a", "b", "c", "d", "e"],2) => ["d", "e", "a", "b", "c"]
*/	    
function shift_right_d(list, distance=1) = distance == 0 ? list : shift_right_d(shift_right(list), distance -1);
/*!
  Computes the sum over the elements of the list
  Works for scalars, vectors and matrecies
  
  sum([1, 2, 3, 4, 5]) => 15
  sum([[1, 1], [2, 2]]) => [3, 3]
*/
function sum(list) = len(list) == 0 ? undef : sum0(list, 0, list[0]*0);

function sum0(list, pos, tmp_sum) = pos == len(list) ? tmp_sum : sum0(list, pos+1, tmp_sum + list[pos]);

/*!
  Returns the index of the minimal (scalar) value in the list
  
  min_item_pos([-22, -50, -2]) => 1
*/
function min_item_pos(list) = len(list) == 0 ? undef : min_item_pos0(list, 0, 0);

function min_item_pos0(list, pos, min_pos) = pos == len(list) ? min_pos : min_item_pos0(list, pos+1, list[pos] < list[min_pos] ? pos : min_pos);