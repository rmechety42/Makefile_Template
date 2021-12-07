NAME		=	push_swap

# --   Directory   -- #
OBJ_DIR     =	objs

OBJ_SUB_DIR =	array\
moves_utils\
engine\
engine/execution\
engine/ft_eval\
insts_utils\
stack_utils\
utils\
errors\
save_utils\

OBJ_TO_CREATE = $(addprefix $(OBJ_DIR)/, $(OBJ_SUB_DIR))

INC_DIR		=	inc

# --  Search All files in SRCS  -- #
SRC_DIR = src

SRCSS =	src/main.c\



SRCS = $(SRCSS:src/%.c=%.c)


# --  Redirection in OBJS  -- #
OBJS = $(addprefix $(OBJ_DIR)/, $(SRCS:%.c=%.o))

CC			=	clang
CFLAGS      =   -Wall -Wextra -Werror

PARAM = 

#Mandatory rules

all : header
	@mkdir -p $(OBJ_TO_CREATE)
	@make $(NAME) --no-print-directory

$(NAME): $(OBJS)
	@$(CC) $(CFLAGS) -o $(NAME) $(OBJS)

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c
	@$(CC) $(CFLAGS) -o $@ -c $< -I $(INC_DIR)

clean:
	rm -rf $(OBJ_DIR)

fclean: clean
	rm -f $(NAME)

re: fclean all


#My personal rules


git :
	git add --all
	git commit
	git push

get_src:
		@find src -type f -name "*.c" | tr "\n" "|" | sed -r 's/["|"]+/\\ \n/g'

run: all
	./$(NAME) $(PARAM)

leaks: all
	 valgrind --tool=memcheck --leak-check=full --show-leak-kinds=all --leak-resolution=high --show-reachable=yes --trace-children=yes --verbose --log-file=valgrind.log ./push_swap 10 9 8 7 6 5

get_dir:
		@find src -type d | tr "\n" "|" | sed -r 's/["|"]+/\\ \n/g' | sed -e 's/src\///g'

header :
	@Headermaker src inc/prototypes.h -inc structs define


.PHONY: all clean fclean re