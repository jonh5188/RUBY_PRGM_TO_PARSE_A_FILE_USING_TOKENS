class Parselex
    
    # list of possible valid tokens
    ValidTokens = [[/^[EOF]+/, :ENDOFFILE],
                  [/^[if]+/, :CONDITIONAL], [/^[ifelse]+/, :CONDITIONAL],
                  [/^[do]+/, :CONDITIONAL], [/^[while]+/, :CONDITIONAL],
                  [/^[then]+/, :CONDITIONAL],
                  [/^[A-Za-z_][A-Za-z_0-9]*/, :IDENTIFIER],
                  [/^[=]/, :ASSIGNMENT],
                  [/^[0-9]+/, :INTEGER],
                  [/^[+]/, :ADD],
                  [/^[*]/, :MULTIPLY],
                  [/^[-]/, :SUBTRACT],
                  [/^[;]/, :COMMENT],
                  [/^[(]/, :PARENTHESES], [/^[)]/, :PARENTHESES],
                  [/^[<][=]/, :LESSTHANOREQUAL],
                  [/^[<]/, :LESSTHAN],
                  [/^[>][=]/, :GREATERTHANOREQUAL],
                  [/^[>]/, :GREATERTHAN],
                  [/^[=][=]/, :ISEQUAL],
                  [/^[\\]/, :DIVIDE]]
    
    def getToken()
        File.open("sample1.txt", "r").each_line do |line| # read a file line by line
            
            line.lstrip! # remove whitespace from each line
            
            while !line.empty? # check for input on each line
                
                valid = false # is the token valid?
                
                ValidTokens.each do |term| # do the following for each token that exists
                    
                    # compare token
                    if value = term[0].match(line)
                        puts "#{term[1]}: (#{value[0]})"
                        # return the portion of the original value and remove whitespace
                        line = value.post_match().lstrip()
                        valid = true # the token is valid
                        
                        # if EOF is reached without errors, then file is correct
                        if value[0] == "EOF"
                            puts "End of file reached.  File is syntactically correct"
                        end
                        break
                        
                    end
                end
                
                # print the first invalid token found
                if !valid
                    raise "Invalid Token -> #{line}"
                end
            end
        end
    end
end

# Main
if __FILE__ == $0
    p = Parselex.new()
    p.getToken()
end

