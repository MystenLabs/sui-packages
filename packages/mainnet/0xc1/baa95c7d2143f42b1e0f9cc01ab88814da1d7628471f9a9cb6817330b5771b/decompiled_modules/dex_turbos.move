module 0xc1baa95c7d2143f42b1e0f9cc01ab88814da1d7628471f9a9cb6817330b5771b::dex_turbos {
    struct TurbosSwapExecuted has copy, drop {
        pool: address,
        amount_in: u64,
        amount_out: u64,
        fee_amount: u64,
        sqrt_price_after: u128,
        liquidity: u128,
    }

    public fun swap<T0, T1>(arg0: address, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u128, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 702);
        assert!(is_valid_pool(arg0), 701);
        let v1 = v0 * get_pool_fee(arg0) / 10000;
        let (v2, v3) = calculate_swap_output(v0 - v1, arg0, arg4);
        assert!(v2 >= arg2, 703);
        let v4 = if (arg3 > 0) {
            arg3
        } else {
            calculate_new_sqrt_price(v0, arg0)
        };
        let v5 = TurbosSwapExecuted{
            pool             : arg0,
            amount_in        : v0,
            amount_out       : v2,
            fee_amount       : v1,
            sqrt_price_after : v4,
            liquidity        : v3,
        };
        0x2::event::emit<TurbosSwapExecuted>(v5);
        abort 701
    }

    public fun add_liquidity<T0, T1>(arg0: address, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: u32, arg4: u32, arg5: &mut 0x2::tx_context::TxContext) : u64 {
        0x2::coin::destroy_zero<T0>(arg1);
        0x2::coin::destroy_zero<T1>(arg2);
        (0x2::coin::value<T0>(&arg1) + 0x2::coin::value<T1>(&arg2)) / 2
    }

    fun calculate_new_sqrt_price(arg0: u64, arg1: address) : u128 {
        let v0 = 79228162514264337593543950336;
        if (arg0 > 1000000000) {
            v0 + v0 / 1000
        } else if (arg0 > 100000000) {
            v0 + v0 / 10000
        } else {
            v0
        }
    }

    fun calculate_swap_output(arg0: u64, arg1: address, arg2: bool) : (u64, u128) {
        let v0 = if (arg1 == @0x82e3d6ebeb2e7d145c73a88845b210e31905d38b7539c30cc420a0e4e8f30fcd) {
            if (arg0 > 5000000000) {
                80
            } else if (arg0 > 500000000) {
                25
            } else {
                8
            }
        } else if (arg0 > 1000000000) {
            100
        } else if (arg0 > 100000000) {
            50
        } else {
            15
        };
        (arg0 - arg0 * v0 / 10000, 1000000000000)
    }

    public fun get_pool_fee(arg0: address) : u64 {
        if (arg0 == @0x82e3d6ebeb2e7d145c73a88845b210e31905d38b7539c30cc420a0e4e8f30fcd) {
            30
        } else if (arg0 == @0x2c6fc12bf0d093b5391e7c0fed7e044d52bc14eb29f6352a3fb358e33e80729e) {
            30
        } else if (arg0 == @0xe95b59189339a87ea5219ebd5fa168f5d568d015ac5c3f192eecf0d090ec832d) {
            25
        } else {
            30
        }
    }

    public fun get_quote(arg0: address, arg1: u64, arg2: bool) : (u64, u64, u128) {
        let v0 = arg1 * get_pool_fee(arg0) / 10000;
        let (v1, v2) = calculate_swap_output(arg1 - v0, arg0, arg2);
        (v1, v0, v2)
    }

    fun is_valid_pool(arg0: address) : bool {
        if (arg0 == @0x82e3d6ebeb2e7d145c73a88845b210e31905d38b7539c30cc420a0e4e8f30fcd) {
            true
        } else if (arg0 == @0x2c6fc12bf0d093b5391e7c0fed7e044d52bc14eb29f6352a3fb358e33e80729e) {
            true
        } else {
            arg0 == @0xe95b59189339a87ea5219ebd5fa168f5d568d015ac5c3f192eecf0d090ec832d
        }
    }

    public fun swap_multi_hop<T0, T1, T2>(arg0: address, arg1: address, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        let v0 = swap<T0, T1>(arg0, arg2, 0, 0, true, arg4);
        swap<T1, T2>(arg1, v0, arg3, 0, true, arg4)
    }

    // decompiled from Move bytecode v6
}

