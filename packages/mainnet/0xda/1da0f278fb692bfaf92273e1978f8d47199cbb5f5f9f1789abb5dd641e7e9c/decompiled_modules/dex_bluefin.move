module 0xda1da0f278fb692bfaf92273e1978f8d47199cbb5f5f9f1789abb5dd641e7e9c::dex_bluefin {
    public fun bluefin_gateway_call(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, 0x2::tx_context::sender(arg4));
        abort 999
    }

    public fun build_swap_params(arg0: u64, arg1: bool) : (address, address, address, bool, bool, u64, u64, u128) {
        (@0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267, @0x3db251ba509a8d5d8777b6338836082335d93eecbdd09a11e190a1cff51c352, @0x3b585786b13af1d8ea067ab37101b6513a05d2f90cfe60e8b1d9e1b46a63c4fa, arg1, true, arg0, 0, 79226673515401279992447579055)
    }

    public fun get_confirmed_pool() : address {
        @0x3b585786b13af1d8ea067ab37101b6513a05d2f90cfe60e8b1d9e1b46a63c4fa
    }

    public fun get_global_config() : address {
        @0x3db251ba509a8d5d8777b6338836082335d93eecbdd09a11e190a1cff51c352
    }

    public fun get_package() : address {
        @0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267
    }

    public fun get_sqrt_price_limit() : u128 {
        79226673515401279992447579055
    }

    public entry fun swap_sui_to_usdc(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 500);
        bluefin_gateway_call(arg0, v0, arg1, arg2, arg3);
    }

    public fun validate_bluefin_swap(arg0: u64, arg1: u128) : bool {
        arg0 > 0 && arg1 > 0
    }

    // decompiled from Move bytecode v6
}

