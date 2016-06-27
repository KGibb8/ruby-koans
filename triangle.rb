# Triangle Project Code.

# Triangle analyzes the lengths of the sides of a triangle
# (represented by a, b and c) and returns the type of triangle.
#
# It returns:
#   :equilateral  if all sides are equal
#   :isosceles    if exactly 2 sides are equal
#   :scalene      if no sides are equal
#
# The tests for this method can be found in
#   about_triangle_project.rb
# and
#   about_triangle_project_2.rb
#

def triangle(a, b, c)
  a, b, c = [a, b, c].sort  # sorts a, b, c --> a = shortest, c = longest
  begin
    raise TriangleError if a <= 0 || a + b <= c # Error if a <= 0, Error if two shortest sides <= longest side
    [nil, :equilateral, :isosceles, :scalene][[a, b, c].uniq.count]
    # [a, b, c].uniq.count returns 1 if no sides unique, 2 if 1 side unique, 3 if all sides unique
    # then accesses array [nil, :equilateral, :isosceles, :scalene] with relevant index
  end
end

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end
