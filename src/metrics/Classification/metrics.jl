export classification_report, condition_positive, condition_negative, predicted_positive,predicted_negative, correctly_classified, incorrectly_classified, sensitivity_score, recall_score, specificity_score, precision_score, positive_predictive_value, accuracy_score, balanced_accuracy_score, negative_predictive_value, false_negative_rate, false_positive_rate, false_discovery_rate, false_omission_rate, f1_score, prevalence_threshold, threat_score, matthews_correlation_coeff, fowlkes_mallows_index, informedness, markedness, cohen_kappa_score, hamming_loss, jaccard_score, confusion_params

using Statistics: mean

"""
```classification_report(c::confusion_matrix;<keyword arguments>)```

Return all the values listed below if `return_dict` is true. Else, write the values to the given IO element.

Returned dictionary:
```
    "true-positives" => c.true_positives
    "false-positives" => c.false_positives
    "true-negatives" => c.true_negatives
    "false-negatives" => c.false_negatives
    "condition-positive" => condition_positive(c)
    "condition-negative" => condition_negative(c)
    "predicted-positive" => predicted_positive(c)
    "predicted-negative" => predicted_negative(c)
    "correctly-classified" => correctly_classified(c)
    "incorrectly-classified" => incorrectly_classified(c)
    "sensitivity" => sensitivity_score(c)
    "specificity" => specificity_score(c)
    "precision" => precision_score(c)
    "accuracy-score" => accuracy_score(c)
    "balanced Accuracy" => balanced_accuracy(c)
    "positive-predictive-value" =>  positive_predictive_value(c)
    "negative-predictive-value" => negative_predictive_value(c)
    "false-negative-rate"  => false_negative_rate(c)
    "false-positive-rate"  => false_positive_rate(c)
    "false-discovery-rate" => false_discovery_rate(c)
    "false-omission-rate"  => false_omission_rate(c)
    "f1-score" => f1_score(c)
    "prevalence-threshold" => prevalence_threshold(c)
    "threat-score" => threat_score(c)
    "matthews-correlation-coefficient" => matthews_correlation_coeff(c)
    "fowlkes-mallows-index" => fowlkes_mallows_index(c)
    "informedness" => informedness(c)
    "markedness" => markedness(c)
    "jaccard-score-nonaverage" => jaccard_score(c, average = nothing)
    "jaccard-score-microaverage" => jaccard_score(c, average = "micro")
    "hamming-loss" => hamming_loss(c)
    "cohen-kappa-score" => cohen_kappa_score(c)
```

For a sample output to the given IO element, see Example section.

## Keywords

    \n**`io`** : ::IO, default = Base.stdout
    \n\tIO element to write to

    \n**`return_dict`** : default = false
    \n\tReturn a dictionary as specified below if true; print the values specified below if false

    \n**`target_names`** : vector-like, default = nothing
    \n\tIf not nothing, replace the labels of the given confusion matrix object whilst printing

    \n**`digits`** : Int, default = 2
    \n\tDetermines how the rounding procedure will be digitized. If `return_dict` is true, this will be ignored and the values
    will be placed into the dictionary with full precision

## Example

```julia-repl

julia> y_true = [1,1,1,2,3,3,1,2,1,1,2,1];

julia> y_pred = [1,3,2,1,2,3,1,1,2,3,2,1];

julia> x = confusion_matrix(y_true, y_pred)
┌ Warning: No labels provided, constructing a label set by union of the unique elements in Expected and Predicted arrays
└ @ Path
julia> classification_report(x)
Summary:
confusion_matrix
True Positives: [3, 1, 1]
False Positives: [2, 3, 2]
True Negatives: [3, 6, 8]
False Negatives: [4, 2, 1]

Labelwise Statistics

                                  1    2    3
           Condition Positive:  7.0  3.0  2.0
           Condition Negative:  5.0  9.0 10.0
           Predicted Positive:  5.0  4.0  3.0
           Predicted Negative:  7.0  8.0  9.0
         Correctly Classified:  6.0  7.0  9.0
       Incorrectly Classified:  6.0  5.0  3.0
                  Sensitivity: 0.43 0.33  0.5
                  Specificity:  0.6 0.67  0.8
                    Precision:  0.6 0.25 0.33
               Accuracy Score:  0.5 0.58 0.75
            Balanced Accuracy: 0.51  0.5 0.65
    Negative Predictive Value: 0.43 0.75 0.89
          False Negative Rate: 0.57 0.67  0.5
          False Positive Rate:  0.4 0.33  0.2
         False Discovery Rate:  0.4 0.33  0.2
          False Omission Rate: 0.57 0.25 0.11
                     F1 Score:  0.5 0.29  0.4
                Jaccard Score: 0.33 0.17 0.25
┌ Warning: Zero division, replacing NaN or Inf with 0
└ @ Main Path
         Prevalence Threshold:16.73  Inf 1.05
                 Threat Score: 0.33 0.17 0.25
Matthews Correlation Coefficient 0.03  0.0 0.26
        Fowlkes Mallows Index: 0.51 0.29 0.41
                 Informedness: 0.03  0.0  0.3
                   Markedness:-0.74-0.81 -0.7

General Statistics

              Accuracy Score:   0.1527777777777778
           Cohen Kappa Score:   0.07692307692307698
                Hamming Loss:   0.5833333333333334
               Jaccard Score:   0.2631578947368421
```
"""
function classification_report(c::confusion_matrix; io::IO = Base.stdout, return_dict = false, target_names = nothing, digits = 2)
    if return_dict
        result_dict = Dict()
        result_dict["true-positives"] = c.true_positives
        result_dict["false-positives"] = c.false_positives
        result_dict["true-negatives"] = c.true_negatives
        result_dict["false-negatives"] = c.false_negatives
        result_dict["condition-positive"] = condition_positive(c)
        result_dict["condition-negative"] = condition_negative(c)
        result_dict["predicted-positive"] = predicted_positive(c)
        result_dict["predicted-negative"] = predicted_negative(c)
        result_dict["correctly-classified"] = correctly_classified(c)
        result_dict["incorrectly-classified"] = incorrectly_classified(c)
        result_dict["sensitivity"] = sensitivity_score(c)
        result_dict["specificity"] = specificity_score(c)
        result_dict["precision"] = precision_score(c)
        result_dict["accuracy-score"] = accuracy_score(c)
        result_dict["balanced Accuracy"] = balanced_accuracy_score(c)
        result_dict["positive-predictive-value"] =  positive_predictive_value(c)
        result_dict["negative-predictive-value"] = negative_predictive_value(c)
        result_dict["false-negative-rate"]  = false_negative_rate(c)
        result_dict["false-positive-rate"]  = false_positive_rate(c)
        result_dict["false-discovery-rate"] = false_discovery_rate(c)
        result_dict["false-omission-rate"]  = false_omission_rate(c )
        result_dict["f1-score"] = f1_score(c)
        result_dict["prevalence-threshold"] = prevalence_threshold(c)
        result_dict["threat-score"] = threat_score(c)
        result_dict["matthews-correlation-coefficient"] = matthews_correlation_coeff(c)
        result_dict["fowlkes-mallows-index"] = fowlkes_mallows_index(c)
        result_dict["informedness"] = informedness(c)
        result_dict["markedness"] = markedness(c)
        result_dict["jaccard-score-nonaverage"] = jaccard_score(c, average = nothing)
        result_dict["jaccard-score-microaverage"] = jaccard_score(c, average = "micro")
        result_dict["hamming-loss"] = jaccard_score(c)
        result_dict["cohen-kappa-score"] = cohen_kappa_score(c)
        return result_dict
    else
        labels = target_names != nothing && length(target_names) == length(c.Labels) ? target_names : c.Labels
        len = maximum([length(string(i)) for i in labels])
        label_size = length(c.Labels)
        label_len = len + digits + 2
        println(io,"Summary:\n", summary(c))
        println(io,"True Positives: ", c.true_positives)
        println(io,"False Positives: ", c.false_positives)
        println(io,"True Negatives: ", c.true_negatives)
        println(io,"False Negatives: ", c.false_negatives)
        println(io,"\n",lpad("Labelwise Statistics", label_len * Int(round(size(c.matrix)[1] / 2)+1)), "\n")
        println(io,lpad(" ", 30), [lpad(i, label_len) for i in labels]...)
        println(io,lpad("Condition Positive:", 30), [lpad(round(i, digits = digits), label_len) for i in condition_positive(c)]...)
        println(io,lpad("Condition Negative:", 30), [lpad(round(i, digits = digits), label_len) for i in condition_negative(c)]...)
        println(io,lpad("Predicted Positive:", 30), [lpad(round(i, digits = digits), label_len) for i in predicted_positive(c)]...)
        println(io,lpad("Predicted Negative:", 30), [lpad(round(i, digits = digits), label_len) for i in predicted_negative(c)]...)
        println(io,lpad("Correctly Classified:", 30), [lpad(round(i, digits = digits), label_len) for i in correctly_classified(c)]...)
        println(io,lpad("Incorrectly Classified:", 30), [lpad(round(i, digits = digits), label_len) for i in incorrectly_classified(c)]...)
        println(io,lpad("Sensitivity:", 30), [lpad(round(i, digits = digits), label_len) for i in sensitivity_score(c)]...)
        println(io,lpad("Specificity:", 30), [lpad(round(i, digits = digits), label_len) for i in specificity_score(c)]...)
        println(io,lpad("Precision:", 30) , [lpad(round(i, digits = digits), label_len) for i in precision_score(c)]...)
        println(io,lpad("Accuracy Score:", 30 ) ,  [lpad(round(accuracy_score(c, ith_class = i), digits = digits), label_len) for i in 1:label_size]...)
        println(io,lpad("Balanced Accuracy:", 30), [lpad(round(i, digits = digits), label_len) for i in balanced_accuracy_score(c)]...)
        println(io,lpad("Negative Predictive Value:", 30), [lpad(round(i, digits = digits), label_len) for i in negative_predictive_value(c)]...)
        println(io,lpad("False Negative Rate:", 30), [lpad(round(i, digits = digits), label_len) for i in false_negative_rate(c)]...)
        println(io,lpad("False Positive Rate:", 30), [lpad(round(i, digits = digits), label_len) for i in false_positive_rate(c)]...)
        println(io,lpad("False Discovery Rate:", 30), [lpad(round(i, digits = digits), label_len) for i in false_discovery_rate(c)]...)
        println(io,lpad("False Omission Rate:", 30), [lpad(round(i, digits = digits), label_len) for i in false_omission_rate(c)]...)
        println(io,lpad("F1 Score:", 30), [lpad(round(i, digits = digits), label_len) for i in f1_score(c)]...)
        println(io,lpad("Jaccard Score:", 30), [lpad(round(i, digits = digits), label_len) for i in jaccard_score(c, average = nothing)]...)
        println(io,lpad("Prevalence Threshold:", 30), [lpad(round(i, digits = digits), label_len) for i in prevalence_threshold(c)]...)
        println(io,lpad("Threat Score:", 30), [lpad(round(i, digits = digits), label_len) for i in threat_score(c)]...)
        println(io,lpad("Matthews Correlation Coefficient", 30), [lpad(round(i, digits = digits), label_len) for i in matthews_correlation_coeff(c)]...)
        println(io,lpad("Fowlkes Mallows Index:", 30), [lpad(round(i, digits = digits), label_len) for i in fowlkes_mallows_index(c)]...)
        println(io,lpad("Informedness:", 30), [lpad(round(i, digits = digits), label_len) for i in informedness(c)]...)
        println(io,lpad("Markedness:", 30), [lpad(round(i, digits = digits), label_len) for i in markedness(c)]...)
        println(io,"\n",lpad("General Statistics", label_len * Int(round(size(c.matrix)[1] / 2)+1)), "\n")
        println(io, lpad("Accuracy Score:\t",30), accuracy_score(c))
        println(io, lpad("Cohen Kappa Score:\t", 30), cohen_kappa_score(c))
        println(io, lpad("Hamming Loss:\t", 30), hamming_loss(c))
        println(io, lpad("Jaccard Score:\t", 30), jaccard_score(c, average = "micro"))
    end
