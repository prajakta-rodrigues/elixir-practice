defmodule Practice.Calc do
  def parse_float(text) do
    {num, _} = Float.parse(text)
    num
  end

  def calc(expr) do
    # This should handle +,-,*,/ with order of operations,
    # but doesn't need to handle parens.
    # expr
    # |> String.split(~r/\s+/)
    # |> hd
    # |> parse_float
    expr = String.split(expr)
    calculate(expr, [], [])


    # Hint:
    # expr
    # |> split
    # |> tag_tokens  (e.g. [+, 1] => [{:op, "+"}, {:num, 1.0}]
    # |> convert to postfix
    # |> reverse to prefix
    # |> evaluate as a stack calculator using pattern matching
  end

  def precedence(op) do
    cond do
      op == "+" or op == "-" -> 1
      op == "*" or op == "/" -> 2
      true -> 0
    end
  end

  def evaluate(a, b, op) do
    cond do
      op == "+" -> to_string(parse_float(a) + parse_float(b))
      op == "-" -> to_string(parse_float(a) - parse_float(b))
      op == "*" -> to_string(parse_float(a) * parse_float(b))
      op == "/" -> to_string(parse_float(a) / parse_float(b))
      true -> :error
    end
  end

  def calculate(list, values, operators) do

    if (list == []) do
      cond do
        operators == [] ->
          {result, values} = Practice.Stack.pop(values)
          {final, _} = Integer.parse(result)
          final
        true ->
          {b, values} = Practice.Stack.pop(values)
          {a, values} = Practice.Stack.pop(values)
          {op, operators} = Practice.Stack.pop(operators)
          values = Practice.Stack.push(evaluate(a, b, op), values)
          calculate([], values, operators)
        end
    else
      [head | tail] = list
      cond do
        head |> Integer.parse == :error ->
          cond do
            precedence(head) < precedence(Practice.Stack.peek(operators)) ->
              {b, values} = Practice.Stack.pop(values)
              {a, values} = Practice.Stack.pop(values)
              {op, operators} = Practice.Stack.pop(operators)
              values = Practice.Stack.push(evaluate(a, b, op), values)
              operators = Practice.Stack.push(head, operators)
              calculate(tail, values, operators)
            true ->
              operators = Practice.Stack.push(head, operators)
              calculate(tail, values, operators)
          end
        true ->
          values = Practice.Stack.push(head, values)
          calculate(tail, values , operators)
      end
    end
  end



  def factor(x) do
    # factors of x
    factors(x, [], 2)
  end

  def factors(x, list, divisor) do
    cond do
      x < divisor -> list
      rem(x, divisor) == 0 ->
        [divisor | factors(div(x, divisor), list, divisor)]
      true -> factors(x, list, divisor + 1)
    end
  end

end
