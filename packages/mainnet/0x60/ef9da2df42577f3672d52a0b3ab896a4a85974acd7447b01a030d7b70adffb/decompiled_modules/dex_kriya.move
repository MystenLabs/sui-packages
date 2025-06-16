module 0x60ef9da2df42577f3672d52a0b3ab896a4a85974acd7447b01a030d7b70adffb::dex_kriya {
    public fun get_kriya_package() : address {
        @0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66
    }

    public fun get_kriya_pool() : address {
        0x60ef9da2df42577f3672d52a0b3ab896a4a85974acd7447b01a030d7b70adffb::constants::kriya_sui_usdc_pool()
    }

    public fun get_kriya_spot_dex() : address {
        @0x996c4d9480708fb8b92aa7acf819fb0497b5ec8e65ba06601cae2fb6db3312dd
    }

    public entry fun swap_sui_to_usdc(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) > 0, 900);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, 0x2::tx_context::sender(arg2));
    }

    public fun validate_kriya_swap(arg0: u64, arg1: u64) : bool {
        arg0 > 0 && arg1 >= 0
    }

    // decompiled from Move bytecode v6
}