end

classification_report(expected, predicted; io::IO = Base.stdout, return_dict = false, target_names = nothing, digits = 2) =
classification_report(confusion_matrix(expected, predicted); io = Base.stdout, return_dict = false, target_names = nothing, digits = 2)

##

# Confusion Matrix Evaluation Functions

"""
```condition_positive(c::confusion_matrix; ith_class = nothing, class_name = nothing)```

Return condition positive values of either the whole confusion matrix or the classes specified by `class_name` or `ith_class`
arguments.

    Condition Positives: True Positives + False Negatives

## Keyowrds

**`ith_class`** : Int, default = nothing
Return the results for the ith class in the ith label of the label list of the given confusion matrix object.

**`class_name`** : Int/String, default = nothing
Return the results for the class of the speicifed value in the ith label of the label list of the given confusion matrix object.

If both `class_name` and `ith_class` arguments are equal to `nothing`, return condition positive values for all the elements in the labels arrays

## Example

First example no indexing:\n\n

```julia-repl
julia> y_true = ["sample",  "knet", "metrics", "function",  "knet", "knet","function"];

julia> y_pred = ["sample",  "knet", "sample", "function",  "knet", "knet","knet"];

julia> x = confusion_matrix(y_true, y_pred);

julia> condition_positive(x)
4-element Array{Int64,1}:
 1
 3
 1
 2

```

Second example value of a specific class:\n\n

```julia-repl
julia> y_true = ["sample",  "knet", "metrics", "function",  "knet", "knet","function"];

julia> y_pred = ["sample",  "knet", "sample", "function",  "knet", "knet","knet"];

julia> x = confusion_matrix(y_true, y_pred);

julia> condition_positive(x, class_name = "knet")
3

```
_See also_ : `confusion_matrix`, `condition_negative`, `predicted_positive`, `predicted_negative`

"""
function condition_positive(c::confusion_matrix; ith_class = nothing, class_name = nothing, average = "binary")
    @assert average in ["binary", "macro"] "Unknown averaging type"
    index = check_index(c.Labels, true, ith_class = ith_class, class_name = class_name)
    if index == -1
        x = c.true_positives + c.false_negatives
        x = clear_output(x,c.zero_division)
        return average == "binary" ? x : mean(x)
    else
        x = c.true_positives[index] + c.false_negatives[index]
        return clear_output(x,c.zero_division)
    end
end

condition_positive(expected::Array{T,1}, predicted::Array{T,1}; ith_class = nothing, class_name = nothing, average = "binary") where T <: Union{Int, String}  =
condition_positive(confusion_matrix(expected,predicted), ith_class = ith_class, class_name = class_name, average = average)

"""
```condition_negative(c::confusion_matrix; ith_class = nothing, class_name = nothing)```

Return condition negative values of either the whole confusion matrix or the classes specified by `class_name` or `ith_class`
arguments.

    Condition Negatives: True Negatives + False Positives

## Keywords

**`ith_class`** : Int, default = nothing
Return the results for the ith class in the ith label of the label list of the given confusion matrix object.

**`class_name`** : Int/String, default = nothing
Return the results for the class of the speicifed value in the ith label of the label list of the given confusion matrix object.

If both `class_name` and `ith_class` arguments are equal to `nothing`, return condition negative values for all the elements in the labels arrays

## Example

First example no indexing:\n\n

```julia-repl
julia> y_pred = [1,2,3,1,4,2,1,2,3,4,1,2,3,4,1,2,2,2,3,1];

julia> y_true = [1,2,1,1,4,2,4,2,2,4,1,2,3,2,1,2,2,2,1,1];

julia> x = confusion_matrix(y_pred, y_true, labels = [1,2,3,4]);
┌ Warning: There are elements of value 0 in the false positives array. This may lead to false values for some functions
└ @ Path
┌ Warning: There are elements of value 0 in the false negatives array. This may lead to false values for some functions
└ @ Path

julia> condition_negative(x)
4-element Array{Int64,1}:
 14
 13
 16
 17

```

Second example value of a specific class:\n\n

```julia-repl
julia> y_pred = [1,2,3,1,4,2,1,2,3,4,1,2,3,4,1,2,2,2,3,1];

julia> y_true = [1,2,1,1,4,2,4,2,2,4,1,2,3,2,1,2,2,2,1,1];

julia> x = confusion_matrix(y_pred, y_true, labels = [1,2,3,4]);
┌ Warning: There are elements of value 0 in the false positives array. This may lead to false values for some functions
└ @ Path
┌ Warning: There are elements of value 0 in the false negatives array. This may lead to false values for some functions
└ @ Path

julia> condition_negative(x, class_name = 3)
16

```

_See also_ : `confusion_matrix`, `condition_positive`, `predicted_positive`, `predicted_negative`

"""
function condition_negative(c::confusion_matrix; ith_class = nothing, class_name = nothing, average = "binary")
    @assert average in ["binary", "macro"] "Unknown averaging type"
    index = check_index(c.Labels, true, ith_class = ith_class, class_name = class_name)
    if index == -1
        x = c.true_negatives + c.false_positives
        x = clear_output(x,c.zero_division)
        return average == "binary" ? x : mean(x)
    else
        x = c.true_negatives[index] + c.false_positives[index]
        return clear_output(x,c.zero_division)
    end
end

condition_negative(expected::Array{T,1}, predicted::Array{T,1}; ith_class = nothing, class_name = nothing, average = "binary") where T <: Union{Int, String}  =
condition_negative(confusion_matrix(expected,predicted), ith_class = ith_class, class_name = class_name, average = average)


"""
```predicted_positive(c::confusion_matrix; ith_class = nothing, class_name = nothing)```

Return predicted positive values of either the whole confusion matrix or the classes specified by `class_name` or `ith_class`
arguments.

    Predicted Positives: True Positives + False Positives

## Keywords

**`ith_class`** : Int, default = nothing
Return the results for the ith class in the ith label of the label list of the given confusion matrix object.

**`class_name`** : Int/String, default = nothing
Return the results for the class of the speicifed value in the ith label of the label list of the given confusion matrix object.

If both `class_name` and `ith_class` arguments are equal to `nothing`, return predicted positive values for all the elements in the labels arrays

## Example

First example no indexing:\n\n

```julia-repl
julia> y_pred = [2, 3, 4, 2, 5, 3, 2, 3, 4, 5, 2, 3, 4, 5, 2, 3, 3, 3, 4, 2];

julia> y_true = [2, 3, 2, 2, 5, 3, 5, 3, 3, 5, 2, 3, 4, 3, 2, 3, 3, 3, 2, 2];

julia> x = confusion_matrix(y_pred, y_true, labels = [2,3,4,5]);
┌ Warning: There are elements of value 0 in the false positives array. This may lead to false values for some functions
└ @ Path
┌ Warning: There are elements of value 0 in the false negatives array. This may lead to false values for some functions
└ @ Path

julia>  predicted_positive(x)
4-element Array{Int64,1}:
 7
 9
 1
 3

```

Second example value of a specific class:\n\n

```julia-repl
julia> y_pred = [2, 3, 4, 2, 5, 3, 2, 3, 4, 5, 2, 3, 4, 5, 2, 3, 3, 3, 4, 2];

julia> y_true = [2, 3, 2, 2, 5, 3, 5, 3, 3, 5, 2, 3, 4, 3, 2, 3, 3, 3, 2, 2];

julia> x = confusion_matrix(y_pred, y_true, labels = [2,3,4,5]);
┌ Warning: There are elements of value 0 in the false positives array. This may lead to false values for some functions
└ @ Path
┌ Warning: There are elements of value 0 in the false negatives array. This may lead to false values for some functions
└ @ Path

julia> predicted_positive(x, class_name = 3)
9
```

_See also_ : `confusion_matrix`, `condition_negative`, `predicted_positive`, `predicted_negative`

"""
function predicted_positive(c::confusion_matrix; ith_class = nothing, class_name = nothing, average = "binary")
    @assert average in ["binary", "macro"] "Unknown averaging type"
    index = check_index(c.Labels, true, ith_class = ith_class, class_name = class_name)
    if index == -1
        x = c.true_positives + c.false_positives
        x = clear_output(x,c.zero_division)
        return average == "binary" ? x : mean(x)
    else
        x = c.true_positives[index] + c.false_positives[index]
        return clear_output(x,c.zero_division)
    end
