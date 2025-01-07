module 0x657ff24534bbb1ca32d1af20fca59c6e93bc063888da98d553396b5522d2c7ba::amm_router {
    public fun add_liquidity<T0, T1>(arg0: &mut 0x657ff24534bbb1ca32d1af20fca59c6e93bc063888da98d553396b5522d2c7ba::amm_swap::Pool, arg1: &0x657ff24534bbb1ca32d1af20fca59c6e93bc063888da98d553396b5522d2c7ba::amm_config::GlobalPauseStatus, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg2) >= arg4, 1);
        assert!(0x2::coin::value<T1>(&arg3) >= arg5, 1);
        0x657ff24534bbb1ca32d1af20fca59c6e93bc063888da98d553396b5522d2c7ba::amm_config::assert_pause(arg1);
        add_liquidity_internal<T0, T1>(arg0, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    fun add_liquidity_internal<T0, T1>(arg0: &mut 0x657ff24534bbb1ca32d1af20fca59c6e93bc063888da98d553396b5522d2c7ba::amm_swap::Pool, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = calculate_amount_for_liquidity_internal<T0, T1>(arg0, arg3, arg4, arg5, arg6);
        let v2 = 0x2::coin::into_balance<T0>(arg1);
        let v3 = 0x2::coin::into_balance<T1>(arg2);
        let v4 = 0x657ff24534bbb1ca32d1af20fca59c6e93bc063888da98d553396b5522d2c7ba::amm_swap::mint_and_emit_event<T0, T1>(arg0, 0x2::balance::split<T0>(&mut v2, v0), 0x2::balance::split<T1>(&mut v3, v1), v0, v1, arg7, arg8);
        assert!(v4 > 0, 8);
        0x657ff24534bbb1ca32d1af20fca59c6e93bc063888da98d553396b5522d2c7ba::amm_swap::increase_lp_balance<T0, T1>(arg0, 0x2::tx_context::sender(arg8), v4);
        reture_back_or_delete<T0>(v2, arg8);
        reture_back_or_delete<T1>(v3, arg8);
    }

    fun alloc_fees_a_buy<T0, T1>(arg0: &mut 0x657ff24534bbb1ca32d1af20fca59c6e93bc063888da98d553396b5522d2c7ba::amm_swap::Pool, arg1: u64, arg2: &mut 0x2::balance::Balance<T0>, arg3: &mut 0x2::tx_context::TxContext) : u64 {
        let (v0, v1, v2, v3) = 0x657ff24534bbb1ca32d1af20fca59c6e93bc063888da98d553396b5522d2c7ba::amm_swap::get_buy_fees_in<T0, T1>(arg0, arg1);
        let (v4, v5, v6) = spit_balances_fee<T0>(arg2, v0, v1, v2);
        0x657ff24534bbb1ca32d1af20fca59c6e93bc063888da98d553396b5522d2c7ba::amm_swap::transfer_fees_balance<T0>(v4, v5, 0x657ff24534bbb1ca32d1af20fca59c6e93bc063888da98d553396b5522d2c7ba::amm_swap::fetch_add_fee_trade<T0, T1>(arg0, v6, 0x2::balance::zero<T1>(), true), arg3);
        v3
    }

    fun alloc_fees_a_sell<T0, T1>(arg0: &mut 0x657ff24534bbb1ca32d1af20fca59c6e93bc063888da98d553396b5522d2c7ba::amm_swap::Pool, arg1: u64, arg2: &mut 0x2::balance::Balance<T0>, arg3: &mut 0x2::tx_context::TxContext) : u64 {
        let (v0, v1, v2, v3) = 0x657ff24534bbb1ca32d1af20fca59c6e93bc063888da98d553396b5522d2c7ba::amm_swap::get_sell_fees_in<T0, T1>(arg0, arg1);
        let (v4, v5, v6) = spit_balances_fee<T0>(arg2, v0, v1, v2);
        0x657ff24534bbb1ca32d1af20fca59c6e93bc063888da98d553396b5522d2c7ba::amm_swap::transfer_fees_balance<T0>(v4, v5, 0x657ff24534bbb1ca32d1af20fca59c6e93bc063888da98d553396b5522d2c7ba::amm_swap::fetch_add_fee_trade<T0, T1>(arg0, v6, 0x2::balance::zero<T1>(), true), arg3);
        v3
    }

    fun alloc_fees_b_buy<T0, T1>(arg0: &mut 0x657ff24534bbb1ca32d1af20fca59c6e93bc063888da98d553396b5522d2c7ba::amm_swap::Pool, arg1: u64, arg2: &mut 0x2::balance::Balance<T1>, arg3: &mut 0x2::tx_context::TxContext) : u64 {
        let (v0, v1, v2, v3) = 0x657ff24534bbb1ca32d1af20fca59c6e93bc063888da98d553396b5522d2c7ba::amm_swap::get_buy_fees_in<T0, T1>(arg0, arg1);
        let (v4, v5, v6) = spit_balances_fee<T1>(arg2, v0, v1, v2);
        0x657ff24534bbb1ca32d1af20fca59c6e93bc063888da98d553396b5522d2c7ba::amm_swap::transfer_fees_balance<T1>(v4, v5, 0x657ff24534bbb1ca32d1af20fca59c6e93bc063888da98d553396b5522d2c7ba::amm_swap::fetch_add_fee_trade<T0, T1>(arg0, 0x2::balance::zero<T0>(), v6, false), arg3);
        v3
    }

    fun alloc_fees_b_sell<T0, T1>(arg0: &mut 0x657ff24534bbb1ca32d1af20fca59c6e93bc063888da98d553396b5522d2c7ba::amm_swap::Pool, arg1: u64, arg2: &mut 0x2::balance::Balance<T1>, arg3: &mut 0x2::tx_context::TxContext) : u64 {
        let (v0, v1, v2, v3) = 0x657ff24534bbb1ca32d1af20fca59c6e93bc063888da98d553396b5522d2c7ba::amm_swap::get_sell_fees_in<T0, T1>(arg0, arg1);
        let (v4, v5, v6) = spit_balances_fee<T1>(arg2, v0, v1, v2);
        0x657ff24534bbb1ca32d1af20fca59c6e93bc063888da98d553396b5522d2c7ba::amm_swap::transfer_fees_balance<T1>(v4, v5, 0x657ff24534bbb1ca32d1af20fca59c6e93bc063888da98d553396b5522d2c7ba::amm_swap::fetch_add_fee_trade<T0, T1>(arg0, 0x2::balance::zero<T0>(), v6, false), arg3);
        v3
    }

    fun calculate_amount_for_liquidity_internal<T0, T1>(arg0: &mut 0x657ff24534bbb1ca32d1af20fca59c6e93bc063888da98d553396b5522d2c7ba::amm_swap::Pool, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : (u64, u64) {
        let (v0, v1) = 0x657ff24534bbb1ca32d1af20fca59c6e93bc063888da98d553396b5522d2c7ba::amm_swap::get_reserves<T0, T1>(arg0);
        if (v0 == 0 && v1 == 0) {
            (arg1, arg2)
        } else {
            let v4 = 0x657ff24534bbb1ca32d1af20fca59c6e93bc063888da98d553396b5522d2c7ba::amm_utils::quote(arg1, v0, v1);
            if (v4 <= arg2) {
                assert!(v4 >= arg4, 5);
                (arg1, v4)
            } else {
                let v5 = 0x657ff24534bbb1ca32d1af20fca59c6e93bc063888da98d553396b5522d2c7ba::amm_utils::quote(arg2, v1, v0);
                assert!(v5 <= arg1, 7);
                assert!(v5 >= arg3, 6);
                (v5, arg2)
            }
        }
    }

    fun compute_in<T0, T1>(arg0: &0x657ff24534bbb1ca32d1af20fca59c6e93bc063888da98d553396b5522d2c7ba::amm_swap::Pool, arg1: u64, arg2: bool) : u64 {
        let (v0, v1) = 0x657ff24534bbb1ca32d1af20fca59c6e93bc063888da98d553396b5522d2c7ba::amm_swap::get_reserves<T0, T1>(arg0);
        if (arg2) {
            0x657ff24534bbb1ca32d1af20fca59c6e93bc063888da98d553396b5522d2c7ba::amm_utils::get_amount_in(arg1, v0, v1)
        } else {
            0x657ff24534bbb1ca32d1af20fca59c6e93bc063888da98d553396b5522d2c7ba::amm_utils::get_amount_in(arg1, v1, v0)
        }
    }

    fun compute_out<T0, T1>(arg0: &0x657ff24534bbb1ca32d1af20fca59c6e93bc063888da98d553396b5522d2c7ba::amm_swap::Pool, arg1: u64, arg2: bool) : u64 {
        let (v0, v1) = 0x657ff24534bbb1ca32d1af20fca59c6e93bc063888da98d553396b5522d2c7ba::amm_swap::get_reserves<T0, T1>(arg0);
        if (arg2) {
            0x657ff24534bbb1ca32d1af20fca59c6e93bc063888da98d553396b5522d2c7ba::amm_utils::get_amount_out(arg1, v0, v1)
        } else {
            0x657ff24534bbb1ca32d1af20fca59c6e93bc063888da98d553396b5522d2c7ba::amm_utils::get_amount_out(arg1, v1, v0)
        }
    }

    public fun estimate_a2b_in<T0, T1>(arg0: &0x657ff24534bbb1ca32d1af20fca59c6e93bc063888da98d553396b5522d2c7ba::amm_swap::Pool, arg1: u64) : u64 {
        estimate_in<T0, T1>(arg0, arg1, true)
    }

    public fun estimate_a2b_out<T0, T1>(arg0: &0x657ff24534bbb1ca32d1af20fca59c6e93bc063888da98d553396b5522d2c7ba::amm_swap::Pool, arg1: u64) : u64 {
        estimate_out<T0, T1>(arg0, arg1, true)
    }

    public fun estimate_b2a_in<T0, T1>(arg0: &0x657ff24534bbb1ca32d1af20fca59c6e93bc063888da98d553396b5522d2c7ba::amm_swap::Pool, arg1: u64) : u64 {
        estimate_in<T0, T1>(arg0, arg1, false)
    }

    public fun estimate_b2a_out<T0, T1>(arg0: &0x657ff24534bbb1ca32d1af20fca59c6e93bc063888da98d553396b5522d2c7ba::amm_swap::Pool, arg1: u64) : u64 {
        estimate_out<T0, T1>(arg0, arg1, false)
    }

    fun estimate_in<T0, T1>(arg0: &0x657ff24534bbb1ca32d1af20fca59c6e93bc063888da98d553396b5522d2c7ba::amm_swap::Pool, arg1: u64, arg2: bool) : u64 {
        let v0 = arg2 && 0x657ff24534bbb1ca32d1af20fca59c6e93bc063888da98d553396b5522d2c7ba::amm_swap::is_sui_coin<T0>() || 0x657ff24534bbb1ca32d1af20fca59c6e93bc063888da98d553396b5522d2c7ba::amm_swap::is_sui_coin<T1>() && !arg2;
        if (!v0) {
            let (_, _, _, v4) = 0x657ff24534bbb1ca32d1af20fca59c6e93bc063888da98d553396b5522d2c7ba::amm_swap::get_sell_fees_out<T0, T1>(arg0, arg1);
            arg1 = v4;
        };
        let v5 = compute_in<T0, T1>(arg0, arg1, arg2);
        let v6 = v5;
        if (v0) {
            let (_, _, _, v10) = 0x657ff24534bbb1ca32d1af20fca59c6e93bc063888da98d553396b5522d2c7ba::amm_swap::get_buy_fees_out<T0, T1>(arg0, v5);
            v6 = v10;
        };
        v6
    }

    fun estimate_out<T0, T1>(arg0: &0x657ff24534bbb1ca32d1af20fca59c6e93bc063888da98d553396b5522d2c7ba::amm_swap::Pool, arg1: u64, arg2: bool) : u64 {
        let v0 = arg2 && 0x657ff24534bbb1ca32d1af20fca59c6e93bc063888da98d553396b5522d2c7ba::amm_swap::is_sui_coin<T0>() || 0x657ff24534bbb1ca32d1af20fca59c6e93bc063888da98d553396b5522d2c7ba::amm_swap::is_sui_coin<T1>() && !arg2;
        if (v0) {
            let (_, _, _, v4) = 0x657ff24534bbb1ca32d1af20fca59c6e93bc063888da98d553396b5522d2c7ba::amm_swap::get_buy_fees_in<T0, T1>(arg0, arg1);
            arg1 = v4;
        };
        let v5 = compute_out<T0, T1>(arg0, arg1, arg2);
        let v6 = v5;
        if (!v0) {
            let (_, _, _, v10) = 0x657ff24534bbb1ca32d1af20fca59c6e93bc063888da98d553396b5522d2c7ba::amm_swap::get_sell_fees_in<T0, T1>(arg0, v5);
            v6 = v10;
        };
        v6
    }

    public fun init_pool<T0, T1>(arg0: &mut 0x657ff24534bbb1ca32d1af20fca59c6e93bc063888da98d553396b5522d2c7ba::amm_swap::Registry, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: address, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0 && arg1 < 10000, 4001);
        assert!(arg2 > 0 && arg2 < 10000, 4000);
        assert!(arg3 > 0 && arg3 < 10000, 4003);
        assert!(arg4 > 0 && arg4 < 10000, 4003);
        assert!(arg1 + arg3 < 10000, 4100);
        assert!(arg2 + arg4 < 10000, 4100);
        0x657ff24534bbb1ca32d1af20fca59c6e93bc063888da98d553396b5522d2c7ba::amm_swap::init_pool<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public fun remove_liquidity<T0, T1>(arg0: &mut 0x657ff24534bbb1ca32d1af20fca59c6e93bc063888da98d553396b5522d2c7ba::amm_swap::Pool, arg1: &0x657ff24534bbb1ca32d1af20fca59c6e93bc063888da98d553396b5522d2c7ba::amm_config::GlobalPauseStatus, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x657ff24534bbb1ca32d1af20fca59c6e93bc063888da98d553396b5522d2c7ba::amm_config::assert_pause(arg1);
        remove_liquidity_internal<T0, T1>(arg0, arg2, arg3, arg4, arg5, arg6);
    }

    fun remove_liquidity_internal<T0, T1>(arg0: &mut 0x657ff24534bbb1ca32d1af20fca59c6e93bc063888da98d553396b5522d2c7ba::amm_swap::Pool, arg1: u64, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x657ff24534bbb1ca32d1af20fca59c6e93bc063888da98d553396b5522d2c7ba::amm_swap::burn_and_emit_event<T0, T1>(arg0, arg1, arg4, arg5);
        let v2 = v1;
        let v3 = v0;
        assert!(0x2::coin::value<T0>(&v3) >= arg2, 6);
        assert!(0x2::coin::value<T1>(&v2) >= arg3, 5);
        0x2::pay::keep<T0>(v3, arg5);
        0x2::pay::keep<T1>(v2, arg5);
    }

    fun reture_back_or_delete<T0>(arg0: 0x2::balance::Balance<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg1), 0x2::tx_context::sender(arg1));
        } else {
            0x2::balance::destroy_zero<T0>(arg0);
        };
    }

    public fun set_fee_config<T0, T1>(arg0: &0x657ff24534bbb1ca32d1af20fca59c6e93bc063888da98d553396b5522d2c7ba::amm_swap::Deployer, arg1: &mut 0x657ff24534bbb1ca32d1af20fca59c6e93bc063888da98d553396b5522d2c7ba::amm_swap::Pool, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0 && arg2 < 10000, 4001);
        assert!(arg3 > 0 && arg3 < 10000, 4000);
        assert!(arg4 > 0 && arg4 < 10000, 4003);
        assert!(arg5 > 0 && arg5 < 10000, 4003);
        0x657ff24534bbb1ca32d1af20fca59c6e93bc063888da98d553396b5522d2c7ba::amm_swap::set_fee_and_emit_event<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public fun set_global_pause_status(arg0: &0x657ff24534bbb1ca32d1af20fca59c6e93bc063888da98d553396b5522d2c7ba::amm_swap::AdminCap, arg1: &mut 0x657ff24534bbb1ca32d1af20fca59c6e93bc063888da98d553396b5522d2c7ba::amm_config::GlobalPauseStatus, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        0x657ff24534bbb1ca32d1af20fca59c6e93bc063888da98d553396b5522d2c7ba::amm_config::set_status_and_emit_event(arg1, arg2, arg3);
    }

    fun spit_balances_fee<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: u64, arg2: u64, arg3: u64) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T0>) {
        (0x2::balance::split<T0>(arg0, arg1), 0x2::balance::split<T0>(arg0, arg2), 0x2::balance::split<T0>(arg0, arg3))
    }

    public fun swap_exact_coinA_for_coinB<T0, T1>(arg0: &mut 0x657ff24534bbb1ca32d1af20fca59c6e93bc063888da98d553396b5522d2c7ba::amm_swap::Pool, arg1: &0x657ff24534bbb1ca32d1af20fca59c6e93bc063888da98d553396b5522d2c7ba::amm_config::GlobalPauseStatus, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg2) >= arg3, 1);
        0x657ff24534bbb1ca32d1af20fca59c6e93bc063888da98d553396b5522d2c7ba::amm_config::assert_pause(arg1);
        let v0 = arg3;
        let v1 = 0x657ff24534bbb1ca32d1af20fca59c6e93bc063888da98d553396b5522d2c7ba::amm_swap::is_sui_coin<T0>();
        let v2 = 0x2::coin::into_balance<T0>(arg2);
        if (v1) {
            let v3 = &mut v2;
            v0 = alloc_fees_a_buy<T0, T1>(arg0, arg3, v3, arg5);
        };
        let v4 = compute_out<T0, T1>(arg0, v0, true);
        let v5 = v4;
        assert!(v4 >= arg4, 2);
        let (v6, v7, v8) = 0x657ff24534bbb1ca32d1af20fca59c6e93bc063888da98d553396b5522d2c7ba::amm_swap::flash_swap_wave<T0, T1>(arg0, v0, v4, true);
        let v9 = v8;
        let v10 = v7;
        if (!v1) {
            let v11 = &mut v10;
            v5 = alloc_fees_b_sell<T0, T1>(arg0, v4, v11, arg5);
        };
        assert!(v5 >= arg4, 2);
        0x657ff24534bbb1ca32d1af20fca59c6e93bc063888da98d553396b5522d2c7ba::amm_swap::emit_swap_event<T0, T1>(arg0, arg3, v5, true, arg5);
        0x2::balance::destroy_zero<T0>(v6);
        0x657ff24534bbb1ca32d1af20fca59c6e93bc063888da98d553396b5522d2c7ba::amm_swap::repay_flash_swap<T0, T1>(arg0, 0x2::balance::split<T0>(&mut v2, 0x657ff24534bbb1ca32d1af20fca59c6e93bc063888da98d553396b5522d2c7ba::amm_swap::swap_pay_amount<T0, T1>(&v9)), 0x2::balance::zero<T1>(), v9);
        0x2::pay::keep<T1>(0x2::coin::from_balance<T1>(v10, arg5), arg5);
        reture_back_or_delete<T0>(v2, arg5);
    }

    public fun swap_exact_coinB_for_coinA<T0, T1>(arg0: &mut 0x657ff24534bbb1ca32d1af20fca59c6e93bc063888da98d553396b5522d2c7ba::amm_swap::Pool, arg1: &0x657ff24534bbb1ca32d1af20fca59c6e93bc063888da98d553396b5522d2c7ba::amm_config::GlobalPauseStatus, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T1>(&arg2) >= arg3, 1);
        0x657ff24534bbb1ca32d1af20fca59c6e93bc063888da98d553396b5522d2c7ba::amm_config::assert_pause(arg1);
        let v0 = arg3;
        let v1 = 0x657ff24534bbb1ca32d1af20fca59c6e93bc063888da98d553396b5522d2c7ba::amm_swap::is_sui_coin<T1>();
        let v2 = 0x2::coin::into_balance<T1>(arg2);
        if (v1) {
            let v3 = &mut v2;
            v0 = alloc_fees_b_buy<T0, T1>(arg0, arg3, v3, arg5);
        };
        let v4 = compute_out<T0, T1>(arg0, v0, false);
        let v5 = v4;
        assert!(v4 >= arg4, 2);
        let (v6, v7, v8) = 0x657ff24534bbb1ca32d1af20fca59c6e93bc063888da98d553396b5522d2c7ba::amm_swap::flash_swap_wave<T0, T1>(arg0, v0, v4, false);
        let v9 = v8;
        let v10 = v6;
        if (!v1) {
            let v11 = &mut v10;
            v5 = alloc_fees_a_sell<T0, T1>(arg0, v4, v11, arg5);
        };
        assert!(v5 >= arg4, 2);
        0x657ff24534bbb1ca32d1af20fca59c6e93bc063888da98d553396b5522d2c7ba::amm_swap::emit_swap_event<T0, T1>(arg0, arg3, v5, false, arg5);
        0x2::balance::destroy_zero<T1>(v7);
        0x657ff24534bbb1ca32d1af20fca59c6e93bc063888da98d553396b5522d2c7ba::amm_swap::repay_flash_swap<T0, T1>(arg0, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v2, 0x657ff24534bbb1ca32d1af20fca59c6e93bc063888da98d553396b5522d2c7ba::amm_swap::swap_pay_amount<T0, T1>(&v9)), v9);
        0x2::pay::keep<T0>(0x2::coin::from_balance<T0>(v10, arg5), arg5);
        reture_back_or_delete<T1>(v2, arg5);
    }

    // decompiled from Move bytecode v6
}

