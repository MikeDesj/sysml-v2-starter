package KineticObserver_Reqs {
    import ISQ::*;

    requirement def DataFidelity {
        doc /* Data must be sufficient for PINN training */
        requirement TimeSync { ... }
        requirement SampleRate { attribute rate = 500 [Hz]; }
    }
}