end

predicted_positive(expected::Array{T,1}, predicted::Array{T,1}; ith_class = nothing, class_name = nothing, average = "binary") where T <: Union{Int, String}  =
predicted_positive(confusion_matrix(expected,predicted), ith_class = ith_class, class_name = class_name, average = average)

"""
```predicted_negative(c::confusion_matrix; ith_class = nothing, class_name = nothing)```

Return predicted negative values of either the whole confusion matrix or the classes specified by `class_name` or `ith_class`
arguments.

    Predicted Negatives: Negatives + False Negatives

## Keywords

**`ith_class`** : Int, default = nothing
Return the results for the ith class in the ith label of the label list of the given confusion matrix object.

**`class_name`** : Int/String, default = nothing
Return the results for the class of the speicifed value in the ith label of the label list of the given confusion matrix object.

If both `class_name` and `ith_class` arguments are equal to `nothing`, return predicted negative values for all the elements in the labels arrays

## Example

First example no indexing:\n\n

```julia-repl
julia> y_pred = [2, 3, 4, 2, 5, 3, 2, 3, 4, 5, 2, 3, 4, 5, 2, 3, 3, 3, 4, 2];

julia> y_true = [2, 3, 2, 2, 5, 3, 5, 3, 3, 5, 2, 3, 4, 3, 2, 3, 3, 3, 2, 2];

julia> x = confusion_matrix(y_pred, y_true, labels = [2,3,4,5]);
┌ Warning: There are elements of value 0 in the false positives array. This may lead to false values for some functions
└ @ Path
┌ Warning: There are elements of value 0 in the false negatives array. This may lead to false values for some functions
└ @ Path

julia> predicted_negative(x)
4-element Array{Int64,1}:
 13
 11
 19
 17

```

Second example value of a specific class:\n\n

```julia-repl
julia> y_pred = [2, 3, 4, 2, 5, 3, 2, 3, 4, 5, 2, 3, 4, 5, 2, 3, 3, 3, 4, 2];

julia> y_true = [2, 3, 2, 2, 5, 3, 5, 3, 3, 5, 2, 3, 4, 3, 2, 3, 3, 3, 2, 2];

julia> x = confusion_matrix(y_pred, y_true, labels = [2,3,4,5]);
┌ Warning: There are elements of value 0 in the false positives array. This may lead to false values for some functions
└ @ Path
┌ Warning: There are elements of value 0 in the false negatives array. This may lead to false values for some functions
└ @ Path

julia> predicted_negative(x, class_name = 4)
19

```
_See also_ : `confusion_matrix`, `condition_negative`, `predicted_positive`, `condition_positive`

"""
function predicted_negative(c::confusion_matrix; ith_class = nothing, class_name = nothing, average = "binary")
    @assert average in ["binary", "macro"] "Unknown averaging type"
    index = check_index(c.Labels, true, ith_class = ith_class, class_name = class_name)
    if index == -1
        x = c.true_negatives + c.false_negatives
        x = clear_output(x,c.zero_division)
        return average == "binary" ? x : mean(x)
    else
        x = c.true_negatives[index] + c.false_negatives[index]
        return clear_output(x,c.zero_division)
    end
end

predicted_negative(expected::Array{T,1}, predicted::Array{T,1}; ith_class = nothing, class_name = nothing, average = "binary") where T <: Union{Int, String}  =
predicted_negative(confusion_matrix(expected,predicted), ith_class = ith_class, class_name = class_name, average = average)

"""
```correctly_classified(c::confusion_matrix; ith_class = nothing, class_name = nothing)```

Return number of correctly classified instances of either the whole confusion matrix or the classes specified by `class_name` or `ith_class`
arguments.

    Correctly Classified Values: True Positives + True Negatives

## Keywords

**`ith_class`** : Int, default = nothing
Return the results for the ith class in the ith label of the label list of the given confusion matrix object.

**`class_name`** : Int/String, default = nothing
Return the results for the class of the speicifed value in the ith label of the label list of the given confusion matrix object.

If both `class_name` and `ith_class` arguments are equal to `nothing`, return number of correctly classified instances for all the elements in the labels arrays

## Example

First example no indexing:\n\n

```julia-repl
julia> y_pred = [2, 3, 4, 2, 5, 3, 2, 3, 4, 5, 2, 3, 4, 5, 2, 3, 3, 3, 4, 2];

julia> y_true = [2, 3, 2, 2, 5, 3, 5, 3, 3, 5, 2, 3, 4, 3, 2, 3, 3, 3, 2, 2];

julia> x = confusion_matrix(y_pred, y_true, labels = [2,3,4,5]);
┌ Warning: There are elements of value 0 in the false positives array. This may lead to false values for some functions
└ @ Path
┌ Warning: There are elements of value 0 in the false negatives array. This may lead to false values for some functions
└ @ Path

julia> correctly_classified(x)
4-element Array{Int64,1}:
 17
 18
 17
 18

```

Second example value of a specific class:\n\n

```julia-repl
julia> y_pred = [2, 3, 4, 2, 5, 3, 2, 3, 4, 5, 2, 3, 4, 5, 2, 3, 3, 3, 4, 2];

julia> y_true = [2, 3, 2, 2, 5, 3, 5, 3, 3, 5, 2, 3, 4, 3, 2, 3, 3, 3, 2, 2];

julia> x = confusion_matrix(y_pred, y_true, labels = [2,3,4,5]);
┌ Warning: There are elements of value 0 in the false positives array. This may lead to false values for some functions
└ @ Path
┌ Warning: There are elements of value 0 in the false negatives array. This may lead to false values for some functions
└ @ Path

julia> correctly_classified(x, ith_class = 1)
17
```

_See also_ : `confusion_matrix`, `predicted_negative`, `predicted_positive`, `incorrectly_classified`

"""
function correctly_classified(c::confusion_matrix; ith_class = nothing, class_name = nothing, average = "binary")
    @assert average in ["binary", "macro"] "Unknown averaging type"
    index = check_index(c.Labels, true, ith_class = ith_class, class_name = class_name)
    if index == -1
        x = c.true_positives + c.true_negatives
        x = clear_output(x,c.zero_division)
        return average == "binary" ? x : mean(x)
    else
        x = c.true_positives[index] + c.true_negatives[index]
        return clear_output(x,c.zero_division)
    end
end

correctly_classified(expected::Array{T,1}, predicted::Array{T,1}; ith_class = nothing, class_name = nothing, average = "binary") where T <: Union{Int, String}  =
correctly_classified(confusion_matrix(expected,predicted); ith_class = ith_class, class_name = class_name, average = average)

"""
```incorrectly_classified(c::confusion_matrix; ith_class = nothing, class_name = nothing)```

Return number of incorrectly classified instances of either the whole confusion matrix or the classes specified by `class_name` or `ith_class`
arguments.

    Inorrectly Classified: False Negatives + False Positives

## Arguments

**`ith_class`** : Int, default = nothing
Return the results for the ith class in the ith label of the label list of the given confusion matrix object.

**`class_name`** : Int/String, default = nothing
Return the results for the class of the speicifed value in the ith label of the label list of the given confusion matrix object.

If both `class_name` and `ith_class` arguments are equal to `nothing`, return number of incorrectly classified instances for all the elements in the labels arrays

## Example

First example no indexing:\n\n

```julia-repl
julia> y_pred = [2, 3, 4, 2, 5, 3, 2, 3, 4, 5, 2, 3, 4, 5, 2, 3, 3, 3, 4, 2];

julia> y_true = [2, 3, 2, 2, 5, 3, 5, 3, 3, 5, 2, 3, 4, 3, 2, 3, 3, 3, 2, 2];

julia> x = confusion_matrix(y_pred, y_true, labels = [2,3,4,5]);
┌ Warning: There are elements of value 0 in the false positives array. This may lead to false values for some functions
└ @ Path
┌ Warning: There are elements of value 0 in the false negatives array. This may lead to false values for some functions
└ @ Path

julia> incorrectly_classified(x)
4-element Array{Int64,1}:
 3
 2
 3
 2

```

Second example value of a specific class:\n\n

```julia-repl
julia> y_pred = [2, 3, 4, 2, 5, 3, 2, 3, 4, 5, 2, 3, 4, 5, 2, 3, 3, 3, 4, 2];

julia> y_true = [2, 3, 2, 2, 5, 3, 5, 3, 3, 5, 2, 3, 4, 3, 2, 3, 3, 3, 2, 2];

julia> x = confusion_matrix(y_pred, y_true, labels = [2,3,4,5]);
┌ Warning: There are elements of value 0 in the false positives array. This may lead to false values for some functions
└ @ Path
┌ Warning: There are elements of value 0 in the false negatives array. This may lead to false values for some functions
└ @ Path

julia> incorrectly_classified(x, ith_class = 2)
2

```

_See also_ : `confusion_matrix`, `predicted_negative`, `predicted_positive`, `correctly_classified`

"""
function incorrectly_classified(c::confusion_matrix; ith_class = nothing, class_name = nothing, average = "binary")
    @assert average in ["binary", "macro"] "Unknown averaging type"
    index = check_index(c.Labels, true, ith_class = ith_class, class_name = class_name)
    if index == -1
        x = c.false_positives + c.false_negatives
        x = clear_output(x,c.zero_division)
        return average == "binary" ? x : mean(x)
    else
        x = c.false_positives[index] + c.false_negatives[index]
        return clear_output(x,c.zero_division)
    end
end

incorrectly_classified(expected::Array{T,1}, predicted::Array{T,1}; ith_class = nothing, class_name = nothing, average = "binary") where T <: Union{Int, String}  =
incorrectly_classified(confusion_matrix(expected,predicted), ith_class = ith_class, class_name = class_name, average = average)

