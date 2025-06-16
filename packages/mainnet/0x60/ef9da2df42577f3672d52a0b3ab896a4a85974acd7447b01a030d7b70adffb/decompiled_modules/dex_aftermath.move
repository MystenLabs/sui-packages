module 0x60ef9da2df42577f3672d52a0b3ab896a4a85974acd7447b01a030d7b70adffb::dex_aftermath {
    public fun get_aftermath_package() : address {
        @0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf
    }

    public fun get_aftermath_pool() : address {
        0x60ef9da2df42577f3672d52a0b3ab896a4a85974acd7447b01a030d7b70adffb::constants::aftermath_sui_usdc_pool()
    }

    public fun get_aftermath_router() : address {
        @0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82
    }

    public entry fun swap_sui_to_usdc(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) > 0, 1100);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, 0x2::tx_context::sender(arg2));
    }

    public fun validate_aftermath_swap(arg0: u64, arg1: u64) : bool {
        arg0 > 0 && arg1 >= 0
    }

    // decompiled from Move bytecode v6
}

