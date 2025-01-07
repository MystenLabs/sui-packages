module 0x14aa37e7423e2ddc32867c58ec26aca342cad07aba21e21da9349601d8ced991::amm_router {
    public fun add_liquidity<T0, T1>(arg0: &mut 0x14aa37e7423e2ddc32867c58ec26aca342cad07aba21e21da9349601d8ced991::amm_swap::Pool<T0, T1>, arg1: &0x14aa37e7423e2ddc32867c58ec26aca342cad07aba21e21da9349601d8ced991::amm_config::GlobalPauseStatus, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg2) >= arg4, 1);
        assert!(0x2::coin::value<T1>(&arg3) >= arg5, 1);
        0x14aa37e7423e2ddc32867c58ec26aca342cad07aba21e21da9349601d8ced991::amm_config::assert_pause(arg1);
        add_liquidity_internal<T0, T1>(arg0, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    fun add_liquidity_internal<T0, T1>(arg0: &mut 0x14aa37e7423e2ddc32867c58ec26aca342cad07aba21e21da9349601d8ced991::amm_swap::Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = calculate_amount_for_liquidity_internal<T0, T1>(arg0, arg3, arg4, arg5, arg6);
        let v2 = 0x2::coin::into_balance<T0>(arg1);
        let v3 = 0x2::coin::into_balance<T1>(arg2);
        let v4 = 0x14aa37e7423e2ddc32867c58ec26aca342cad07aba21e21da9349601d8ced991::amm_swap::mint_and_emit_event<T0, T1>(arg0, 0x2::balance::split<T0>(&mut v2, v0), 0x2::balance::split<T1>(&mut v3, v1), v0, v1, arg7);
        assert!(0x2::coin::value<0x14aa37e7423e2ddc32867c58ec26aca342cad07aba21e21da9349601d8ced991::amm_swap::PoolLiquidityCoin<T0, T1>>(&v4) > 0, 8);
        0x2::pay::keep<0x14aa37e7423e2ddc32867c58ec26aca342cad07aba21e21da9349601d8ced991::amm_swap::PoolLiquidityCoin<T0, T1>>(v4, arg7);
        reture_back_or_delete<T0>(v2, arg7);
        reture_back_or_delete<T1>(v3, arg7);
    }

    fun calculate_amount_for_liquidity_internal<T0, T1>(arg0: &mut 0x14aa37e7423e2ddc32867c58ec26aca342cad07aba21e21da9349601d8ced991::amm_swap::Pool<T0, T1>, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : (u64, u64) {
        let (v0, v1) = 0x14aa37e7423e2ddc32867c58ec26aca342cad07aba21e21da9349601d8ced991::amm_swap::get_reserves<T0, T1>(arg0);
        if (v0 == 0 && v1 == 0) {
            (arg1, arg2)
        } else {
            let v4 = 0x14aa37e7423e2ddc32867c58ec26aca342cad07aba21e21da9349601d8ced991::amm_utils::quote(arg1, v0, v1);
            if (v4 <= arg2) {
                assert!(v4 >= arg4, 5);
                (arg1, v4)
            } else {
                let v5 = 0x14aa37e7423e2ddc32867c58ec26aca342cad07aba21e21da9349601d8ced991::amm_utils::quote(arg2, v1, v0);
                assert!(v5 <= arg1, 7);
                assert!(v5 >= arg3, 6);
                (v5, arg2)
            }
        }
    }

    fun check_pair_exist<T0, T1>(arg0: &mut 0x14aa37e7423e2ddc32867c58ec26aca342cad07aba21e21da9349601d8ced991::amm_config::PairStore) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v1 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        0x2::table::add<0x14aa37e7423e2ddc32867c58ec26aca342cad07aba21e21da9349601d8ced991::amm_config::Pair, bool>(0x14aa37e7423e2ddc32867c58ec26aca342cad07aba21e21da9349601d8ced991::amm_config::borrow_mut_pair(arg0), 0x14aa37e7423e2ddc32867c58ec26aca342cad07aba21e21da9349601d8ced991::amm_config::new_pair(v0, v1), true);
        0x2::table::add<0x14aa37e7423e2ddc32867c58ec26aca342cad07aba21e21da9349601d8ced991::amm_config::Pair, bool>(0x14aa37e7423e2ddc32867c58ec26aca342cad07aba21e21da9349601d8ced991::amm_config::borrow_mut_pair(arg0), 0x14aa37e7423e2ddc32867c58ec26aca342cad07aba21e21da9349601d8ced991::amm_config::new_pair(v1, v0), true);
    }

    public fun claim_fee<T0, T1>(arg0: &0x14aa37e7423e2ddc32867c58ec26aca342cad07aba21e21da9349601d8ced991::amm_swap::AdminCap, arg1: &mut 0x14aa37e7423e2ddc32867c58ec26aca342cad07aba21e21da9349601d8ced991::amm_swap::Pool<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) {
        0x14aa37e7423e2ddc32867c58ec26aca342cad07aba21e21da9349601d8ced991::amm_swap::claim_fee<T0, T1>(arg1, arg2);
    }

    fun compute_in<T0, T1>(arg0: &0x14aa37e7423e2ddc32867c58ec26aca342cad07aba21e21da9349601d8ced991::amm_swap::Pool<T0, T1>, arg1: u64, arg2: bool) : u64 {
        let (v0, v1) = 0x14aa37e7423e2ddc32867c58ec26aca342cad07aba21e21da9349601d8ced991::amm_swap::get_trade_fee<T0, T1>(arg0);
        let (v2, v3) = 0x14aa37e7423e2ddc32867c58ec26aca342cad07aba21e21da9349601d8ced991::amm_swap::get_reserves<T0, T1>(arg0);
        if (arg2) {
            0x14aa37e7423e2ddc32867c58ec26aca342cad07aba21e21da9349601d8ced991::amm_utils::get_amount_in(arg1, v2, v3, v0, v1)
        } else {
            0x14aa37e7423e2ddc32867c58ec26aca342cad07aba21e21da9349601d8ced991::amm_utils::get_amount_in(arg1, v3, v2, v0, v1)
        }
    }

    fun compute_out<T0, T1>(arg0: &0x14aa37e7423e2ddc32867c58ec26aca342cad07aba21e21da9349601d8ced991::amm_swap::Pool<T0, T1>, arg1: u64, arg2: bool) : u64 {
        let (v0, v1) = 0x14aa37e7423e2ddc32867c58ec26aca342cad07aba21e21da9349601d8ced991::amm_swap::get_trade_fee<T0, T1>(arg0);
        let (v2, v3) = 0x14aa37e7423e2ddc32867c58ec26aca342cad07aba21e21da9349601d8ced991::amm_swap::get_reserves<T0, T1>(arg0);
        if (arg2) {
            0x14aa37e7423e2ddc32867c58ec26aca342cad07aba21e21da9349601d8ced991::amm_utils::get_amount_out(arg1, v2, v3, v0, v1)
        } else {
            0x14aa37e7423e2ddc32867c58ec26aca342cad07aba21e21da9349601d8ced991::amm_utils::get_amount_out(arg1, v3, v2, v0, v1)
        }
    }

    public fun flash_swap<T0, T1>(arg0: &mut 0x14aa37e7423e2ddc32867c58ec26aca342cad07aba21e21da9349601d8ced991::amm_swap::Pool<T0, T1>, arg1: &0x14aa37e7423e2ddc32867c58ec26aca342cad07aba21e21da9349601d8ced991::amm_config::GlobalPauseStatus, arg2: bool, arg3: bool, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, 0x14aa37e7423e2ddc32867c58ec26aca342cad07aba21e21da9349601d8ced991::amm_swap::FlashSwapReceipt<T0, T1>) {
        0x14aa37e7423e2ddc32867c58ec26aca342cad07aba21e21da9349601d8ced991::amm_config::assert_pause(arg1);
        let (v0, v1) = if (arg3) {
            (arg4, compute_out<T0, T1>(arg0, arg4, arg2))
        } else {
            (compute_in<T0, T1>(arg0, arg4, arg2), arg4)
        };
        0x14aa37e7423e2ddc32867c58ec26aca342cad07aba21e21da9349601d8ced991::amm_swap::flash_swap_and_emit_event<T0, T1>(arg0, v0, v1, arg2, arg5)
    }

    public fun init_and_add_pool<T0, T1>(arg0: &mut 0x14aa37e7423e2ddc32867c58ec26aca342cad07aba21e21da9349601d8ced991::amm_config::PairStore, arg1: &0x14aa37e7423e2ddc32867c58ec26aca342cad07aba21e21da9349601d8ced991::amm_config::GlobalPauseStatus, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(arg8 > 0 && arg9 > 0, 4);
        assert!(arg10 > 0 && arg11 > 0, 4);
        check_pair_exist<T0, T1>(arg0);
        let v0 = 0x14aa37e7423e2ddc32867c58ec26aca342cad07aba21e21da9349601d8ced991::amm_swap::init_pool<T0, T1>(arg8, arg9, arg10, arg11, arg12);
        assert!(0x2::coin::value<T0>(&arg2) >= arg4, 1);
        assert!(0x2::coin::value<T1>(&arg3) >= arg5, 1);
        0x14aa37e7423e2ddc32867c58ec26aca342cad07aba21e21da9349601d8ced991::amm_config::assert_pause(arg1);
        let v1 = &mut v0;
        add_liquidity_internal<T0, T1>(v1, arg2, arg3, arg4, arg5, arg6, arg7, arg12);
        0x14aa37e7423e2ddc32867c58ec26aca342cad07aba21e21da9349601d8ced991::amm_swap::share_pool_object<T0, T1>(v0);
    }

    public fun init_pool<T0, T1>(arg0: &mut 0x14aa37e7423e2ddc32867c58ec26aca342cad07aba21e21da9349601d8ced991::amm_config::PairStore, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0 && arg2 > 0, 4);
        assert!(arg3 > 0 && arg4 > 0, 4);
        check_pair_exist<T0, T1>(arg0);
        0x14aa37e7423e2ddc32867c58ec26aca342cad07aba21e21da9349601d8ced991::amm_swap::share_pool_object<T0, T1>(0x14aa37e7423e2ddc32867c58ec26aca342cad07aba21e21da9349601d8ced991::amm_swap::init_pool<T0, T1>(arg1, arg2, arg3, arg4, arg5));
    }

    public fun remove_liquidity<T0, T1>(arg0: &mut 0x14aa37e7423e2ddc32867c58ec26aca342cad07aba21e21da9349601d8ced991::amm_swap::Pool<T0, T1>, arg1: &0x14aa37e7423e2ddc32867c58ec26aca342cad07aba21e21da9349601d8ced991::amm_config::GlobalPauseStatus, arg2: 0x2::coin::Coin<0x14aa37e7423e2ddc32867c58ec26aca342cad07aba21e21da9349601d8ced991::amm_swap::PoolLiquidityCoin<T0, T1>>, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x14aa37e7423e2ddc32867c58ec26aca342cad07aba21e21da9349601d8ced991::amm_swap::PoolLiquidityCoin<T0, T1>>(&arg2) >= arg3, 1);
        0x14aa37e7423e2ddc32867c58ec26aca342cad07aba21e21da9349601d8ced991::amm_config::assert_pause(arg1);
        remove_liquidity_internal<T0, T1>(arg0, arg2, arg3, arg4, arg5, arg6);
    }

    fun remove_liquidity_internal<T0, T1>(arg0: &mut 0x14aa37e7423e2ddc32867c58ec26aca342cad07aba21e21da9349601d8ced991::amm_swap::Pool<T0, T1>, arg1: 0x2::coin::Coin<0x14aa37e7423e2ddc32867c58ec26aca342cad07aba21e21da9349601d8ced991::amm_swap::PoolLiquidityCoin<T0, T1>>, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<0x14aa37e7423e2ddc32867c58ec26aca342cad07aba21e21da9349601d8ced991::amm_swap::PoolLiquidityCoin<T0, T1>>(arg1);
        let (v1, v2) = 0x14aa37e7423e2ddc32867c58ec26aca342cad07aba21e21da9349601d8ced991::amm_swap::burn_and_emit_event<T0, T1>(arg0, 0x2::balance::split<0x14aa37e7423e2ddc32867c58ec26aca342cad07aba21e21da9349601d8ced991::amm_swap::PoolLiquidityCoin<T0, T1>>(&mut v0, arg2), arg5);
        let v3 = v2;
        let v4 = v1;
        assert!(0x2::coin::value<T0>(&v4) >= arg3, 6);
        assert!(0x2::coin::value<T1>(&v3) >= arg4, 5);
        0x2::pay::keep<T0>(v4, arg5);
        0x2::pay::keep<T1>(v3, arg5);
        reture_back_or_delete<0x14aa37e7423e2ddc32867c58ec26aca342cad07aba21e21da9349601d8ced991::amm_swap::PoolLiquidityCoin<T0, T1>>(v0, arg5);
    }

    public fun repay_flash_swap<T0, T1>(arg0: &mut 0x14aa37e7423e2ddc32867c58ec26aca342cad07aba21e21da9349601d8ced991::amm_swap::Pool<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: 0x2::balance::Balance<T1>, arg3: 0x14aa37e7423e2ddc32867c58ec26aca342cad07aba21e21da9349601d8ced991::amm_swap::FlashSwapReceipt<T0, T1>) {
        0x14aa37e7423e2ddc32867c58ec26aca342cad07aba21e21da9349601d8ced991::amm_swap::repay_flash_swap<T0, T1>(arg0, arg1, arg2, arg3);
    }

    fun reture_back_or_delete<T0>(arg0: 0x2::balance::Balance<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg1), 0x2::tx_context::sender(arg1));
        } else {
            0x2::balance::destroy_zero<T0>(arg0);
        };
    }

    public fun set_fee_config<T0, T1>(arg0: &0x14aa37e7423e2ddc32867c58ec26aca342cad07aba21e21da9349601d8ced991::amm_swap::AdminCap, arg1: &mut 0x14aa37e7423e2ddc32867c58ec26aca342cad07aba21e21da9349601d8ced991::amm_swap::Pool<T0, T1>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0 && arg3 > 0, 4);
        assert!(arg4 > 0 && arg5 > 0, 4);
        0x14aa37e7423e2ddc32867c58ec26aca342cad07aba21e21da9349601d8ced991::amm_swap::set_fee_and_emit_event<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public fun set_global_pause_status(arg0: &0x14aa37e7423e2ddc32867c58ec26aca342cad07aba21e21da9349601d8ced991::amm_swap::AdminCap, arg1: &mut 0x14aa37e7423e2ddc32867c58ec26aca342cad07aba21e21da9349601d8ced991::amm_config::GlobalPauseStatus, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        0x14aa37e7423e2ddc32867c58ec26aca342cad07aba21e21da9349601d8ced991::amm_config::set_status_and_emit_event(arg1, arg2, arg3);
    }

    public fun swap_coinA_for_exact_coinB<T0, T1>(arg0: &mut 0x14aa37e7423e2ddc32867c58ec26aca342cad07aba21e21da9349601d8ced991::amm_swap::Pool<T0, T1>, arg1: &0x14aa37e7423e2ddc32867c58ec26aca342cad07aba21e21da9349601d8ced991::amm_config::GlobalPauseStatus, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg2) >= arg3, 1);
        0x14aa37e7423e2ddc32867c58ec26aca342cad07aba21e21da9349601d8ced991::amm_config::assert_pause(arg1);
        let v0 = compute_in<T0, T1>(arg0, arg4, true);
        assert!(v0 <= arg3, 3);
        let (v1, v2, v3) = 0x14aa37e7423e2ddc32867c58ec26aca342cad07aba21e21da9349601d8ced991::amm_swap::flash_swap_and_emit_event<T0, T1>(arg0, v0, arg4, true, arg5);
        let v4 = v3;
        0x2::balance::destroy_zero<T0>(v1);
        let v5 = 0x2::coin::into_balance<T0>(arg2);
        0x14aa37e7423e2ddc32867c58ec26aca342cad07aba21e21da9349601d8ced991::amm_swap::repay_flash_swap<T0, T1>(arg0, 0x2::balance::split<T0>(&mut v5, 0x14aa37e7423e2ddc32867c58ec26aca342cad07aba21e21da9349601d8ced991::amm_swap::swap_pay_amount<T0, T1>(&v4)), 0x2::balance::zero<T1>(), v4);
        0x2::pay::keep<T1>(0x2::coin::from_balance<T1>(v2, arg5), arg5);
        reture_back_or_delete<T0>(v5, arg5);
    }

    public fun swap_coinB_for_exact_coinA<T0, T1>(arg0: &mut 0x14aa37e7423e2ddc32867c58ec26aca342cad07aba21e21da9349601d8ced991::amm_swap::Pool<T0, T1>, arg1: &0x14aa37e7423e2ddc32867c58ec26aca342cad07aba21e21da9349601d8ced991::amm_config::GlobalPauseStatus, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T1>(&arg2) >= arg3, 1);
        0x14aa37e7423e2ddc32867c58ec26aca342cad07aba21e21da9349601d8ced991::amm_config::assert_pause(arg1);
        let v0 = compute_in<T0, T1>(arg0, arg4, false);
        assert!(v0 <= arg3, 3);
        let (v1, v2, v3) = 0x14aa37e7423e2ddc32867c58ec26aca342cad07aba21e21da9349601d8ced991::amm_swap::flash_swap_and_emit_event<T0, T1>(arg0, v0, arg4, false, arg5);
        let v4 = v3;
        0x2::balance::destroy_zero<T1>(v2);
        let v5 = 0x2::coin::into_balance<T1>(arg2);
        0x14aa37e7423e2ddc32867c58ec26aca342cad07aba21e21da9349601d8ced991::amm_swap::repay_flash_swap<T0, T1>(arg0, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v5, 0x14aa37e7423e2ddc32867c58ec26aca342cad07aba21e21da9349601d8ced991::amm_swap::swap_pay_amount<T0, T1>(&v4)), v4);
        0x2::pay::keep<T0>(0x2::coin::from_balance<T0>(v1, arg5), arg5);
        reture_back_or_delete<T1>(v5, arg5);
    }

    public fun swap_exact_coinA_for_coinB<T0, T1>(arg0: &mut 0x14aa37e7423e2ddc32867c58ec26aca342cad07aba21e21da9349601d8ced991::amm_swap::Pool<T0, T1>, arg1: &0x14aa37e7423e2ddc32867c58ec26aca342cad07aba21e21da9349601d8ced991::amm_config::GlobalPauseStatus, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg2) >= arg3, 1);
        0x14aa37e7423e2ddc32867c58ec26aca342cad07aba21e21da9349601d8ced991::amm_config::assert_pause(arg1);
        let v0 = compute_out<T0, T1>(arg0, arg3, true);
        assert!(v0 >= arg4, 2);
        let (v1, v2, v3) = 0x14aa37e7423e2ddc32867c58ec26aca342cad07aba21e21da9349601d8ced991::amm_swap::flash_swap_and_emit_event<T0, T1>(arg0, arg3, v0, true, arg5);
        let v4 = v3;
        0x2::balance::destroy_zero<T0>(v1);
        let v5 = 0x2::coin::into_balance<T0>(arg2);
        0x14aa37e7423e2ddc32867c58ec26aca342cad07aba21e21da9349601d8ced991::amm_swap::repay_flash_swap<T0, T1>(arg0, 0x2::balance::split<T0>(&mut v5, 0x14aa37e7423e2ddc32867c58ec26aca342cad07aba21e21da9349601d8ced991::amm_swap::swap_pay_amount<T0, T1>(&v4)), 0x2::balance::zero<T1>(), v4);
        0x2::pay::keep<T1>(0x2::coin::from_balance<T1>(v2, arg5), arg5);
        reture_back_or_delete<T0>(v5, arg5);
    }

    public fun swap_exact_coinB_for_coinA<T0, T1>(arg0: &mut 0x14aa37e7423e2ddc32867c58ec26aca342cad07aba21e21da9349601d8ced991::amm_swap::Pool<T0, T1>, arg1: &0x14aa37e7423e2ddc32867c58ec26aca342cad07aba21e21da9349601d8ced991::amm_config::GlobalPauseStatus, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T1>(&arg2) >= arg3, 1);
        0x14aa37e7423e2ddc32867c58ec26aca342cad07aba21e21da9349601d8ced991::amm_config::assert_pause(arg1);
        let v0 = compute_out<T0, T1>(arg0, arg3, false);
        assert!(v0 >= arg4, 2);
        let (v1, v2, v3) = 0x14aa37e7423e2ddc32867c58ec26aca342cad07aba21e21da9349601d8ced991::amm_swap::flash_swap_and_emit_event<T0, T1>(arg0, arg3, v0, false, arg5);
        let v4 = v3;
        0x2::balance::destroy_zero<T1>(v2);
        let v5 = 0x2::coin::into_balance<T1>(arg2);
        0x14aa37e7423e2ddc32867c58ec26aca342cad07aba21e21da9349601d8ced991::amm_swap::repay_flash_swap<T0, T1>(arg0, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v5, 0x14aa37e7423e2ddc32867c58ec26aca342cad07aba21e21da9349601d8ced991::amm_swap::swap_pay_amount<T0, T1>(&v4)), v4);
        0x2::pay::keep<T0>(0x2::coin::from_balance<T0>(v1, arg5), arg5);
        reture_back_or_delete<T1>(v5, arg5);
    }

    // decompiled from Move bytecode v6
}

