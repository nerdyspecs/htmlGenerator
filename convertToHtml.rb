def convert_to_html(input)
    opened_tags = [] #stores opened_tags and spaces[tags,space]
    result = ""

    input.each_line do |line|
        next if line.strip == ""
        spaces = line.index(/[^ ]/) || 0
        data = line.strip.split(" ", 2)
        tag = data[0]
        content = data[1] || ""
        
        #check do i need to clsoe any existing tags before opening new ones.
        while opened_tags.any? && opened_tags.last[1] >= spaces
          last_tag, last_space = opened_tags.pop
          result += " " * last_space + "</#{last_tag}>\n"
        end
        
        #open new tag, and store it into the stack.
        result += " " * spaces + "<#{tag}>\n"
        opened_tags << [tag,spaces]
        
        #insert content
        if content && !content.strip.empty?
            result += " " * (spaces + 1) + content.strip + "\n"
        end
    end
    
    #close any remaining tags.
    while opened_tags.any?
        last_tag, last_space = opened_tags.pop
        result += " "* last_space + "</#{last_tag}>\n"
    end
    
    return result
end


input = <<~TEXT
  table
    thead
      tr
        td Heading 1
        td Heading 2
    tbody
      tr
        td Body 1
        td Body 2
TEXT

puts convert_to_html(input)
