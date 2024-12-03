import re

# Paste input data here
input_data = """"""
# Define the regex pattern to find mul(X, Y)
pattern = r"mul\((\d{1,3}),(\d{1,3})\)"

# Find all matches of the pattern
matches = re.findall(pattern, input_data)

# Print each pair in the format X,Y
for match in matches:
    print(f"{match[0]},{match[1]}")
