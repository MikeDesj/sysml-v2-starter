package STM32Catalog {
    private import EmbeddedProtocols::*; // Import the protocols to use in ports

    part def STM32G4 {
        attribute clockSpeed : ISQ::frequency;
        port spi1 : SPI_Interface::master;
        // ...
    }
}