module 0x60ef9da2df42577f3672d52a0b3ab896a4a85974acd7447b01a030d7b70adffb::dex_deepbook {
    public fun get_deepbook_package() : address {
        @0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809
    }

    public fun get_deepbook_pool() : address {
        0x60ef9da2df42577f3672d52a0b3ab896a4a85974acd7447b01a030d7b70adffb::constants::deepbook_sui_usdc_pool()
    }

    public fun get_deepbook_pool_creator() : address {
        @0x8c4ef8e0b969e8ebf42e26c48e5edf695d5c29e6b8ad2c9b9c4c8b3b5e7b3e5
    }

    public entry fun swap_sui_to_usdc(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) > 0, 1000);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, 0x2::tx_context::sender(arg2));
    }

    public fun validate_deepbook_swap(arg0: u64, arg1: u64) : bool {
        arg0 > 0 && arg1 >= 0
    }

    // decompiled from Move bytecode v6
}

