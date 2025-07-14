module 0xa260797fe88fbf93b1020c6688e9c40d5d95c374892faea632f0b2b04c3f602a::atomic_arbitrage {
    struct OptimizedArbitrageResult has drop {
        profit: u64,
        gas_used: u64,
        success: bool,
    }

    struct ArbitrageResult has drop {
        input_amount: u64,
        output_amount: u64,
        intermediate_amount: u64,
        profit: u64,
        dex_a: vector<u8>,
        dex_b: vector<u8>,
        success: bool,
    }

    public entry fun arb_aftermath_cetus<T0>(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: vector<u8>, arg2: vector<u8>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 >= 1000000, 1);
        let v1 = 0xa260797fe88fbf93b1020c6688e9c40d5d95c374892faea632f0b2b04c3f602a::dex_aftermath::swap_exact_sui_for_token<T0>(arg0, arg1, 0, arg4);
        let v2 = 0x2::coin::value<T0>(&v1);
        assert!(v2 > 0, 2);
        let v3 = 0xa260797fe88fbf93b1020c6688e9c40d5d95c374892faea632f0b2b04c3f602a::dex_cetus::swap_exact_token_for_sui<T0>(v1, arg2, arg3, arg4);
        let v4 = 0x2::coin::value<0x2::sui::SUI>(&v3);
        assert!(v4 >= arg3, 4);
        let v5 = if (v4 > v0) {
            v4 - v0
        } else {
            0
        };
        assert!(v5 > 0, 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v3, 0x2::tx_context::sender(arg4));
        ArbitrageResult{input_amount: v0, output_amount: v4, intermediate_amount: v2, profit: v5, dex_a: b"aftermath", dex_b: b"cetus", success: true};
    }

    public entry fun arb_bluefin_turbos<T0>(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: vector<u8>, arg2: vector<u8>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 >= 1000000, 1);
        let v1 = 0xa260797fe88fbf93b1020c6688e9c40d5d95c374892faea632f0b2b04c3f602a::dex_bluefin::swap_exact_sui_for_token<T0>(arg0, arg1, 0, arg4);
        let v2 = 0x2::coin::value<T0>(&v1);
        assert!(v2 > 0, 2);
        let v3 = 0xa260797fe88fbf93b1020c6688e9c40d5d95c374892faea632f0b2b04c3f602a::dex_turbos::swap_exact_token_for_sui<T0>(v1, arg2, arg3, arg4);
        let v4 = 0x2::coin::value<0x2::sui::SUI>(&v3);
        assert!(v4 >= arg3, 4);
        let v5 = if (v4 > v0) {
            v4 - v0
        } else {
            0
        };
        assert!(v5 > 0, 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v3, 0x2::tx_context::sender(arg4));
        ArbitrageResult{input_amount: v0, output_amount: v4, intermediate_amount: v2, profit: v5, dex_a: b"bluefin", dex_b: b"turbos", success: true};
    }

    public entry fun arb_cetus_aftermath<T0>(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: vector<u8>, arg2: vector<u8>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 >= 1000000, 1);
        let v1 = 0xa260797fe88fbf93b1020c6688e9c40d5d95c374892faea632f0b2b04c3f602a::dex_cetus::swap_exact_sui_for_token<T0>(arg0, arg1, 0, arg4);
        let v2 = 0x2::coin::value<T0>(&v1);
        assert!(v2 > 0, 2);
        let v3 = 0xa260797fe88fbf93b1020c6688e9c40d5d95c374892faea632f0b2b04c3f602a::dex_aftermath::swap_exact_token_for_sui<T0>(v1, arg2, arg3, arg4);
        let v4 = 0x2::coin::value<0x2::sui::SUI>(&v3);
        assert!(v4 >= arg3, 4);
        let v5 = if (v4 > v0) {
            v4 - v0
        } else {
            0
        };
        assert!(v5 > 0, 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v3, 0x2::tx_context::sender(arg4));
        ArbitrageResult{input_amount: v0, output_amount: v4, intermediate_amount: v2, profit: v5, dex_a: b"cetus", dex_b: b"aftermath", success: true};
    }

    public entry fun arb_cetus_bluefin<T0>(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: vector<u8>, arg2: vector<u8>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 >= 1000000, 1);
        let v1 = 0xa260797fe88fbf93b1020c6688e9c40d5d95c374892faea632f0b2b04c3f602a::dex_cetus::swap_exact_sui_for_token<T0>(arg0, arg1, 0, arg4);
        let v2 = 0x2::coin::value<T0>(&v1);
        assert!(v2 > 0, 2);
        let v3 = 0xa260797fe88fbf93b1020c6688e9c40d5d95c374892faea632f0b2b04c3f602a::dex_bluefin::swap_exact_token_for_sui<T0>(v1, arg2, arg3, arg4);
        let v4 = 0x2::coin::value<0x2::sui::SUI>(&v3);
        assert!(v4 >= arg3, 4);
        let v5 = if (v4 > v0) {
            v4 - v0
        } else {
            0
        };
        assert!(v5 > 0, 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v3, 0x2::tx_context::sender(arg4));
        ArbitrageResult{input_amount: v0, output_amount: v4, intermediate_amount: v2, profit: v5, dex_a: b"cetus", dex_b: b"bluefin", success: true};
    }

    public entry fun arb_kriya_deepbook<T0>(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: vector<u8>, arg2: vector<u8>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 >= 1000000, 1);
        let v1 = 0xa260797fe88fbf93b1020c6688e9c40d5d95c374892faea632f0b2b04c3f602a::dex_kriya::swap_exact_sui_for_token<T0>(arg0, arg1, 0, arg4);
        let v2 = 0x2::coin::value<T0>(&v1);
        assert!(v2 > 0, 2);
        let v3 = 0xa260797fe88fbf93b1020c6688e9c40d5d95c374892faea632f0b2b04c3f602a::dex_deepbook::swap_exact_token_for_sui<T0>(v1, arg2, arg3, arg4);
        let v4 = 0x2::coin::value<0x2::sui::SUI>(&v3);
        assert!(v4 >= arg3, 4);
        let v5 = if (v4 > v0) {
            v4 - v0
        } else {
            0
        };
        assert!(v5 > 0, 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v3, 0x2::tx_context::sender(arg4));
        ArbitrageResult{input_amount: v0, output_amount: v4, intermediate_amount: v2, profit: v5, dex_a: b"kriya", dex_b: b"deepbook", success: true};
    }

    public entry fun arb_single_dex_loop<T0>(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u8, arg2: vector<u8>, arg3: vector<u8>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 >= 1000000, 1);
        let v1 = if (arg1 == 0) {
            0xa260797fe88fbf93b1020c6688e9c40d5d95c374892faea632f0b2b04c3f602a::dex_cetus::swap_exact_token_for_sui<T0>(0xa260797fe88fbf93b1020c6688e9c40d5d95c374892faea632f0b2b04c3f602a::dex_cetus::swap_exact_sui_for_token<T0>(arg0, arg2, 0, arg5), arg3, arg4, arg5)
        } else if (arg1 == 1) {
            0xa260797fe88fbf93b1020c6688e9c40d5d95c374892faea632f0b2b04c3f602a::dex_aftermath::swap_exact_token_for_sui<T0>(0xa260797fe88fbf93b1020c6688e9c40d5d95c374892faea632f0b2b04c3f602a::dex_aftermath::swap_exact_sui_for_token<T0>(arg0, arg2, 0, arg5), arg3, arg4, arg5)
        } else if (arg1 == 2) {
            0xa260797fe88fbf93b1020c6688e9c40d5d95c374892faea632f0b2b04c3f602a::dex_bluefin::swap_exact_token_for_sui<T0>(0xa260797fe88fbf93b1020c6688e9c40d5d95c374892faea632f0b2b04c3f602a::dex_bluefin::swap_exact_sui_for_token<T0>(arg0, arg2, 0, arg5), arg3, arg4, arg5)
        } else if (arg1 == 3) {
            0xa260797fe88fbf93b1020c6688e9c40d5d95c374892faea632f0b2b04c3f602a::dex_turbos::swap_exact_token_for_sui<T0>(0xa260797fe88fbf93b1020c6688e9c40d5d95c374892faea632f0b2b04c3f602a::dex_turbos::swap_exact_sui_for_token<T0>(arg0, arg2, 0, arg5), arg3, arg4, arg5)
        } else if (arg1 == 4) {
            0xa260797fe88fbf93b1020c6688e9c40d5d95c374892faea632f0b2b04c3f602a::dex_kriya::swap_exact_token_for_sui<T0>(0xa260797fe88fbf93b1020c6688e9c40d5d95c374892faea632f0b2b04c3f602a::dex_kriya::swap_exact_sui_for_token<T0>(arg0, arg2, 0, arg5), arg3, arg4, arg5)
        } else {
            0xa260797fe88fbf93b1020c6688e9c40d5d95c374892faea632f0b2b04c3f602a::dex_deepbook::swap_exact_token_for_sui<T0>(0xa260797fe88fbf93b1020c6688e9c40d5d95c374892faea632f0b2b04c3f602a::dex_deepbook::swap_exact_sui_for_token<T0>(arg0, arg2, 0, arg5), arg3, arg4, arg5)
        };
        let v2 = v1;
        let v3 = 0x2::coin::value<0x2::sui::SUI>(&v2);
        assert!(v3 >= arg4, 4);
        let v4 = if (v3 > v0) {
            v3 - v0
        } else {
            0
        };
        assert!(v4 > 0, 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v2, 0x2::tx_context::sender(arg5));
    }

    public entry fun batch_optimized_arbitrage<T0>(arg0: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg1: vector<u8>, arg2: vector<vector<u8>>, arg3: vector<u64>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<0x2::coin::Coin<0x2::sui::SUI>>(&arg0);
        assert!(v0 > 0, 1);
        assert!(v0 <= 10, 5);
        let v1 = 0;
        let v2 = 0;
        while (v2 < v0) {
            let v3 = *0x1::vector::borrow<u8>(&arg1, v2 * 2);
            let v4 = *0x1::vector::borrow<vector<u8>>(&arg2, v2);
            let v5 = 0x2::coin::into_balance<0x2::sui::SUI>(0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0));
            let v6 = 0x2::balance::value<0x2::sui::SUI>(&v5);
            let v7 = execute_optimized_swap_step1<T0>(v5, v3 / 10, v4, arg4);
            let v8 = execute_optimized_swap_step2<T0>(v7, v3 % 10, v4, arg4);
            let v9 = 0x2::balance::value<0x2::sui::SUI>(&v8);
            let v10 = if (v9 > v6) {
                v9 - v6
            } else {
                0
            };
            assert!(v10 >= *0x1::vector::borrow<u64>(&arg3, v2), 3);
            v1 = v1 + v10;
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v8, arg4), 0x2::tx_context::sender(arg4));
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<0x2::coin::Coin<0x2::sui::SUI>>(arg0);
        OptimizedArbitrageResult{profit: v1, gas_used: 0, success: true};
    }

    public fun calculate_min_output(arg0: u64, arg1: u64) : u64 {
        arg0 * (10000 - arg1) / 10000
    }

    fun execute_optimized_swap_step1<T0>(arg0: 0x2::balance::Balance<0x2::sui::SUI>, arg1: u8, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let v0 = if (arg1 == 0) {
            0xa260797fe88fbf93b1020c6688e9c40d5d95c374892faea632f0b2b04c3f602a::dex_cetus::swap_exact_sui_for_token<T0>(0x2::coin::from_balance<0x2::sui::SUI>(arg0, arg3), arg2, 0, arg3)
        } else if (arg1 == 1) {
            0xa260797fe88fbf93b1020c6688e9c40d5d95c374892faea632f0b2b04c3f602a::dex_aftermath::swap_exact_sui_for_token<T0>(0x2::coin::from_balance<0x2::sui::SUI>(arg0, arg3), arg2, 0, arg3)
        } else if (arg1 == 2) {
            0xa260797fe88fbf93b1020c6688e9c40d5d95c374892faea632f0b2b04c3f602a::dex_bluefin::swap_exact_sui_for_token<T0>(0x2::coin::from_balance<0x2::sui::SUI>(arg0, arg3), arg2, 0, arg3)
        } else if (arg1 == 3) {
            0xa260797fe88fbf93b1020c6688e9c40d5d95c374892faea632f0b2b04c3f602a::dex_turbos::swap_exact_sui_for_token<T0>(0x2::coin::from_balance<0x2::sui::SUI>(arg0, arg3), arg2, 0, arg3)
        } else if (arg1 == 4) {
            0xa260797fe88fbf93b1020c6688e9c40d5d95c374892faea632f0b2b04c3f602a::dex_kriya::swap_exact_sui_for_token<T0>(0x2::coin::from_balance<0x2::sui::SUI>(arg0, arg3), arg2, 0, arg3)
        } else {
            0xa260797fe88fbf93b1020c6688e9c40d5d95c374892faea632f0b2b04c3f602a::dex_deepbook::swap_exact_sui_for_token<T0>(0x2::coin::from_balance<0x2::sui::SUI>(arg0, arg3), arg2, 0, arg3)
        };
        0x2::coin::into_balance<T0>(v0)
    }

    fun execute_optimized_swap_step2<T0>(arg0: 0x2::balance::Balance<T0>, arg1: u8, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        let v0 = if (arg1 == 0) {
            0xa260797fe88fbf93b1020c6688e9c40d5d95c374892faea632f0b2b04c3f602a::dex_cetus::swap_exact_token_for_sui<T0>(0x2::coin::from_balance<T0>(arg0, arg3), arg2, 0, arg3)
        } else if (arg1 == 1) {
            0xa260797fe88fbf93b1020c6688e9c40d5d95c374892faea632f0b2b04c3f602a::dex_aftermath::swap_exact_token_for_sui<T0>(0x2::coin::from_balance<T0>(arg0, arg3), arg2, 0, arg3)
        } else if (arg1 == 2) {
            0xa260797fe88fbf93b1020c6688e9c40d5d95c374892faea632f0b2b04c3f602a::dex_bluefin::swap_exact_token_for_sui<T0>(0x2::coin::from_balance<T0>(arg0, arg3), arg2, 0, arg3)
        } else if (arg1 == 3) {
            0xa260797fe88fbf93b1020c6688e9c40d5d95c374892faea632f0b2b04c3f602a::dex_turbos::swap_exact_token_for_sui<T0>(0x2::coin::from_balance<T0>(arg0, arg3), arg2, 0, arg3)
        } else if (arg1 == 4) {
            0xa260797fe88fbf93b1020c6688e9c40d5d95c374892faea632f0b2b04c3f602a::dex_kriya::swap_exact_token_for_sui<T0>(0x2::coin::from_balance<T0>(arg0, arg3), arg2, 0, arg3)
        } else {
            0xa260797fe88fbf93b1020c6688e9c40d5d95c374892faea632f0b2b04c3f602a::dex_deepbook::swap_exact_token_for_sui<T0>(0x2::coin::from_balance<T0>(arg0, arg3), arg2, 0, arg3)
        };
        0x2::coin::into_balance<0x2::sui::SUI>(v0)
    }

    public entry fun micro_arbitrage<T0>(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u8, arg2: u8, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 >= 500000, 1);
        assert!(v0 <= 2000000, 1);
        let v1 = 0x2::coin::into_balance<0x2::sui::SUI>(arg0);
        let v2 = execute_optimized_swap_step1<T0>(v1, arg1, arg3, arg4);
        let v3 = execute_optimized_swap_step2<T0>(v2, arg2, arg3, arg4);
        assert!(0x2::balance::value<0x2::sui::SUI>(&v3) > 0x2::balance::value<0x2::sui::SUI>(&v1), 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v3, arg4), 0x2::tx_context::sender(arg4));
    }

    public entry fun ultra_optimized_arbitrage<T0>(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u8, arg2: u8, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 >= 1000000, 1);
        assert!(v0 <= 10000000, 1);
        let v1 = 0x2::coin::into_balance<0x2::sui::SUI>(arg0);
        let v2 = 0x2::balance::value<0x2::sui::SUI>(&v1);
        let v3 = execute_optimized_swap_step1<T0>(v1, arg1, arg3, arg6);
        let v4 = execute_optimized_swap_step2<T0>(v3, arg2, arg4, arg6);
        let v5 = 0x2::balance::value<0x2::sui::SUI>(&v4);
        let v6 = if (v5 > v2) {
            v5 - v2
        } else {
            0
        };
        assert!(v6 >= arg5, 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v4, arg6), 0x2::tx_context::sender(arg6));
        OptimizedArbitrageResult{profit: v6, gas_used: 0, success: true};
    }

    // decompiled from Move bytecode v6
}

