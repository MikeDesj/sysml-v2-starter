package KineticObserver_Phys {
    import STM32Catalog::*;
    import SensorCatalog::*;
    import KineticObserver_Func::*; // Import logic to allocate it to hardware

    part board_assembly {
        part mcu : STM32G4;
        part imu : LSM6DSO;
        
        // Allocation: The "acquire_data" logic happens on the "mcu"
        allocation def LogicToHardware {
            end logic_action;
            end hardware_part;
        }
    }
}