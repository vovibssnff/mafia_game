import matplotlib.pyplot as plt
import numpy as np
import os

count = 0

def show_graphics_1(X, Y, Z):
    global count
    count += 1
    fig = plt.figure(figsize=(21, 11))
    ax1 = fig.add_subplot(projection='3d')
    zeros = np.zeros_like(Z)  # Array of zeros matching the size of Z
    # Define colormap with gradient effect
    colors = plt.cm.ocean(Z / np.max(Z))
    # Create wireframe plot with shaded gradient effect
    ax1.bar3d(X, Y, zeros, 1, 1, Z, shade=True, color=colors)
    ax1.set_xlabel('N')
    ax1.set_ylabel('M')
    ax1.set_zlabel('Winning probability')
    if count == 1:
        ax1.set_title('Mafia winning probability without doctor')
        plt_1 = './game/qml/plot1.png'
        if os.path.isfile(plt_1):
            os.remove(plt_1)
        plt.savefig(plt_1)
        print(count)
        plt.close()
    
    if count == 2:
        ax1.set_title('Mafia winning probability with doctor')
        plt_2 = './game/qml/plot2.png'
        if os.path.isfile(plt_2):
            os.remove(plt_2)
        plt.savefig(plt_2)
        print(count)
        plt.close()
        count = 0


def show_graphics_3(n, m, diffs):
    fig = plt.figure()
    ax = fig.add_subplot(111, projection='3d')

    # Define colormap with gradient effect
    colors = plt.cm.ocean(diffs / np.max(diffs))

    # Scatter plot with color mapping
    ax.scatter(n, m, diffs, c=colors)

    # Set labels and title
    ax.set_xlabel('N')
    ax.set_ylabel('M')
    ax.set_zlabel('Difference')
    plt.title('Difference in chances for equal N, M, and different D')

    plt.savefig('./game/qml/plot3.png', dpi=200)

