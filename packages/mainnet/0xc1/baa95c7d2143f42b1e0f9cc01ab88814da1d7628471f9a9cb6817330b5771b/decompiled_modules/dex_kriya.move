module 0xc1baa95c7d2143f42b1e0f9cc01ab88814da1d7628471f9a9cb6817330b5771b::dex_kriya {
    struct KriyaSwapExecuted has copy, drop {
        pool: address,
        amount_in: u64,
        amount_out: u64,
        fee_amount: u64,
        protocol: vector<u8>,
    }

    struct KriyaLiquidityAdded has copy, drop {
        pool: address,
        amount_a: u64,
        amount_b: u64,
        lp_tokens_minted: u64,
    }

    public fun swap<T0, T1>(arg0: address, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 902);
        let v1 = if (arg3) {
            b"CLMM"
        } else {
            b"AMM"
        };
        let v2 = v0 * get_pool_fee(arg0, arg3) / 10000;
        let v3 = v0 - v2;
        let v4 = v3 - v3 * calculate_price_impact(v0, arg0) / 10000;
        assert!(v4 >= arg2, 903);
        let v5 = KriyaSwapExecuted{
            pool       : arg0,
            amount_in  : v0,
            amount_out : v4,
            fee_amount : v2,
            protocol   : v1,
        };
        0x2::event::emit<KriyaSwapExecuted>(v5);
        abort 901
    }

    public fun add_liquidity<T0, T1>(arg0: address, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::coin::value<T0>(&arg1);
        let v1 = 0x2::coin::value<T1>(&arg2);
        assert!(v0 > 0 && v1 > 0, 902);
        let v2 = calculate_lp_tokens(v0, v1, arg0);
        assert!(v2 >= arg3, 903);
        let v3 = KriyaLiquidityAdded{
            pool             : arg0,
            amount_a         : v0,
            amount_b         : v1,
            lp_tokens_minted : v2,
        };
        0x2::event::emit<KriyaLiquidityAdded>(v3);
        0x2::coin::destroy_zero<T0>(arg1);
        0x2::coin::destroy_zero<T1>(arg2);
        v2
    }

    fun calculate_input_for_exact_output(arg0: u64, arg1: u64, arg2: address) : u64 {
        let v0 = arg0 + arg0 * calculate_price_impact(arg0, arg2) / 10000;
        v0 + v0 * arg1 / 10000
    }

    fun calculate_lp_tokens(arg0: u64, arg1: u64, arg2: address) : u64 {
        (arg0 + arg1) / 2
    }

    fun calculate_price_impact(arg0: u64, arg1: address) : u64 {
        if (arg1 == @0x81ac578c80c8ea8ec811e5539b9864f7f4e32c1cf38174f8ac338dce87d4928d) {
            if (arg0 > 5000000000) {
                100
            } else if (arg0 > 500000000) {
                40
            } else {
                10
            }
        } else if (arg0 > 1000000000) {
            80
        } else if (arg0 > 100000000) {
            30
        } else {
            8
        }
    }

    public fun get_pool_fee(arg0: address, arg1: bool) : u64 {
        if (arg1) {
            25
        } else {
            30
        }
    }

    public fun get_quote(arg0: address, arg1: u64, arg2: bool) : (u64, u64) {
        let v0 = arg1 * get_pool_fee(arg0, arg2) / 10000;
        let v1 = arg1 - v0;
        (v1 - v1 * calculate_price_impact(arg1, arg0) / 10000, v0)
    }

    public fun supports_clmm(arg0: address) : bool {
        arg0 != @0x0
    }

    public fun swap_exact_out<T0, T1>(arg0: address, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T0>) {
        assert!(0x2::coin::value<T0>(&arg1) >= arg3, 902);
        let v0 = calculate_input_for_exact_output(arg2, get_pool_fee(arg0, false), arg0);
        assert!(v0 <= arg3, 903);
        let v1 = 0x2::coin::split<T0>(&mut arg1, v0, arg4);
        (swap<T0, T1>(arg0, v1, arg2, false, arg4), arg1)
    }

    // decompiled from Move bytecode v6
}

