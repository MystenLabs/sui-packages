module 0x29942c78899e58dd812520379d728f025577dd6fb542decf4970c176807fb6b4::dex_aftermath {
    struct AftermathSwapExecuted has copy, drop {
        sender: address,
        amount_in: u64,
        min_amount_out: u64,
        pool_id: address,
        method: vector<u8>,
    }

    public fun calculate_aftermath_output(arg0: u64) : u64 {
        (((arg0 as u128) * 9970 / 10000) as u64)
    }

    public fun calculate_aftermath_usdc_to_sui_output(arg0: u64) : u64 {
        (((arg0 as u128) * 9970 / 10000) as u64)
    }

    fun call_aftermath_router_swap_exact_coin_for_coin(arg0: &0x2::clock::Clock, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, v0);
        let v1 = AftermathSwapExecuted{
            sender         : v0,
            amount_in      : arg2,
            min_amount_out : arg3,
            pool_id        : get_aftermath_pool(),
            method         : b"router_swap_exact_coin_for_coin",
        };
        0x2::event::emit<AftermathSwapExecuted>(v1);
    }

    fun call_aftermath_swap_exact_coin_for_coin(arg0: &0x2::clock::Clock, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: address, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, v0);
        let v1 = AftermathSwapExecuted{
            sender         : v0,
            amount_in      : arg3,
            min_amount_out : arg4,
            pool_id        : arg2,
            method         : b"swap_exact_coin_for_coin",
        };
        0x2::event::emit<AftermathSwapExecuted>(v1);
    }

    public fun get_aftermath_package() : address {
        @0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c
    }

    public fun get_aftermath_packages() : (address, address) {
        (@0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c, @0x7871c4b3c847a0f674510d4978d5cf6f960452795e8ff6f189fd2088a3f47dc)
    }

    public fun get_aftermath_pool() : address {
        @0x7871c4b3c847a0f674510d4978d5cf6f960452795e8ff6f189fd2088a3f47dc
    }

    public fun get_dex_info() : (vector<u8>, vector<u8>, u64) {
        (b"Aftermath", b"0.30% fee AMM DEX", 9970)
    }

    public fun get_supported_methods() : vector<vector<u8>> {
        vector[b"swap_exact_coin_for_coin", b"router_swap_exact_coin_for_coin"]
    }

    public entry fun swap_sui_to_usdc_router(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 3401);
        assert!(calculate_aftermath_output(v0) >= arg1, 3402);
        call_aftermath_router_swap_exact_coin_for_coin(arg2, arg0, v0, arg1, arg3);
    }

    public entry fun swap_sui_to_usdc_simple(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 3401);
        assert!(calculate_aftermath_output(v0) >= arg1, 3402);
        call_aftermath_swap_exact_coin_for_coin(arg2, arg0, get_aftermath_pool(), v0, arg1, arg3);
    }

    public fun validate_swap_params(arg0: u64, arg1: u64) : bool {
        if (arg0 > 0) {
            if (arg1 > 0) {
                arg0 >= 1000000
            } else {
                false
            }
        } else {
            false
        }
    }

    // decompiled from Move bytecode v6
}

