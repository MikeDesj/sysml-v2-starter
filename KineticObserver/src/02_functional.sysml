package KineticObserver_Func {
    import KineticObserver_Reqs::*;

    // The logical flow of data
    part def DataLoggerLogic {
        // Defines that we "Acquire" then "Filter" then "Store"
        action acquire_data;
        action write_to_storage;
    }
}