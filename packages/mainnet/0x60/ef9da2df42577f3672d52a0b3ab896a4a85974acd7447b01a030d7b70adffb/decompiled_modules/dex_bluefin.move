module 0x60ef9da2df42577f3672d52a0b3ab896a4a85974acd7447b01a030d7b70adffb::dex_bluefin {
    public fun get_bluefin_global_config() : address {
        0x60ef9da2df42577f3672d52a0b3ab896a4a85974acd7447b01a030d7b70adffb::constants::bluefin_global_config()
    }

    public fun get_bluefin_package() : address {
        0x60ef9da2df42577f3672d52a0b3ab896a4a85974acd7447b01a030d7b70adffb::constants::bluefin_package()
    }

    public fun get_bluefin_pool() : address {
        0x60ef9da2df42577f3672d52a0b3ab896a4a85974acd7447b01a030d7b70adffb::constants::bluefin_sui_usdc_pool()
    }

    public fun prepare_swap_transaction<T0, T1>(arg0: u64, arg1: address, arg2: u64, arg3: bool) : bool {
        if (arg0 > 0) {
            if (arg1 != @0x0) {
                arg2 >= 0
            } else {
                false
            }
        } else {
            false
        }
    }

    public entry fun swap_sui_to_usdc(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) > 0, 500);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, 0x2::tx_context::sender(arg3));
    }

    public fun validate_swap_params(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : bool {
        arg0 > 0 && arg3 <= arg2
    }

    // decompiled from Move bytecode v6
}

