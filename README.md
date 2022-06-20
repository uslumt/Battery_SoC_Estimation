**Authors**  
[Xuetian Shi](https://github.com/xuetians),  [Mert Alagözlü](https://github.com/mertalagozlu),  [Muhammet USLU](https://github.com/uslumt) @ USI

# Battery_SoC_Estimation
Nowadays most of the BEVs manufacturers use Li-Ion based batteries which takes the biggest portion of vehicle architecture. Those Electronic components need to be controlled, diagnosed and monitored by some sophisticated systems so called Battery Management Systems (BMS).
Our research on this topic showed that prognostics is one of the most important function of BMS and we found out that some of scientific works proposed that Random/Stochastic Methods have promising results from such as Random Forests comparison to physical models.

Here we implemented several Stochastic Methods and Machine Learning algorithms on  [Li-ion battery dataset from NASA](https://ti.arc.nasa.gov/tech/dash/groups/pcoe/prognostic-data-repository/) for comparison.





\begin{table}[htb!]
\centering
\resizebox{\columnwidth}{!}{%
\begin{tabular}{|c|c|c|c|c|c|c|c|c|c|c|c|c|}
\hline
\textbf{} &
  \textbf{COARSE TREE} &
  \textbf{MEDIUM TREE} &
  \textbf{FINE TREE} &
  \textbf{BAGGED TREE} &
  \textbf{BOOSTED TREE} &
  \textbf{LINEAR REGRESSION} &
  \textbf{LINEAR REGRESSION STEPWISE} &
  \textbf{LSVM} &
  \textbf{QSVM} &
  \textbf{CSVM} &
  \textbf{RANDOM FOREST} &
  \textbf{NEURAL NETWORKS} \\ \hline
RMSE &
  0.0728 &
  0.0260 &
  \textbf{0.0168} &
  0.0176 &
  0.0674 &
  0.0231 &
  \textbf{0.0166} &
  0.0241 &
  0.0232 &
  0.0253 &
  0.0188 &
  0.0707 \\ \hline
Training Time (sec) &
  \textbf{0.613} &
  0.629 &
  \textbf{0.643} &
  1.584 &
  1.089 &
  4.464 &
  8.725 &
  8.484 &
  8.306 &
  7.952 &
  6.743 &
  5.60 \\ \hline
\begin{tabular}[c]{@{}c@{}}Prediction Speed\\ (obs/sec)\end{tabular} &
  \textbf{19000} &
  22000 &
  \textbf{18000} &
  4900 &
  4900 &
  2100 &
  2300 &
  9500 &
  9400 &
  9100 &
  66,567 &
  6250 \\ \hline
\begin{tabular}[c]{@{}c@{}}Hyper-\\ parameters\end{tabular} &
  \begin{tabular}[c]{@{}c@{}}-Min. Leaf size: 36\\ -No surrogate splits\end{tabular} &
  \begin{tabular}[c]{@{}c@{}}-Min. Leaf size: 12\\ -No surrogate splits\end{tabular} &
  \begin{tabular}[c]{@{}c@{}}-Min. Leaf size: 4\\ -No surrogate splits\end{tabular} &
  \begin{tabular}[c]{@{}c@{}}-Min. leaf size: 8\\ -\# of learners: 30\end{tabular} &
  \begin{tabular}[c]{@{}c@{}}-Min. leaf size: 8\\ -\# of learners: 30\\ - Learning rate: 0.1\end{tabular} &
  -Linear &
  \begin{tabular}[c]{@{}c@{}}-Max. \# of steps: 1000\\ -Linear\end{tabular} &
  \begin{tabular}[c]{@{}c@{}}-Linear Kernel function\\ -Standardize data\end{tabular} &
  \begin{tabular}[c]{@{}c@{}}-Quadratic kernel function\\ -Standardize data\end{tabular} &
  \begin{tabular}[c]{@{}c@{}}-Cubic kernel function\\ -Standardize data\end{tabular} &
  \begin{tabular}[c]{@{}c@{}}Automatically tuned parameters during training\\
  learning rate : 0.18482 \\Number of predictors to sample : 6 \\Ensemble method: Bagging\end{tabular} &
  \begin{tabular}[c]{@{}c@{}}-Adam\\ -ReLU\\ -Back Propagation\\ -Learning rate: 1e-4\\ - Epochs: 1000\end{tabular} \\ \hline
\end{tabular}%
}
\caption{Final Results}
\label{table:3}
\end{table}

  