"""
```sensitivity_score(c::confusion_matrix; ith_class = nothing, class_name = nothing)```

Return sensitivity (recall) score of either the whole confusion matrix or the classes specified by `class_name` or `ith_class`
arguments.

    The sensitivity (recall) is the ratio ``tp / (tp + fn)`` where ``tp`` is the number of
    true positives and ``fn`` the number of false negatives. The recall is
    intuitively the ability of the classifier to find all the positive samples.
    The best value is 1 and the worst value is 0.

## Keywords

**`ith_class`** : Int, default = nothing
Return the results for the ith class in the ith label of the label list of the given confusion matrix object.

**`class_name`** : Int/String, default = nothing
Return the results for the class of the speicifed value in the ith label of the label list of the given confusion matrix object.

If both `class_name` and `ith_class` arguments are equal to `nothing`, return sensitivity(recall) score for all the elements in the labels arrays

## Examples

```julia-repl
julia> y_true = [3, 1, 1, 2, 1, 2, 1, 5, 1, 5];

julia> y_pred = [3, 1, 4, 1, 4, 2, 3, 4, 3, 1];

julia>  x = confusion_matrix(y_true, y_pred, labels= [1,2,3,4,5]);

julia> sensitivity_score(x)
┌ Warning: Zero division, replacing NaN or Inf with 0
└ @ Path
5-element Array{Float64,1}:
 0.2
 0.5
 1.0
 0.0
 0.0

julia> sensitivity_score(x, class_name = 1)
0.2
```

_See also_ : `confusion_matrix` , `recall_score` ,  `balanced_accuracy_score`, `specificity_score`
"""
function sensitivity_score(c::confusion_matrix; ith_class = nothing, class_name = nothing, average = "binary")
    @assert average in ["binary", "macro"] "Unknown averaging type"
    index = check_index(c.Labels, true, ith_class = ith_class, class_name = class_name)
    if index == -1
        x = c.true_positives ./ condition_positive(c)
        x = clear_output(x, c.zero_division)
        return average == "binary" ? x : mean(x)
    else
        x = c.true_positives[index] / condition_positive(c, ith_class = index)
        return clear_output(x, c.zero_division)
    end
end

sensitivity_score(expected::Array{T,1}, predicted::Array{T,1}; ith_class = nothing, class_name = nothing, average = "binary") where T <: Union{Int, String}  =
sensitivity_score(confusion_matrix(expected,predicted), ith_class = ith_class, class_name = class_name, average = average)

"""
```recall_score(c::confusion_matrix; ith_class = nothing, class_name = nothing)```

Return recall(sensitivity) score of either the whole confusion matrix or the classes specified by `class_name` or `ith_class`
arguments.

    The recall (sensitivity) is the ratio ``tp / (tp + fn)`` where ``tp`` is the number of
    true positives and ``fn`` the number of false negatives. The recall is
    intuitively the ability of the classifier to find all the positive samples.
    The best value is 1 and the worst value is 0.

## Keywords

**`ith_class`** : Int, default = nothing
Return the results for the ith class in the ith label of the label list of the given confusion matrix object.

**`class_name`** : Int/String, default = nothing
Return the results for the class of the speicifed value in the ith label of the label list of the given confusion matrix object.

If both `class_name` and `ith_class` arguments are equal to `nothing`, return recall (sensitivity) score for all the elements in the labels arrays

## Examples

```julia-repl
julia> y_true = [3, 1, 1, 2, 1, 2, 1, 5, 1, 5];

julia> y_pred = [3, 1, 4, 1, 4, 2, 3, 4, 3, 1];

julia>  x = confusion_matrix(y_true, y_pred, labels= [1,2,3,4,5]);

julia> recall_score(x)
┌ Warning: Zero division, replacing NaN or Inf with 0
└ @ Path
5-element Array{Float64,1}:
 0.2
 0.5
 1.0
 0.0
 0.0

julia> recall_score(x, class_name = 1)
0.2
```

_See also_ : `confusion_matrix` , `sensitivity_score` ,  `balanced_accuracy_score`, `specificity_score`

"""
function recall_score(c::confusion_matrix; ith_class = nothing, class_name = nothing, average = "binary")
    return sensitivity_score(c, ith_class = ith_class, class_name = class_name, average = average)
end

recall_score(expected::Array{T,1}, predicted::Array{T,1}; ith_class = nothing, class_name = nothing, average = "binary") where T <: Union{Int, String}  =
recall_score(confusion_matrix(expected,predicted), ith_class = ith_class, class_name = class_name, average = average)

"""
```specificity_score(c::confusion_matrix; ith_class = nothing, class_name = nothing)```

Return specificity score of either the whole confusion matrix or the classes specified by `class_name` or `ith_class`
arguments.

    The specificity is the ratio ``tn / (tn + fp)`` where ``tn`` is the number of
    true negatives and ``fp`` the number of false positives. The specificity is
    intuitively the ability of the classifier to find all the negative samples.
    The best value is 1 and the worst value is 0.

## Keywords

**`ith_class`** : Int, default = nothing
Return the results for the ith class in the ith label of the label list of the given confusion matrix object.

**`class_name`** : Int/String, default = nothing
Return the results for the class of the speicifed value in the ith label of the label list of the given confusion matrix object.

If both `class_name` and `ith_class` arguments are equal to `nothing`, return specificity score for all the elements in the labels arrays

## Examples

```julia-repl
julia> y_true = [3, 1, 1, 2, 1, 2, 1, 5, 1, 5];

julia> y_pred = [3, 1, 4, 1, 4, 2, 3, 4, 3, 1];

julia>  x = confusion_matrix(y_true, y_pred, labels= [1,2,3,4,5]);

julia> specificity(x)
5-element Array{Float64,1}:
 0.6
 1.0
 0.7777777777777778
 0.7
 1.0

julia> specificity(x,ith_class = 2)
1.0
```

_See also_ : ```confusion_matrix```, ```sensitivity_score```, ```balanced_accuracy_score```,```recall_score```

"""
function specificity_score(c::confusion_matrix; ith_class = nothing, class_name = nothing, average = "binary")
    @assert average in ["binary", "macro"] "Unknown averaging type"
    index = check_index(c.Labels, true, ith_class = ith_class, class_name = class_name)
    if index == -1
        x = c.true_negatives ./ condition_negative(c)
        x = clear_output(x, c.zero_division)
        return average == "binary" ? x : mean(x)
    else
        x = c.true_negatives[index] / condition_negative(c, ith_class = index)
        return clear_output(x, c.zero_division)
    end
end

specificity_score(expected::Array{T,1}, predicted::Array{T,1}; ith_class = nothing, class_name = nothing, average = "binary") where T <: Union{Int, String}  =
specificity_score(confusion_matrix(expected,predicted), ith_class = ith_class, class_name = class_name, average = average)

"""
```precision_score(c::confusion_matrix; ith_class = nothing, class_name = nothing)```

Return precision score of either the whole confusion matrix or the classes specified by `class_name` or `ith_class`
arguments.

    The precision is the ratio ``tp / (tp + fp)`` where ``tp`` is the number of
    true positives and ``fp`` the number of false positives. The precision is
    intuitively the ability of the classifier not to label as positive a sample
    that is negative.

## Keywords

**`ith_class`** : Int, default = nothing
Return the results for the ith class in the ith label of the label list of the given confusion matrix object.

**`class_name`** : Int/String, default = nothing
Return the results for the class of the speicifed value in the ith label of the label list of the given confusion matrix object.

If both `class_name` and `ith_class` arguments are equal to `nothing`, return precision score for all the elements in the labels arrays

## Examples

```julia-repl
julia> y_true = [3, 1, 1, 2, 1, 2, 1, 5, 1, 5];

julia> y_pred = [3, 1, 4, 1, 4, 2, 3, 4, 3, 1];

julia> x = confusion_matrix(y_true, y_pred, labels= [1,2,3,4,5]);

julia> precision_score(x)
┌ Warning: Zero division, replacing NaN or Inf with 0
└ @ Main Path
5-element Array{Float64,1}:
 0.3333333333333333
 1.0
 0.3333333333333333
 0.0
 0.0

julia>  precision_score(x, class_name = 3)
0.3333333333333333

```

_See also_ : ```confusion_matrix```, ```sensitivity_score```, ```balanced_accuracy_score```,```recall_score```

"""
function precision_score(c::confusion_matrix; ith_class = nothing, class_name = nothing, average = "binary")
    @assert average in ["binary", "macro"] "Unknown averaging type"
    index = check_index(c.Labels, true, ith_class = ith_class, class_name = class_name)
    if index == -1
        x = c.true_positives ./ (c.true_positives + c.false_positives)
        x = clear_output(x, c.zero_division)
        return average == "binary" ? x : mean(x)
    else
        x = c.true_positives[index] / (c.true_positives[index] + c.false_positives[index])
        return clear_output(x,c.zero_division)
    end
end

precision_score(expected::Array{T,1}, predicted::Array{T,1}; ith_class = nothing, class_name = nothing, average = "binary") where T <: Union{Int, String}  =
precision_score(confusion_matrix(expected,predicted), ith_class = ith_class, class_name = class_name, average = average)

"""
```positive_predictive_value(c::confusion_matrix; ith_class = nothing, class_name = nothing)```

Return  score of either the whole confusion matrix or the classes specified by `class_name` or `ith_class`
arguments.

    The positive predictive value is the ratio ``tp / (tp + fp)`` where ``tp`` is the number of
    true positives and ``fp`` the number of false positives. The positive predictive value is
    intuitively the ability of the classifier not to label as positive a sample
    that is negative.

## Keywords

**`ith_class`** : Int, default = nothing
Return the results for the ith class in the ith label of the label list of the given confusion matrix object.

**`class_name`** : Int/String, default = nothing
Return the results for the class of the speicifed value in the ith label of the label list of the given confusion matrix object.

If both `class_name` and `ith_class` arguments are equal to `nothing`, return positive predictive value for all the elements in the labels arrays

## Examples

```julia-repl
julia> y_true = [3, 1, 1, 2, 1, 2, 1, 5, 1, 5];

julia> y_pred = [3, 1, 4, 1, 4, 2, 3, 4, 3, 1];

julia> x = confusion_matrix(y_true, y_pred, labels= [1,2,3,4,5]);

julia> positive_predictive_value(x)
┌ Warning: Zero division, replacing NaN or Inf with 0
└ @ Main Path
5-element Array{Float64,1}:
 0.3333333333333333
 1.0
 0.3333333333333333
 0.0
 0.0

julia> positive_predictive_value(x, ith_class = 3)
0.3333333333333333

```

_See also_ : ```negative_predictive_value```, ```confusion_matrix```, ```sensitivity_score```, ```balanced_accuracy_score```,```recall_score```

"""
function positive_predictive_value(c::confusion_matrix; ith_class = nothing, class_name = nothing, average = "binary")
   return precision_score(c, class_name = class_name, ith_class = ith_class, average = average)
