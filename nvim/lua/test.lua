local M = {}

print("Welcome")
A = 12
B = 13
print(A+B)

M.a = function ()
    local no = io.read("n")
    print(no+12)
end

M.fn = function ()
    print("This is a test")
end

return M
