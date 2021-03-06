# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: jripoute <jripoute@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2015/02/28 01:22:02 by jripoute          #+#    #+#              #
#    Updated: 2015/03/01 23:34:15 by jripoute         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

DEBUG	= yes
ifeq ($(DEBUG),no)
	FLAGS=-Wall -Wextra -Werror
else
	FLAGS= -g
endif
NAME	= game_2048
LDFLAGS	= -I./include/ -I./libft/include/
SRC		= \
			main.c menu.c displays.c displays2.c hook.c check.c \
			displays3.c check_resize_win.c exit.c error.c \
			gen_new.c display_edges.c display_loose.c inits.c moves.c \
			check_win_val.c
OBJ		= $(SRC:.c=.o)
SRCDIR	= ./src/
OBJDIR	= ./obj/
INCDIR	= ./include/
SRCS	= $(addprefix $(SRCDIR), $(SRC))
OBJS	= $(addprefix $(OBJDIR), $(OBJ))
INCS	= $(addprefix $(INCDIR), $(INC))

all: $(NAME)

$(NAME): $(OBJS) $(INCS)
	@gcc $(FLAGS) -o $@ $^ -L./libft/ -lft -lncurses -lform -g
	@echo "\\033[1;32mSuccess.\\033[0;39m"

$(OBJS): $(SRCS)
ifeq ($(DEBUG),yes)
	@echo "\\033[1;31mDEBUG COMPILATION.. (no flags except -g)\\033[0;39m"
else
	@echo "\\033[1;31mCompilation with -Wall -Wextra -Werror...\\033[0;39m"
endif
	make -C libft/
	@echo "\\033[1;34mGenerating objects... Please wait.\\033[0;39m"
	@gcc $(FLAGS) -c $(SRCS) $(LDFLAGS)
	@mkdir -p $(OBJDIR)
	@mv $(OBJ) $(OBJDIR)

.PHONY: clean fclean re

clean:
	@echo "\\033[1;34mDeleting objects...\\033[0;39m"
	@rm -f $(OBJS)

fclean: clean
	make fclean -C libft/
	@echo "\\033[1;34mDeleting $(NAME)\\033[0;39m"
	@rm -f $(NAME)

re: fclean all