end

positive_predictive_value(expected::Array{T,1}, predicted::Array{T,1}; ith_class = nothing, class_name = nothing, average = "binary") where T <: Union{Int, String}  =
positive_predictive_value(confusion_matrix(expected,predicted), ith_class = ith_class, class_name = class_name, average = average)

"""
```accuracy_score(c::confusion_matrix; ith_class = nothing, class_name = nothing, normalize = true, sample_weight = nothing) ```

Return accuracy classification score.

## Arguments

**`ith_class`** : Int, default = nothing
Return the results for the ith class in the ith label of the label list of the given confusion matrix object.

**`class_name`** : Int/String, default = nothing
Return the results for the class of the speicifed value in the ith label of the label list of the given confusion matrix object.

**`normalize`** : bool, default= true
        If ``False``, return the number of correctly classified samples.
        Otherwise, return the fraction of correctly classified samples.

**`sample_weight`** : array-like of shape (n_samples,), default=None
        Sample weights.

If both `class_name` and `ith_class` arguments are equal to `nothing`, return positive predictive value for all the elements in the labels arrays

## Examples

```julia-repl
julia> y_true = [3, 1, 1, 2, 1, 2, 1, 5, 1, 5];

julia> y_pred = [3, 1, 4, 1, 4, 2, 3, 4, 3, 1];

julia> x = confusion_matrix(y_true, y_pred, labels= [1,2,3,4,5]);

julia> accuracy_score(x)
0.36

julia> accuracy_score(x, normalize = false)
3.5999999999999996

```

_See also_ : ```jaccard_score``` ```confusion_matrix```, ```hamming_loss```, ```balanced_accuracy_score```,```recall_score```


"""
function accuracy_score(c::confusion_matrix; ith_class = nothing, class_name = nothing, normalize = true, sample_weight = nothing)
    index = check_index(c.Labels, true, ith_class = ith_class, class_name = class_name)
    if index == -1
        accuracy_array = [accuracy_score(c, ith_class = i) for i in 1:length(c.true_positives)]
        if normalize
            x = sample_weight == nothing ? (sum(accuracy_array) / sum(c.matrix)) : (sum(accuracy_array .* sample_weight) / sum(c.matrix))
            return clear_output(x,c.zero_division)
        else
            x = sample_weight == nothing ? sum(accuracy_array) : dot(accuracy_array, sample_weight)
            return clear_output(x,c.zero_division)
        end
    else
        if normalize
            x = (c.true_positives[index] + c.true_negatives[index] ) / (condition_positive(c, ith_class = index) + condition_negative(c, ith_class = index))
            return clear_output(x, c.zero_division)
        else
            x = (c.true_positives[index])
            return clear_output(x, c.zero_division)
        end
    end
end

accuracy_score(expected::Array{T,1}, predicted::Array{T,1}; ith_class = nothing, class_name = nothing, normalize = true, sample_weight = nothing) where T <: Union{Int, String}  =
accuracy_score(confusion_matrix(expected,predicted), ith_class = ith_class, class_name = class_name, normalize = true, sample_weight = nothing)

"""
```balanced_accuracy_score(c::confusion_matrix; ith_class = nothing, class_name = nothing) ```

Return balanced accuracy classification score.

## Arguments

**`ith_class`** : Int, default = nothing
Return the results for the ith class in the ith label of the label list of the given confusion matrix object.

**`class_name`** : Int/String, default = nothing
Return the results for the class of the speicifed value in the ith label of the label list of the given confusion matrix object.

If both `class_name` and `ith_class` arguments are equal to `nothing`, return balanced accuracy score for all the elements in the labels arrays

## Examples

```julia-repl
julia> y_true = [3, 1, 1, 2, 1, 2, 1, 5, 1, 5];

julia> y_pred = [3, 1, 4, 1, 4, 2, 3, 4, 3, 1];

julia> x = confusion_matrix(y_true, y_pred, labels= [1,2,3,4,5]);

julia> balanced_accuracy_score(x)
┌ Warning: Zero division, replacing NaN or Inf with 0
└ @ Path
5-element Array{Float64,1}:
 0.4
 0.75
 0.8888888888888888
 0.35
 0.5

julia> balanced_accuracy_score(x, ith_class = 3)
0.8888888888888888

```

_See also_ : ```accuracy_score``` ```confusion_matrix```, ```hamming_loss```, ```balanced_accuracy_score```,```recall_score```

[1] Brodersen, K.H.; Ong, C.S.; Stephan, K.E.; Buhmann, J.M. (2010).
       The balanced accuracy and its posterior distribution.
       Proceedings of the 20th International Conference on Pattern
       Recognition, 3121-24.
[2] John. D. Kelleher, Brian Mac Namee, Aoife D'Arcy, (2015).
       `Fundamentals of Machine Learning for Predictive Data Analytics:
       Algorithms, Worked Examples, and Case Studies
       [link](https://mitpress.mit.edu/books/fundamentals-machine-learning-predictive-data-analytics)

"""
function balanced_accuracy_score(c::confusion_matrix; ith_class = nothing, class_name = nothing, average = "binary")
    @assert average in ["binary", "macro"] "Unknown averaging type"
    index = check_index(c.Labels, true, ith_class = ith_class, class_name = class_name)
    if index == -1
        x = [(sensitivity_score(c, ith_class = i) +  specificity_score(c, ith_class = i)) / 2 for i in 1:length(c.true_positives)]
        x = clear_output(x,c.zero_division)
        return average == "binary" ? x : mean(x)
    else
        x = (sensitivity_score(c,ith_class = index) +  specificity_score(c, ith_class = index)) / 2
        return clear_output(x,c.zero_division)
    end
end

balanced_accuracy_score(expected::Array{T,1}, predicted::Array{T,1}; ith_class = nothing, class_name = nothing, average = "binary") where T <: Union{Int, String}  =
balanced_accuracy_score(confusion_matrix(expected,predicted), ith_class = ith_class, class_name = class_name, average = average)

"""

```negative_predictive_value(c::confusion_matrix; ith_class = nothing, class_name = nothing) ```

Return negative predictive value for the specified class(es).

## Arguments

**`ith_class`** : Int, default = nothing
Return the results for the ith class in the ith label of the label list of the given confusion matrix object.

**`class_name`** : Int/String, default = nothing
Return the results for the class of the speicifed value in the ith label of the label list of the given confusion matrix object.

If both `class_name` and `ith_class` arguments are equal to `nothing`, return negative predictive value for all the elements in the labels arrays

## Examples

```julia-repl
julia> y_true = [3, 1, 1, 2, 1, 2, 1, 5, 1, 5];

julia> y_pred = [3, 1, 4, 1, 4, 2, 3, 4, 3, 1];

julia> x = confusion_matrix(y_true, y_pred, labels= [1,2,3,4,5]);

julia> negative_predictive_value(x)
5-element Array{Float64,1}:
 0.42857142857142855
 0.8888888888888888
 1.0
 1.0
 0.8

 julia> negative_predictive_value(x, class_name = 1)
 0.42857142857142855
```

_See Also_ :   ```confusion_matrix```, ```accuracy_score```, ```positive_predictive_value```, ```balanced_accuracy_score```

"""
function negative_predictive_value(c::confusion_matrix; ith_class = nothing, class_name = nothing, average = "binary")
    index = check_index(c.Labels, true, ith_class = ith_class, class_name = class_name)
    if index == -1
        x = [c.true_negatives[i] / (c.true_negatives[i] + c.false_negatives[i]) for i in 1:length(c.true_positives)]
        x = clear_output(x,c.zero_division)
        return average == "binary" ? x : mean(x)
    else
        x = c.true_negatives[index] / (c.true_negatives[index] + c.false_negatives[index])
        return clear_output(x,c.zero_division)
    end
end

negative_predictive_value(expected::Array{T,1}, predicted::Array{T,1}; ith_class = nothing, class_name = nothing, average = "binary") where T <: Union{Int, String}  =
negative_predictive_value(confusion_matrix(expected,predicted), ith_class = ith_class, class_name = class_name, average = average)

"""

```false_negative_rate(c::confusion_matrix; ith_class = nothing, class_name = nothing) ```

Return false negative rate for the specified class(es).

## Arguments

**`ith_class`** : Int, default = nothing
Return the results for the ith class in the ith label of the label list of the given confusion matrix object.

**`class_name`** : Int/String, default = nothing
Return the results for the class of the speicifed value in the ith label of the label list of the given confusion matrix object.

If both `class_name` and `ith_class` arguments are equal to `nothing`, return false negative rate for all the elements in the labels arrays

## Examples

```julia-repl
julia> y_true = [3, 1, 1, 2, 1, 2, 1, 5, 1, 5];

julia> y_pred = [3, 1, 4, 1, 4, 2, 3, 4, 3, 1];

julia> x = confusion_matrix(y_true, y_pred, labels= [1,2,3,4,5]);

julia> false_negative_rate(x)
┌ Warning: Zero division, replacing NaN or Inf with 0
└ @ Path
5-element Array{Float64,1}:
 0.8
 0.5
 0.0
 0.0
 1.0

 julia> false_negative_rate(x, ith_class = 3)
 0.0
 ```

 _See Also_ :   ```confusion_matrix```, ```false_positive_rate```, ```positive_predictive_value```, ```balanced_accuracy_score```

"""
function false_negative_rate(c::confusion_matrix; ith_class = nothing, class_name = nothing, average = "binary")
    @assert average in ["binary", "macro"] "Unknown averaging type"
    index = check_index(c.Labels, true, ith_class = ith_class, class_name = class_name)
    if index == -1
        x = [c.false_negatives[i] / condition_positive(c,ith_class = i) for i in 1:length(c.true_positives)]
        x = clear_output(x,c.zero_division)
        return average == "binary" ? x : mean(x)
    else
        x = c.false_negatives[index] / condition_positive(c,ith_class = index)
        return clear_output(x,c.zero_division)
    end
