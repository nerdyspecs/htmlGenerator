# Indentation-Based HTML Templating Parser

## Overview

This simple Ruby function parses an indented template structure and converts it into valid, well-nested HTML.  
It is designed to make writing HTML (especially for common, nested structures like tables) more readable and maintainable in plain text format.

By using indentation to represent parent-child relationships, the parser eliminates the need for manual closing tags and complex nesting.

---

## How It Works

- Indentation is calculated by counting the number of leading **spaces** on each line.
- More indentation implies deeper nesting (a child tag).
- When a line is less indented than the previous, it closes the necessary tags to maintain proper hierarchy.
- Tags and content are split by the first space only — everything after the tag is treated as content.

---

## Things to Consider

- Different editors may use different indentation widths (2 spaces, 4 spaces, etc.).  
  This parser uses the **number of leading spaces** to determine depth, not fixed levels.
- Whitespace consistency matters — mixing tabs and spaces may cause unexpected results.
- Only supports basic tags and inline content. Attributes and self-closing tags are not supported in this version.

---

## Examples

### Input 1 (More spaces per indent)
```text
table
  thead
    tr
      td Heading 1
      td Heading 2
  tbody
    tr
      td Body 1
      td Body 2
```
### Input 2 (Less space per indent)
```text
table
 thead
  tr
   td Heading 1
   td Heading 2
 tbody
  tr
   td Body 1
   td Body 2
```
## Output
The output should yield similar result, for the function uses the number of spaces to determine the level of the element in the nest.

## Limitations
This function is limited to a simple format where by the elements are by "tags content". This would result in a breakage when the in put is as below, as the function expects any content to be behind of a tag.:
### Limitation 1
tr
  td
    Content1
### Output 1
<tr>
  <td>
    <Content1>
    </Content1>
  </td>
</td>

Besides that, there is no validation of tags. The function only treats any line of input, whereby after split by an empty space, the first position is the tag, and the remainding is the content. There is no validation for any typos in tags.
### Limitation 2
tr
 tb Content1
### Output 1
<tr>
  <tb>
    Content1
  </tb>
<tr>

