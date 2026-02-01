package STM32Catalog {
    import EmbeddedProtocols::*; // Import the protocols to use in ports

    part def STM32G4 {
        attribute clockSpeed : ISQ::Frequency;
        port spi1 : SPI_Interface::SPI_Master;
        // ...
    }
}