end

false_negative_rate(expected::Array{T,1}, predicted::Array{T,1}; ith_class = nothing, class_name = nothing, average = "binary") where T <: Union{Int, String}  =
false_negative_rate(confusion_matrix(expected,predicted), ith_class = ith_class, class_name = class_name, average = average)

"""

```false_positive_rate(c::confusion_matrix; ith_class = nothing, class_name = nothing) ```

Return false positive rate for the specified class(es).

## Arguments

**`ith_class`** : Int, default = nothing
Return the results for the ith class in the ith label of the label list of the given confusion matrix object.

**`class_name`** : Int/String, default = nothing
Return the results for the class of the speicifed value in the ith label of the label list of the given confusion matrix object.

If both `class_name` and `ith_class` arguments are equal to `nothing`, return false positive rate for all the elements in the labels arrays

## Examples

```julia-repl
julia> y_true = [3, 1, 1, 2, 1, 2, 1, 5, 1, 5];

julia> y_pred = [3, 1, 4, 1, 4, 2, 3, 4, 3, 1];

julia> x = confusion_matrix(y_true, y_pred, labels= [1,2,3,4,5]);

julia> false_positive_rate(x)
5-element Array{Float64,1}:
 0.4
 0.0
 0.2222222222222222
 0.3
 0.0

 julia> false_positive_rate(x, ith_class = 3)
 0.2222222222222222
 ```

 _See Also_ :   ```confusion_matrix```, ```false_negative_rate```, ```positive_predictive_value```, ```balanced_accuracy_score```
"""
function false_positive_rate(c::confusion_matrix; ith_class = nothing, class_name = nothing, average = "binary")
    @assert average in ["binary", "macro"] "Unknown averaging type"
    index = check_index(c.Labels, true, ith_class = ith_class, class_name = class_name)
    if index == -1
        x = [c.false_positives[i] / condition_negative(c,ith_class = i) for i in 1:length(c.true_positives)]
        x = clear_output(x,c.zero_division)
        return average == "binary" ? x : mean(x)
    else
        x = c.false_positives[index] / condition_negative(c,ith_class = index)
        return clear_output(x,c.zero_division)
    end
end

false_positive_rate(expected::Array{T,1}, predicted::Array{T,1}; ith_class = nothing, class_name = nothing, average = "binary") where T <: Union{Int, String}  =
false_positive_rate(confusion_matrix(expected,predicted), ith_class = ith_class, class_name = class_name, average = average)

"""

```false_discovery_rate(c::confusion_matrix; ith_class = nothing, class_name = nothing) ```

Return false discovery rate for the specified class(es).

## Arguments

**`ith_class`** : Int, default = nothing
Return the results for the ith class in the ith label of the label list of the given confusion matrix object.

**`class_name`** : Int/String, default = nothing
Return the results for the class of the speicifed value in the ith label of the label list of the given confusion matrix object.

If both `class_name` and `ith_class` arguments are equal to `nothing`, return false discovery rate for all the elements in the labels arrays

## Examples

```julia-repl
julia> y_true = [3, 1, 1, 2, 1, 2, 1, 5, 1, 5];

julia> y_pred = [3, 1, 4, 1, 4, 2, 3, 4, 3, 1];

julia> x = confusion_matrix(y_true, y_pred, labels= [1,2,3,4,5]);

julia> false_discovery_rate(x)
5-element Array{Float64,1}:
 0.4
 0.0
 0.2222222222222222
 0.3
 0.0

julia> false_discovery_rate(x, ith_class = 3)
0.2222222222222222

```
_See Also_ :   ```confusion_matrix```, ```accuracy_score```, ```positive_predictive_value```, ```false_omission_rate```

"""
function false_discovery_rate(c::confusion_matrix; ith_class = nothing, class_name = nothing, average= "binary")
    @assert average in ["binary", "macro"] "Unknown averaging type"
    index = check_index(c.Labels, true, ith_class = ith_class, class_name = class_name)
    if index == -1
        x = [c.false_positives[i] / ( c.false_positives[i]  + c.true_negatives[i]) for i in 1:length(c.true_positives)]
        x = clear_output(x,c.zero_division)
        return average == "binary" ? x : mean(x)
    else
        x = c.false_positives[index] / ( c.false_positives[index]  + c.true_negatives[index])
        return clear_output(x,c.zero_division)
    end
end

false_discovery_rate(expected::Array{T,1}, predicted::Array{T,1}; ith_class = nothing, class_name = nothing, average = "binary") where T <: Union{Int, String}  =
false_discovery_rate(confusion_matrix(expected,predicted), ith_class = ith_class, class_name = class_name, average = average)

"""
```false_omission_rate(c::confusion_matrix; ith_class = nothing, class_name = nothing) ```

Return false omission rate for the specified class(es).

## Arguments

**`ith_class`** : Int, default = nothing
Return the results for the ith class in the ith label of the label list of the given confusion matrix object.

**`class_name`** : Int/String, default = nothing
Return the results for the class of the speicifed value in the ith label of the label list of the given confusion matrix object.

If both `class_name` and `ith_class` arguments are equal to `nothing`, return false omission rate for all the elements in the labels arrays

## Examples

```julia-repl
julia> y_true = [3, 1, 1, 2, 1, 2, 1, 5, 1, 5];

julia> y_pred = [3, 1, 4, 1, 4, 2, 3, 4, 3, 1];

julia> x = confusion_matrix(y_true, y_pred, labels= [1,2,3,4,5]);

julia> false_omission_rate(x)
5-element Array{Float64,1}:
 0.5714285714285714
 0.11111111111111116
 0.0
 0.0
 0.19999999999999996

julia> false_omission_rate(x, ith_class = 5)
0.19999999999999996
```

_See Also_ :   ```confusion_matrix```, ```accuracy_score```, ```positive_predictive_value```, ```false_discovery_rate```
"""
function false_omission_rate(c::confusion_matrix; ith_class = nothing, class_name = nothing, average = "binary")
    @assert average in ["binary", "macro"] "Unknown averaging type"
    index = check_index(c.Labels, true, ith_class = ith_class, class_name = class_name)
    if index == -1
        x = [1 - negative_predictive_value(c,ith_class = i) for i in 1:length(c.true_positives)]
        x = clear_output(x,c.zero_division)
        return average == "binary" ? x : mean(x)
    else
        x = 1 - negative_predictive_value(c,ith_class = index)
        return clear_output(x,c.zero_division)
    end
end

false_omission_rate(expected::Array{T,1}, predicted::Array{T,1}; ith_class = nothing, class_name = nothing, average = "binary") where T <: Union{Int, String}  =
false_omission_rate(confusion_matrix(expected,predicted), ith_class = ith_class, class_name = class_name, average = average)

"""
```f1_score(c::confusion_matrix; ith_class = nothing, class_name = nothing) ```

Return f1 score for the specified class(es).

## Arguments

**`ith_class`** : Int, default = nothing
Return the results for the ith class in the ith label of the label list of the given confusion matrix object.

**`class_name`** : Int/String, default = nothing
Return the results for the class of the speicifed value in the ith label of the label list of the given confusion matrix object.

If both `class_name` and `ith_class` arguments are equal to `nothing`, return f1 score for all the elements in the labels arrays

## Examples

```julia-repl
julia> y_true = [3, 1, 1, 2, 1, 2, 1, 5, 1, 5];

julia> y_pred = [3, 1, 4, 1, 4, 2, 3, 4, 3, 1];

julia> x = confusion_matrix(y_true, y_pred, labels= [1,2,3,4,5]);

julia> f1_score(x)
5-element Array{Float64,1}:
 0.25
 0.6666666666666666
 0.5
 0.0
 0.0

julia> f1_score(x, class_name = 2)
0.6666666666666666
```

_See Also_ :   ```confusion_matrix```, ```accuracy_score```, ```recall_score```, ```false_omission_rate```

"""
function f1_score(c::confusion_matrix; ith_class = nothing, class_name = nothing, average = "binary")
    @assert average in ["binary", "macro"] "Unknown averaging type"
    index = check_index(c.Labels, true, ith_class = ith_class, class_name = class_name)
    if index == -1
        x = [(2* c.true_positives[i] ) / (2* c.true_positives[i] + c.false_positives[i] + c.false_negatives[i]) for i in 1:length(c.true_positives)]
        x = clear_output(x,c.zero_division)
        return average == "binary" ? x : mean(x)
    else
        x = (2* c.true_positives[index] ) / (2* c.true_positives[index] + c.false_positives[index] + c.false_negatives[index])
        return clear_output(x,c.zero_division)
    end
end

f1_score(expected::Array{T,1}, predicted::Array{T,1}; ith_class = nothing, class_name = nothing, average = "binary") where T <: Union{Int, String}  =
f1_score(confusion_matrix(expected,predicted), ith_class = ith_class, class_name = class_name, average = average)

