def ks(Y_prob, Y, y_test):
    final = pd.DataFrame(data = Y_prob, columns= ['% N','%I'])
    final['Y'] = Y
    y_array = np.array(y_test)
    final['BAD'] =  y_array
    final.loc[final['BAD'] == 0, 'GOOD'] = 1
    final.loc[final['BAD'] == 1, 'GOOD'] = 0
    final.sort_values(by = '%I', inplace = True)
    final.reset_index(drop = True, inplace = True)
    final['#BAD'] = final['BAD'].cumsum()
    final['#GOOD'] = final['GOOD'].cumsum()
    percentGood = final.GOOD[final['GOOD'] == 1].count()
    percentBad = final.BAD[final['BAD'] == 1].count()
    final['%BAD'] = final['#BAD'].map(lambda x: x / percentBad)
    final['%GOOD'] = final['#GOOD'].map(lambda x: x / percentGood)
    final['DIF'] = final['%GOOD'] - final['%BAD']   
    KS = final['DIF'].max() * 100
    return KS
