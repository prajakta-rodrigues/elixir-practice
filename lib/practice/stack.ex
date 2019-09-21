defmodule Practice.Stack do
  def push(x, stack) do
    [x | stack]
  end

  def peek([]) do
    nil
  end

  def peek(stack) do
    [head | tail] = stack
    head
  end


  def pop([]) do
    {nil, nil}
  end

  def pop([top|tail]) do
   {top, tail}
 end
end
