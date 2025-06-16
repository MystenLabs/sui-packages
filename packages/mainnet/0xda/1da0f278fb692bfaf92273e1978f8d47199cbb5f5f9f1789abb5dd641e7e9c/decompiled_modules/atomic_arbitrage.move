module 0xda1da0f278fb692bfaf92273e1978f8d47199cbb5f5f9f1789abb5dd641e7e9c::atomic_arbitrage {
    struct SwapExecuted has copy, drop {
        sender: address,
        pool_id: address,
        amount_in: u64,
        amount_out: u64,
        is_a2b: bool,
    }

    public entry fun execute_arbitrage(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) > 0, 700);
        assert!(arg1 > 0, 701);
        0xda1da0f278fb692bfaf92273e1978f8d47199cbb5f5f9f1789abb5dd641e7e9c::dex_bluefin::swap_sui_to_usdc(arg0, arg1, arg2, arg3);
    }

    public fun get_bluefin_package() : address {
        @0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267
    }

    public fun get_bluefin_pool() : address {
        @0x3b585786b13af1d8ea067ab37101b6513a05d2f90cfe60e8b1d9e1b46a63c4fa
    }

    public fun get_cetus_package() : address {
        @0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb
    }

    public fun get_cetus_pool() : address {
        @0xcf994611fd4c48e277ce3ffd4d4364c914af2c3cbb05f7bf6facd371de688630
    }

    public fun get_turbos_package() : address {
        @0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1
    }

    public fun get_turbos_pool() : address {
        @0x5eb2dfcdd1b15d2021328258f6d5ec081e9a0cdcfa9e13a0eaeb9b5f7505ca78
    }

    public entry fun swap_tokens_bluefin(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: bool, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 700);
        0xda1da0f278fb692bfaf92273e1978f8d47199cbb5f5f9f1789abb5dd641e7e9c::dex_bluefin::swap_sui_to_usdc(arg0, arg1, arg3, arg4);
        let v1 = SwapExecuted{
            sender     : 0x2::tx_context::sender(arg4),
            pool_id    : @0x3b585786b13af1d8ea067ab37101b6513a05d2f90cfe60e8b1d9e1b46a63c4fa,
            amount_in  : v0,
            amount_out : arg1,
            is_a2b     : true,
        };
        0x2::event::emit<SwapExecuted>(v1);
    }

    public entry fun swap_tokens_cetus(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: bool, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 700);
        0xda1da0f278fb692bfaf92273e1978f8d47199cbb5f5f9f1789abb5dd641e7e9c::dex_cetus::swap_sui_to_usdc(arg0, arg1, arg3, arg4);
        let v1 = SwapExecuted{
            sender     : 0x2::tx_context::sender(arg4),
            pool_id    : @0xcf994611fd4c48e277ce3ffd4d4364c914af2c3cbb05f7bf6facd371de688630,
            amount_in  : v0,
            amount_out : arg1,
            is_a2b     : true,
        };
        0x2::event::emit<SwapExecuted>(v1);
    }

    public entry fun swap_tokens_turbos(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: bool, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 700);
        0xda1da0f278fb692bfaf92273e1978f8d47199cbb5f5f9f1789abb5dd641e7e9c::dex_turbos::swap_sui_to_usdc(arg0, arg1, arg3, arg4);
        let v1 = SwapExecuted{
            sender     : 0x2::tx_context::sender(arg4),
            pool_id    : @0x5eb2dfcdd1b15d2021328258f6d5ec081e9a0cdcfa9e13a0eaeb9b5f7505ca78,
            amount_in  : v0,
            amount_out : arg1,
            is_a2b     : true,
        };
        0x2::event::emit<SwapExecuted>(v1);
    }

    public entry fun test_contract_deployment(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) > 0, 700);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

