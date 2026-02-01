package KineticObserver_Project {
    // Import all sub-packages
    import KineticObserver_Reqs::*;
    import KineticObserver_Func::*;
    import KineticObserver_Phys::*;
    
    // Define the top-level system context
    part full_system {
        // Assert that the Physical Architecture satisfies the Requirements
        satisfy DataFidelity by board_assembly;
    }
}