"""

```prevalence_threshold(c::confusion_matrix; ith_class = nothing, class_name = nothing)```

Return prevalence threshold for the specified class(es).

## Arguments

**`ith_class`** : Int, default = nothing
Return the results for the ith class in the ith label of the label list of the given confusion matrix object.

**`class_name`** : Int/String, default = nothing
Return the results for the class of the speicifed value in the ith label of the label list of the given confusion matrix object.

If both `class_name` and `ith_class` arguments are equal to `nothing`, return prevalence threshold for all the elements in the labels arrays

## Examples

```julia-repl
julia> y_true = [3, 1, 1, 2, 1, 2, 1, 5, 1, 5];

julia> y_pred = [3, 1, 4, 1, 4, 2, 3, 4, 3, 1];

julia> x = confusion_matrix(y_true, y_pred, labels= [1,2,3,4,5]);

julia> prevalence_threshold(x)
┌ Warning: Zero division, replacing NaN or Inf with 0
└ @ Path
┌ Warning: Zero division, replacing NaN or Inf with 0
└ @ Path
┌ Warning: Zero division, replacing NaN or Inf with 0
└ @ Path
5-element Array{Float64,1}:
 -2.828427124746191
  0.0
  0.0
 -1.8257418583505536
  0.0

julia> prevalence_threshold(x, ith_class = 1)
-2.828427124746191
```

_See Also_ :   ```confusion_matrix```, ```accuracy_score```, ```recall_score```, ```f1_score```

"""
function prevalence_threshold(c::confusion_matrix; ith_class = nothing, class_name = nothing, average = "binary")
    @assert average in ["binary", "macro"] "Unknown averaging type"
    index = check_index(c.Labels, true, ith_class = ith_class, class_name = class_name)
    if index == -1
        x = [(sqrt(abs(sensitivity_score(c,ith_class = i) * (-specificity_score(c,ith_class = i) +1) + specificity_score(c,ith_class = i) -1)) / (sensitivity_score(c,ith_class = i) + specificity_score(c,ith_class = i) -1)) for i in 1:length(c.true_positives)]
        x = clear_output(x,c.zero_division)
        return average == "binary" ? x : mean(x)
    else
        x = (sqrt(abs(sensitivity_score(c,ith_class = index) * (-specificity_score(c,ith_class = index) +1) + specificity_score(c,ith_class = index) -1)) / (sensitivity_score(c,ith_class = index) + specificity_score(c,ith_class = index) -1))
        return clear_output(x,c.zero_division)
    end
end

prevalence_threshold(expected::Array{T,1}, predicted::Array{T,1}; ith_class = nothing, class_name = nothing, average = "binary") where T <: Union{Int, String}  =
prevalence_threshold(confusion_matrix(expected,predicted), ith_class = ith_class, class_name = class_name, average = average)

"""

```threat_score(c::confusion_matrix; ith_class = nothing, class_name = nothing)```

Return threat score for the specified class(es).

## Arguments

**`ith_class`** : Int, default = nothing
Return the results for the ith class in the ith label of the label list of the given confusion matrix object.

**`class_name`** : Int/String, default = nothing
Return the results for the class of the speicifed value in the ith label of the label list of the given confusion matrix object.

If both `class_name` and `ith_class` arguments are equal to `nothing`, return threat score for all the elements in the labels arrays

## Examples

```julia-repl
julia> y_true = [3, 1, 1, 2, 1, 2, 1, 5, 1, 5];

julia> y_pred = [3, 1, 4, 1, 4, 2, 3, 4, 3, 1];

julia> x = confusion_matrix(y_true, y_pred, labels= [1,2,3,4,5]);

julia> threat_score(x)
5-element Array{Float64,1}:
 0.14285714285714285
 0.5
 0.3333333333333333
 0.0
 0.0

julia> threat_score(x, ith_class = 3)
0.3333333333333333

```
_See Also_ :   ```confusion_matrix```, ```accuracy_score```, ```recall_score```, ```f1_score```

"""
function threat_score(c::confusion_matrix; ith_class = nothing, class_name = nothing, average = "binary")
    @assert average in ["binary", "macro"] "Unknown averaging type"
    index = check_index(c.Labels, true, ith_class = ith_class, class_name = class_name)
    if index == -1
        x = [c.true_positives[i] / (c.true_positives[i] + c.false_negatives[i] + c.false_positives[i]) for i in 1:length(c.true_positives)]
        x = clear_output(x,c.zero_division)
        return average == "binary" ? x : mean(x)
    else
        x = c.true_positives[index] / (c.true_positives[index] + c.false_negatives[index] + c.false_positives[index])
        return clear_output(x,c.zero_division)
    end
end

threat_score(expected::Array{T,1}, predicted::Array{T,1}; ith_class = nothing, class_name = nothing, average = "binary") where T <: Union{Int, String}  =
threat_score(confusion_matrix(expected,predicted), ith_class = ith_class, class_name = class_name, average = average)

"""

```matthews_correlation_coeff(c::confusion_matrix; ith_class = nothing, class_name = nothing)```

Return Matthew's Correlation Coefficient for the specified class(es).

## Arguments

**`ith_class`** : Int, default = nothing
Return the results for the ith class in the ith label of the label list of the given confusion matrix object.

**`class_name`** : Int/String, default = nothing
Return the results for the class of the speicifed value in the ith label of the label list of the given confusion matrix object.

If both `class_name` and `ith_class` arguments are equal to `nothing`, return Matthew's Correlation Coefficient for all the elements in the labels arrays

## Examples

```julia-repl
julia> y_true = [3, 1, 1, 2, 1, 2, 1, 5, 1, 5];

julia> y_pred = [3, 1, 4, 1, 4, 2, 3, 4, 3, 1];

julia> x = confusion_matrix(y_true, y_pred, labels= [1,2,3,4,5]);

julia> matthews_correlation_coeff(x)
┌ Warning: Zero division, replacing NaN or Inf with 0
└ @ Path
5-element Array{Float64,1}:
 -0.2182178902359924
  0.6666666666666666
  0.5091750772173156
  0.0
  0.0

julia> matthews_correlation_coeff(x, ith_class = 3)
0.5091750772173156

```

_See Also_ :   ```confusion_matrix```, ```accuracy_score```, ```threat_score```, ```f1_score```

"""
function matthews_correlation_coeff(c::confusion_matrix; ith_class = nothing, class_name = nothing, average = "binary")
    @assert average in ["binary", "macro"] "Unknown averaging type"
    index = check_index(c.Labels, true, ith_class = ith_class, class_name = class_name)
    if index == -1
        x = [(c.true_positives[i] * c.true_negatives[i] - c.false_positives[i] * c.false_negatives[i]) / sqrt( abs((c.true_positives[i] + c.false_positives[i]) * (c.true_positives[i] + c.false_negatives[i]) *
            (c.true_negatives[i] + c.false_positives[i]) * (c.true_negatives[i] + c.false_negatives[i])))
         for i in 1:length(c.true_positives)]
        x =  clear_output(x,c.zero_division)
        return average == "binary" ? x : mean(x)
    else
        x = (c.true_positives[index] * c.true_negatives[index] - c.false_positives[index] * c.false_negatives[index]) / sqrt( (c.true_positives[index] + c.false_positives[index]) * (c.true_positives[index] + c.false_negatives[index]) *
            (c.true_negatives[index] + c.false_positives[index]) * (c.true_negatives[index] + c.false_negatives[index]))
        return clear_output(x,c.zero_division)
    end
end

matthews_correlation_coeff(expected::Array{T,1}, predicted::Array{T,1}; ith_class = nothing, class_name = nothing, average = "binary") where T <: Union{Int, String}  =
matthews_correlation_coeff(confusion_matrix(expected,predicted), ith_class = ith_class, class_name = class_name, average = average)

"""

```fowlkes_mallows_index(c::confusion_matrix; ith_class = nothing, class_name = nothing)```

Return Fowlkes Mallows Index for the specified class(es).

## Arguments

**`ith_class`** : Int, default = nothing
Return the results for the ith class in the ith label of the label list of the given confusion matrix object.

**`class_name`** : Int/String, default = nothing
Return the results for the class of the speicifed value in the ith label of the label list of the given confusion matrix object.

If both `class_name` and `ith_class` arguments are equal to `nothing`, return Fowlkes Mallows Index for all the elements in the labels arrays

## Examples

```julia-repl
julia> y_true = [3, 1, 1, 2, 1, 2, 1, 5, 1, 5];

julia> y_pred = [3, 1, 4, 1, 4, 2, 3, 4, 3, 1];

julia> x = confusion_matrix(y_true, y_pred, labels= [1,2,3,4,5]);

julia> fowlkes_mallows_index(x)
┌ Warning: Zero division, replacing NaN or Inf with 0
└ @ Main Path
┌ Warning: Zero division, replacing NaN or Inf with 0
└ @ Main Path
5-element Array{Float64,1}:
 0.2581988897471611
 0.7071067811865476
 0.5773502691896257
 0.0
 0.0

julia> fowlkes_mallows_index(x, ith_class = 2)
0.7071067811865476

```

_See Also_ :   ```confusion_matrix```, ```matthews_correlation_coeff```, ```threat_score```, ```f1_score```
"""
function fowlkes_mallows_index(c::confusion_matrix; ith_class = nothing, class_name = nothing, average ="binary")
    @assert average in ["binary", "macro"] "Unknown averaging type"
    index = check_index(c.Labels, true, ith_class = ith_class, class_name = class_name)
    if index == -1
        x = [sqrt(positive_predictive_value(c,ith_class = i) * sensitivity_score(c,ith_class = i)) for i in 1:length(c.true_positives)]
        x = clear_output(x,c.zero_division)
        return average == "binary" ? x : mean(x)
    else
        x = sqrt(positive_predictive_value(c,ith_class = index) * sensitivity_score(c,ith_class = index))
        return clear_output(x,c.zero_division)
    end
end

fowlkes_mallows_index(expected::Array{T,1}, predicted::Array{T,1}; ith_class = nothing, class_name = nothing, average = "binary") where T <: Union{Int, String}  =
fowlkes_mallows_index(confusion_matrix(expected,predicted), ith_class = ith_class, class_name = class_name, average = average)

