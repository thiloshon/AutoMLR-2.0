flows <- readRDS("data/tables/flows.RDS")
qualities <- readRDS("data/tables/qualities.RDS")
runs <- readRDS("data/tables/runs.RDS")
tasks <- readRDS("data/tables/tasks.RDS")

flows_minimized <- flows[, c("id", "name")]
qualities_minimized <- qualities
runs_minimized <-
  runs[, c(
    "run_id",
    "task_id",
    "task_evaluation_measure",
    "flow_id",
    "flow_name",
    "input_data_dataset",
    "area_under_roc_curve",
    "average_cost",
    "kappa",
    "kb_relative_information_score",
    "mean_absolute_error",
    "mean_prior_absolute_error",
    "predictive_accuracy",
    "prior_entropy",
    "recall",
    "relative_absolute_error",
    "root_mean_prior_squared_error",
    "root_mean_squared_error",
    "root_relative_squared_error",
    "scimark_benchmark",
    "total_cost",
    "f_measure",
    "precision",
    "build_cpu_time",
    "error",
    "build_memory",
    "num-slots",
    "run_cpu_time"
  )]

tasks_minimized <-
  tasks[, c(
    "task.id",
    "task.type",
    "dataset",
    "estimation.procedure",
    "number_repeats",
    "number_folds",
    "stratified_sampling",
    "number_samples",
    "evaluation.measures"
  )]
