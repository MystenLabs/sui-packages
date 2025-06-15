module 0xc1baa95c7d2143f42b1e0f9cc01ab88814da1d7628471f9a9cb6817330b5771b::dex_cetus {
    struct CetusSwapExecuted has copy, drop {
        pool: address,
        amount_in: u64,
        amount_out: u64,
        fee_amount: u64,
        sqrt_price_after: u128,
    }

    public fun swap<T0, T1>(arg0: address, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u128, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 602);
        assert!(is_valid_pool(arg0), 601);
        let v1 = CetusSwapExecuted{
            pool             : arg0,
            amount_in        : v0,
            amount_out       : 0,
            fee_amount       : v0 * 25 / 10000,
            sqrt_price_after : arg3,
        };
        0x2::event::emit<CetusSwapExecuted>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0x2::tx_context::sender(arg4));
        0x2::coin::from_balance<T1>(0x2::balance::zero<T1>(), arg4)
    }

    fun calculate_price_impact(arg0: u64, arg1: address) : u64 {
        if (arg1 == @0xcf994611fd4c48e277ce3ffd4d4364c914af2c3cbb05f7bf6facd371de688630) {
            if (arg0 > 10000000000) {
                100
            } else if (arg0 > 1000000000) {
                30
            } else {
                5
            }
        } else if (arg0 > 1000000000) {
            80
        } else if (arg0 > 100000000) {
            40
        } else {
            10
        }
    }

    public fun calculate_sqrt_price_limit(arg0: u64, arg1: bool, arg2: u64) : u128 {
        if (arg1) {
            (18446744073709551616 as u128)
        } else {
            (18446744073709551616 as u128)
        }
    }

    public fun get_pool_fee(arg0: address) : u64 {
        if (arg0 == @0x40dc6a93bd4f26ea9507c70f19eb1a060fd5cb9c3718db372f4ae711ffbbb29) {
            25
        } else if (arg0 == @0xde016b9e743142fa66783611434d6bc35b78b51ceb9fe574d0d00e71e41d01d7) {
            100
        } else if (arg0 == @0xcf994611fd4c48e277ce3ffd4d4364c914af2c3cbb05f7bf6facd371de688630) {
            25
        } else {
            30
        }
    }

    public fun get_quote(arg0: address, arg1: u64, arg2: bool) : (u64, u64) {
        let v0 = arg1 * get_pool_fee(arg0) / 10000;
        let v1 = arg1 - v0;
        (v1 - v1 * calculate_price_impact(arg1, arg0) / 10000, v0)
    }

    public fun get_swap_params(arg0: address) : (u64, u64, bool) {
        if (arg0 == @0x6d8af9e6afd27262db436f0d37b304a041f710c3ea1fa4c3a9bab36b3569ad3) {
            (2500, 50, true)
        } else if (arg0 == @0xcf994611fd4c48e277ce3ffd4d4364c914af2c3cbb05f7bf6facd371de688630) {
            (2500, 50, true)
        } else {
            (3000, 60, true)
        }
    }

    fun is_valid_pool(arg0: address) : bool {
        if (arg0 == @0xcf994611fd4c48e277ce3ffd4d4364c914af2c3cbb05f7bf6facd371de688630) {
            true
        } else if (arg0 == @0x40dc6a93bd4f26ea9507c70f19eb1a060fd5cb9c3718db372f4ae711ffbbb29) {
            true
        } else {
            arg0 == @0xde016b9e743142fa66783611434d6bc35b78b51ceb9fe574d0d00e71e41d01d7
        }
    }

    public entry fun swap_for_arbitrage<T0, T1>(arg0: address, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(is_valid_pool(arg0), 601);
        assert!(0x2::coin::value<T0>(&arg1) >= arg2, 602);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, arg3);
        let v0 = CetusSwapExecuted{
            pool             : arg0,
            amount_in        : 0x2::coin::value<T0>(&arg1),
            amount_out       : 0,
            fee_amount       : 0,
            sqrt_price_after : 0,
        };
        0x2::event::emit<CetusSwapExecuted>(v0);
    }

    // decompiled from Move bytecode v6
}