"""

```informedness(c::confusion_matrix; ith_class = nothing, class_name = nothing)```

Return informedness value for the specified class(es).

## Arguments

**`ith_class`** : Int, default = nothing
Return the results for the ith class in the ith label of the label list of the given confusion matrix object.

**`class_name`** : Int/String, default = nothing
Return the results for the class of the speicifed value in the ith label of the label list of the given confusion matrix object.

If both `class_name` and `ith_class` arguments are equal to `nothing`, return informedness value for all the elements in the labels arrays

## Examples

```julia-repl
julia> y_true = [3, 1, 1, 2, 1, 2, 1, 5, 1, 5];

julia> y_pred = [3, 1, 4, 1, 4, 2, 3, 4, 3, 1];

julia> x = confusion_matrix(y_true, y_pred, labels= [1,2,3,4,5]);

julia> informedness(x)
┌ Warning: Zero division, replacing NaN or Inf with 0
└ @ Path
5-element Array{Float64,1}:
 -0.19999999999999996
  0.5
  0.7777777777777777
 -0.30000000000000004
  0.0

julia> informedness(x,ith_class = 3)
0.7777777777777777

```

_See Also_ :   ```confusion_matrix```, ```matthews_correlation_coeff```, ```markedness```, ```f1_score```
"""
function informedness(c::confusion_matrix; ith_class = nothing, class_name = nothing, average = "binary")
    @assert average in ["binary", "macro"] "Unknown averaging type"
    index = check_index(c.Labels, true, ith_class = ith_class, class_name = class_name)
    if index == -1
        x = [ ( specificity_score(c,ith_class = i) + sensitivity_score(c,ith_class = i) -1) for i in 1:length(c.true_positives)]
        x = clear_output(x,c.zero_division)
        return average == "binary" ? x : mean(x)
    else
        x = specificity_score(c,ith_class = index) + sensitivity_score(c,ith_class = index) -1
        return clear_output(x,c.zero_division)
    end
end

informedness(expected::Array{T,1}, predicted::Array{T,1}; ith_class = nothing, class_name = nothing, average = "binary") where T <: Union{Int, String}  =
informedness(confusion_matrix(expected,predicted), ith_class = ith_class, class_name = class_name, average = average)

"""

```markedness(c::confusion_matrix; ith_class = nothing, class_name = nothing)```

Return markedness value for the specified class(es).

## Arguments

**`ith_class`** : Int, default = nothing
Return the results for the ith class in the ith label of the label list of the given confusion matrix object.

**`class_name`** : Int/String, default = nothing
Return the results for the class of the speicifed value in the ith label of the label list of the given confusion matrix object.

If both `class_name` and `ith_class` arguments are equal to `nothing`, return  markedness value for all the elements in the labels arrays

## Examples

```julia-repl
julia> y_true = [3, 1, 1, 2, 1, 2, 1, 5, 1, 5];

julia> y_pred = [3, 1, 4, 1, 4, 2, 3, 4, 3, 1];

julia> x = confusion_matrix(y_true, y_pred, labels= [1,2,3,4,5]);

julia> markedness(x)
┌ Warning: Zero division, replacing NaN or Inf with 0
└ @ Path
5-element Array{Float64,1}:
 -0.8571428571428572
 -0.11111111111111116
 -0.6666666666666667
 -1.0
 -1.0

julia> markedness(x, ith_class = 1)
-0.19999999999999996

```

_See Also_ :   ```confusion_matrix```, ```matthews_correlation_coeff```, ```informedness```, ```f1_score```

"""
function markedness(c::confusion_matrix; ith_class = nothing, class_name = nothing, average = "binary")
    @assert average in ["binary", "macro"] "Unknown averaging type"
    index = check_index(c.Labels, true, ith_class = ith_class, class_name = class_name)
    if index == -1
        x = [( precision_score(c,ith_class = i) * negative_predictive_value(c,ith_class = i) -1) for i in 1:length(c.true_positives)]
        x = clear_output(x,c.zero_division)
        return average == "binary" ? x : mean(x)
    else
        x =  specificity_score(c,ith_class = index) + sensitivity_score(c,ith_class = index) -1
        return clear_output(x,c.zero_division)
    end
end

markedness(expected::Array{T,1}, predicted::Array{T,1}; ith_class = nothing, class_name = nothing, average = "binary") where T <: Union{Int, String}  =
markedness(confusion_matrix(expected,predicted), ith_class = ith_class, class_name = class_name, average = average)

"""
```cohen_kappa_score(c::confusion_matrix; weights = nothing) ```

Return Cohen's Kappa (a statistic that measures inter-annotator agreement)

## Examples

```julia-repl
julia> y_true = [3, 1, 1, 2, 1, 2, 1, 5, 1, 5];

julia> y_pred = [3, 1, 4, 1, 4, 2, 3, 4, 3, 1];

julia> x = confusion_matrix(y_true, y_pred, labels= [1,2,3,4,5]);

julia> cohen_kappa_score(x)
0.125
```

_See Also_ :   ```confusion_matrix```, ```accuracy_score```, ```jaccard_score```, ```f1_score```

"""
function cohen_kappa_score(c::confusion_matrix; weights = nothing)
#reference: scikitlearn.metrics.classification.cohen_kappa_score
    @assert weights in [nothing, "quadratic", "linear"] "Unknown kappa weighting type"
    w_mat = nothing
    sum0 = sum(c.matrix, dims = 1)
    sum1 = sum(c.matrix, dims = 2)
    expected = (sum1 * sum0) ./ sum(sum0)
    if weights == nothing
        w_mat = ones(length(c.Labels),length(c.Labels))
        for i in 1:length(c.Labels)
            w_mat[i,i] = 0
        end
    else
        w_mat = zeros(length(c.Labels),length(c.Labels))
        w_mat += [i for i in 1:length(c.Labels)]
        if weights == "linear"
            w_mat = abs(w_mat - transpose(w_mat))
        else
            w_mat = (w_mat - transpose(w_mat)) ^2
        end
    end
    x = sum(w_mat .* c.matrix) / sum(w_mat .* expected)
    return clear_output(1- x,c.zero_division)
end

cohen_kappa_score(expected::Array{T,1}, predicted::Array{T,1}; weights = nothing) where T <: Union{Int, String}  =
cohen_kappa_score(confusion_matrix(expected,predicted), weights = nothing)

"""

```hamming_loss(c::confusion_matrix) ```

Compute the average Hamming loss.
    The Hamming loss is the fraction of labels that are incorrectly predicted.

## Examples

```julia-repl
julia> y_true = [3, 1, 1, 2, 1, 2, 1, 5, 1, 5];

julia> y_pred = [3, 1, 4, 1, 4, 2, 3, 4, 3, 1];

julia> x = confusion_matrix(y_true, y_pred, labels= [1,2,3,4,5]);

julia> hamming_loss(x)
0.7
```

_See Also_ :   ```confusion_matrix```, ```accuracy_score```, ```jaccard_score```, ```f1_score```

"""
function hamming_loss(c::confusion_matrix;)
    x = zeros(sum(c.matrix))
    x[1] = sum(c.false_negatives)
    return clear_output(mean(x), c.zero_division)
end

hamming_loss(expected::Array{T,1}, predicted::Array{T,1};) where T <: Union{Int, String}  =
hamming_loss(confusion_matrix(expected,predicted))

"""

```jaccard_score(c::confusion_matrix; average = "binary", sample_weight = nothing) ```

Compute Jaccard similarity coefficient score
    The Jaccard index [1], or Jaccard similarity coefficient, defined as
    the size of the intersection divided by the size of the union of two label
    sets, is used to compare set of predicted labels for a sample to the
    corresponding set of labels in ``y_true``.

## Keywords

average : string [None, 'binary' (default), 'micro', 'macro', 'samples, 'weighted']
    If ``None``, the scores for each class are returned. Otherwise, this
    determines the type of averaging performed on the data:
    ``binary``:
        Only report results for the class specified by ``pos_label``.
    ``micro``:
        Calculate metrics globally by counting the total true positives,
        false negatives and false positives.
    ``macro``:
        Calculate metrics for each label, and find their unweighted
        mean.  This does not take label imbalance into account.
    ``weighted``:
        Calculate metrics for each label, and find their average, weighted
        by support (the number of true instances for each label). This
        alters 'macro' to account for label imbalance.
    ``samples``:
        Calculate metrics for each instance, and find their average (only
        meaningful for multilabel classification).
sample_weight : array-like of shape (n_samples,), default=None
    Sample weights.

## Examples

```julia-repl
julia> y_true = [3, 1, 1, 2, 1, 2, 1, 5, 1, 5];

julia> y_pred = [3, 1, 4, 1, 4, 2, 3, 4, 3, 1];

julia> x = confusion_matrix(y_true, y_pred, labels= [1,2,3,4,5]);

julia> hamming_loss(x)
0.7
```

## References

[1] [Wikipedia entry for the Jaccard index](https://en.wikipedia.org/wiki/Jaccard_index)


_See Also_ :   ```confusion_matrix```, ```accuracy_score```, ```hamming_loss```, ```f1_score```

"""
function jaccard_score(c::confusion_matrix; average = "binary", sample_weight = nothing)
    @assert average in [nothing, "binary", "weighted", "samples", "micro", "macro"] "Unknown averaging type"
    if sample_weight != nothing @assert length(sample_weight) == length(c.true_positives) "Dimensions of given sample weight does not match the confusion matrix"; end
    numerator = c.true_positives
    denominator =  c.true_positives + c.false_negatives + c.false_positives
    if average == nothing
        x = numerator ./ denominator
        return clear_output(x, c.zero_division)
    elseif average == "micro"
        numerator = sum(numerator)
        denominator = sum(denominator)
        x = numerator ./ denominator
        return clear_output(x, c.zero_division)
    elseif average == "macro"
        numerator = c.true_positives
        denominator =  c.true_positives + c.false_negatives + c.false_positives
        x = numerator ./ denominator
        return clear_output(mean(x), c.zero_division)
    elseif average == "weighted" || average == "samples"
        weights = nothing
        if average == "weighted"
            weights = c.false_negatives + c.true_positives
        elseif average == "samples"
            weights = sample_weight
        end
        score = numerator ./ denominator
        x = [weights[i] * score[i] for i in 1:length(c.Labels)]
        x / length(c.Labels)
        return clear_output(x, c.zero_division)
    else
        x = [(c.false_negatives[i] + c.true_positives[i])/length(c.Labels) for i in 1:length(c.Labels)]
        return clear_output(x, c.zero_division)
    end
end

jaccard_score(expected::Array{T,1}, predicted::Array{T,1}; average = "binary", sample_weight = nothing) where T <: Union{Int, String}  =
jaccard_score(confusion_matrix(expected,predicted), average = average, sample_weight = sample_weight)
