module 0x60ef9da2df42577f3672d52a0b3ab896a4a85974acd7447b01a030d7b70adffb::dex_turbos {
    public fun get_turbos_package() : address {
        @0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1
    }

    public fun get_turbos_pool() : address {
        0x60ef9da2df42577f3672d52a0b3ab896a4a85974acd7447b01a030d7b70adffb::constants::turbos_sui_usdc_pool()
    }

    public fun get_turbos_versioned() : address {
        @0x914d1dc85b21e3e096b14df7e1d022a4f1b0b8e97b08a78b8a7ceeea92cbb64d
    }

    public entry fun swap_sui_to_usdc(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) > 0, 800);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, 0x2::tx_context::sender(arg2));
    }

    public fun validate_turbos_swap(arg0: u64, arg1: u64) : bool {
        arg0 > 0 && arg1 >= 0
    }

    // decompiled from Move bytecode v6
}

