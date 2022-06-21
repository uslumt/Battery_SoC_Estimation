**Authors**  
[Xuetian Shi](https://github.com/xuetians),  [Mert Alagözlü](https://github.com/mertalagozlu),  [Muhammet USLU](https://github.com/uslumt) @ USI

# Battery_SoC_Estimation
Nowadays most of the BEVs manufacturers use Li-Ion based batteries which takes the biggest portion of vehicle architecture. Those Electronic components need to be controlled, diagnosed and monitored by some sophisticated systems so called Battery Management Systems (BMS).
Our research on this topic showed that prognostics is one of the most important function of BMS and we found out that some of scientific works proposed that Random/Stochastic Methods have promising results from such as Random Forests comparison to physical models.

Here we implemented several Stochastic Methods and Machine Learning algorithms on  [Li-ion battery dataset from NASA](https://ti.arc.nasa.gov/tech/dash/groups/pcoe/prognostic-data-repository/) for comparison.






## Results 
|   | COARSE TREE | MEDIUM TREE  | **FINE TREE** | BAGGED TREE  | BOOSTED TREE | LINEAR REGRESSION  | **LINEAR REGRESSION STEPWISE** | LSVM  | QSVM | CSVM  | **RANDOM FOREST** |  NEURAL NETWORKS  |
| ------------- | ------------- | ------------- | ------------- | ------------- | ------------- | ------------- | ------------- | ------------- | ------------- |  ------------- |  ------------- |  ------------- |  
| RMSE  |  0.0728 | 0.0260  | **0.0168** | 0.0176  | 0.0674 | 0.0231  | **0.0166** | 0.0241  | 0.0232 | 0.0253  | **0.0188** |  0.0707  |
| Training Time (sec) | 0.613 | 0.629 | 0.643 | 1.584 | 1.089 | 4.464 |  8.725 | 8.484 | 8.306 | 7.952 | 6.743 | 5.60 | 
| Prediction Speed |  19000 | 22000  | 18000 | 4900  | 4900 | 2100  | 2300 | 9500  | 9400 | 9100  | 5427 |  6250  |

  
