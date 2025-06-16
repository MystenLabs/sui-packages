module 0xda1da0f278fb692bfaf92273e1978f8d47199cbb5f5f9f1789abb5dd641e7e9c::dex_turbos {
    public fun build_swap_params(arg0: u64, arg1: bool) : (address, address, address, bool, bool, u64, u64) {
        (@0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1, @0x914d1dc85b21e3e096b14df7e1d022a4f1b0b8e97b08a78b8a7ceeea92cbb64d, @0x5eb2dfcdd1b15d2021328258f6d5ec081e9a0cdcfa9e13a0eaeb9b5f7505ca78, arg1, true, arg0, 0)
    }

    public fun get_confirmed_pool() : address {
        @0x5eb2dfcdd1b15d2021328258f6d5ec081e9a0cdcfa9e13a0eaeb9b5f7505ca78
    }

    public fun get_package() : address {
        @0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1
    }

    public fun get_swap_function_name() : vector<u8> {
        b"swap_a_b"
    }

    public fun get_versioned() : address {
        @0x914d1dc85b21e3e096b14df7e1d022a4f1b0b8e97b08a78b8a7ceeea92cbb64d
    }

    public entry fun swap_sui_to_usdc(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 800);
        turbos_swap_router_call(arg0, v0, arg2, arg3);
    }

    public fun turbos_swap_router_call(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, 0x2::tx_context::sender(arg3));
        abort 999
    }

    public fun validate_turbos_swap(arg0: u64, arg1: u64) : bool {
        arg0 > 0 && arg1 >= 0
    }

    // decompiled from Move bytecode v6
}

