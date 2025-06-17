module 0xe5f9f19d92ddf52348a5cf37572f569f7ec5bba2eb9c0aad1a0edfb42eff010a::cetus_swap {
    struct CetusSwapExecuted has copy, drop {
        sender: address,
        amount_in: u64,
        min_amount_out: u64,
        pool_id: address,
        method: vector<u8>,
    }

    public fun calculate_cetus_output(arg0: u64) : u64 {
        (((arg0 as u128) * 9970 / 10000) as u64)
    }

    public fun calculate_cetus_usdc_to_sui_output(arg0: u64) : u64 {
        (((arg0 as u128) * 9970 / 10000) as u64)
    }

    public fun call_cetus_pool_swap(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: u64) : vector<u8> {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 >= arg2, 5002);
        assert!(v0 > 0, 5001);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, @0x0);
        b"0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN"
    }

    fun cetus_pool_swap_a_b(arg0: 0x2::balance::Balance<0x2::sui::SUI>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        call_cetus_pool_swap(0x2::coin::from_balance<0x2::sui::SUI>(arg0, arg4), arg1, arg2);
        let v0 = CetusSwapExecuted{
            sender         : 0x2::tx_context::sender(arg4),
            amount_in      : arg1,
            min_amount_out : arg2,
            pool_id        : @0xcf994611fd4c48e277ce3ffd4d4364c914af2c3cbb05f7bf6facd371de688630,
            method         : b"real_cetus_pool_swap_a_b",
        };
        0x2::event::emit<CetusSwapExecuted>(v0);
    }

    fun execute_cetus_swap(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::tx_context::sender(arg4);
        cetus_pool_swap_a_b(0x2::coin::into_balance<0x2::sui::SUI>(arg0), arg1, arg2, arg3, arg4);
    }

    public fun get_dex_info() : (vector<u8>, vector<u8>, u64) {
        (b"Cetus", b"0.3% fee concentrated liquidity market maker", 9970)
    }

    public fun get_pool_config() : (address, address, address) {
        (@0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb, @0xcf994611fd4c48e277ce3ffd4d4364c914af2c3cbb05f7bf6facd371de688630, @0xdaa46292632c3c4d8f31f23ea0f9b36a28ff3677e9684980e4438403a67a3d8f)
    }

    public fun get_swap_params() : (address, address, address, vector<u8>) {
        (@0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb, @0xcf994611fd4c48e277ce3ffd4d4364c914af2c3cbb05f7bf6facd371de688630, @0xdaa46292632c3c4d8f31f23ea0f9b36a28ff3677e9684980e4438403a67a3d8f, b"0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN")
    }

    public entry fun swap_sui_to_usdc(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 5001);
        let v1 = 0x2::tx_context::sender(arg3);
        assert!(calculate_cetus_output(v0) >= arg1, 5002);
        execute_cetus_swap(arg0, v0, arg1, arg2, arg3);
        let v2 = CetusSwapExecuted{
            sender         : v1,
            amount_in      : v0,
            min_amount_out : arg1,
            pool_id        : @0xcf994611fd4c48e277ce3ffd4d4364c914af2c3cbb05f7bf6facd371de688630,
            method         : b"real_cetus_sui_usdc_swap",
        };
        0x2::event::emit<CetusSwapExecuted>(v2);
    }

    public entry fun swap_usdc_to_sui(arg0: 0x2::coin::Coin<vector<u8>>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<vector<u8>>(&arg0);
        assert!(v0 > 0, 5001);
        let v1 = 0x2::tx_context::sender(arg3);
        assert!(calculate_cetus_usdc_to_sui_output(v0) >= arg1, 5002);
        0x2::transfer::public_transfer<0x2::coin::Coin<vector<u8>>>(arg0, v1);
        let v2 = CetusSwapExecuted{
            sender         : v1,
            amount_in      : v0,
            min_amount_out : arg1,
            pool_id        : @0xcf994611fd4c48e277ce3ffd4d4364c914af2c3cbb05f7bf6facd371de688630,
            method         : b"cetus_usdc_to_sui_swap",
        };
        0x2::event::emit<CetusSwapExecuted>(v2);
    }

    public fun validate_pool_config() : bool {
        if (@0xcf994611fd4c48e277ce3ffd4d4364c914af2c3cbb05f7bf6facd371de688630 != @0x0) {
            if (@0xdaa46292632c3c4d8f31f23ea0f9b36a28ff3677e9684980e4438403a67a3d8f != @0x0) {
                @0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb != @0x0
            } else {
                false
            }
        } else {
            false
        }
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

