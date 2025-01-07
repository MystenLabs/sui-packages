module 0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::router {
    public fun get_fees_config<T0, T1, T2>(arg0: &0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::liquidity_pool::LiquidityPool<T0, T1, T2>) : (u64, u64) {
        0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::curves::assert_valid_curve<T2>();
        0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::liquidity_pool::get_fees_config<T0, T1, T2>(arg0)
    }

    public fun add_liquidity<T0, T1, T2>(arg0: &mut 0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::liquidity_pool::GlobalStorage, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x2::coin::Coin<0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::liquidity_pool::LPToken<T0, T1, T2>>) {
        let v0 = 0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::liquidity_pool::borrow_pool<T0, T1, T2>(arg0);
        let v1 = 0x2::coin::value<T0>(&arg1);
        let v2 = 0x2::coin::value<T1>(&arg3);
        assert!(v1 >= arg2, 10002);
        assert!(v2 >= arg4, 10003);
        let (v3, v4) = calc_optimal_coin_values<T0, T1, T2>(v0, v1, arg2, v2, arg4);
        let v5 = 0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::liquidity_pool::mint<T0, T1, T2>(arg0, 0x2::coin::split<T0>(&mut arg1, v3, arg6), 0x2::coin::split<T1>(&mut arg3, v4, arg6), arg6);
        assert!(0x2::coin::value<0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::liquidity_pool::LPToken<T0, T1, T2>>(&v5) >= arg5, 10017);
        (arg1, arg3, v5)
    }

    public fun calc_optimal_coin_values<T0, T1, T2>(arg0: &0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::liquidity_pool::LiquidityPool<T0, T1, T2>, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : (u64, u64) {
        0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::curves::assert_valid_curve<T2>();
        assert!(arg1 >= arg2, 10002);
        assert!(arg3 >= arg4, 10003);
        let (v0, v1, _) = 0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::liquidity_pool::get_amounts<T0, T1, T2>(arg0);
        if (v0 == 0 && v1 == 0) {
            return (arg1, arg3)
        };
        let v3 = convert_with_current_price(arg1, v0, v1);
        if (v3 <= arg3) {
            assert!(v3 >= arg4, 10003);
            return (arg1, v3)
        };
        let v4 = convert_with_current_price(arg3, v1, v0);
        assert!(v4 <= arg1, 10006);
        assert!(v4 >= arg2, 10002);
        (v4, arg3)
    }

    public fun convert_with_current_price(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg0 > 0, 10004);
        assert!(arg1 > 0 && arg2 > 0, 10005);
        0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::math::mul_div(arg0, arg2, arg1)
    }

    public fun get_amount_out<T0, T1, T2>(arg0: &0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::liquidity_pool::LiquidityPool<T0, T1, T2>, arg1: u64, arg2: bool) : u64 {
        0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::curves::assert_valid_curve<T2>();
        let (v0, v1, _) = 0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::liquidity_pool::get_amounts<T0, T1, T2>(arg0);
        assert!(v0 > 0 && v1 > 0, 10005);
        let (v3, v4) = 0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::liquidity_pool::get_scales<T0, T1, T2>(arg0);
        if (arg2) {
            return get_coin_out_with_fees<T0, T1, T2>(arg0, arg1, v1, v0, v4, v3)
        };
        get_coin_out_with_fees<T0, T1, T2>(arg0, arg1, v0, v1, v3, v4)
    }

    fun get_coin_out_with_fees<T0, T1, T2>(arg0: &0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::liquidity_pool::LiquidityPool<T0, T1, T2>, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : u64 {
        0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::curves::assert_valid_curve<T2>();
        let (v0, v1) = get_fees_config<T0, T1, T2>(arg0);
        if (0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::curves::is_stable<T2>()) {
            let v2 = 0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::math::mul_to_u128(arg1, v1 - v0);
            let v3 = if (v2 % (v1 as u128) != 0) {
                v2 / (v1 as u128) + 1
            } else {
                v2 / (v1 as u128)
            };
            return (0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::stable_curve::coin_out((v3 as u128), arg4, arg5, (arg2 as u128), (arg3 as u128)) as u64)
        };
        assert!(0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::curves::is_uncorrelated<T2>(), 10008);
        let v4 = 0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::math::mul_to_u128(arg1, v1 - v0);
        0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::math::mul_div_u128(v4, (arg3 as u128), 0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::math::mul_to_u128(arg2, v1) + v4)
    }

    public fun register_pool<T0, T1, T2>(arg0: &mut 0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::liquidity_pool::GlobalStorage, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::type_name::get<T0>() != 0x1::type_name::get<T1>(), 10016);
        0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::liquidity_pool::register<T0, T1, T2>(arg0, arg1);
    }

    public fun register_pool_and_add_liquidity<T0, T1, T2>(arg0: &mut 0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::liquidity_pool::GlobalStorage, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x2::coin::Coin<0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::liquidity_pool::LPToken<T0, T1, T2>>) {
        register_pool<T0, T1, T2>(arg0, arg6);
        add_liquidity<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
    }

    public fun remove_liquidity<T0, T1, T2>(arg0: &mut 0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::liquidity_pool::GlobalStorage, arg1: 0x2::coin::Coin<0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::liquidity_pool::LPToken<T0, T1, T2>>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::curves::assert_valid_curve<T2>();
        assert!(0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::helper::is_sorted<T0, T1>(), 10001);
        let (v0, v1) = 0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::liquidity_pool::burn<T0, T1, T2>(arg0, arg1, arg4);
        let v2 = v1;
        let v3 = v0;
        assert!(0x2::coin::value<T0>(&v3) >= arg2, 10007);
        assert!(0x2::coin::value<T1>(&v2) >= arg3, 10007);
        (v3, v2)
    }

    public fun swap_coin_x_for_coin_y_unchecked<T0, T1, T2>(arg0: &mut 0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::liquidity_pool::GlobalStorage, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::curves::assert_valid_curve<T2>();
        let (v0, v1) = 0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::liquidity_pool::swap<T0, T1, T2>(arg0, arg1, 0, 0x2::coin::zero<T1>(arg3), arg2, arg3);
        0x2::coin::destroy_zero<T0>(v0);
        v1
    }

    public fun swap_coin_y_for_coin_x_unchecked<T0, T1, T2>(arg0: &mut 0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::liquidity_pool::GlobalStorage, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::curves::assert_valid_curve<T2>();
        let (v0, v1) = 0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::liquidity_pool::swap<T0, T1, T2>(arg0, 0x2::coin::zero<T0>(arg3), arg2, arg1, 0, arg3);
        0x2::coin::destroy_zero<T1>(v1);
        v0
    }

    public fun swap_exact_coin_x_for_coin_y<T0, T1, T2>(arg0: &mut 0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::liquidity_pool::GlobalStorage, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::curves::assert_valid_curve<T2>();
        let v0 = get_amount_out<T0, T1, T2>(0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::liquidity_pool::borrow_pool<T0, T1, T2>(arg0), 0x2::coin::value<T0>(&arg1), false);
        assert!(v0 >= arg2, 10007);
        swap_coin_x_for_coin_y_unchecked<T0, T1, T2>(arg0, arg1, v0, arg3)
    }

    public fun swap_exact_coin_y_for_coin_x<T0, T1, T2>(arg0: &mut 0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::liquidity_pool::GlobalStorage, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::curves::assert_valid_curve<T2>();
        let v0 = get_amount_out<T0, T1, T2>(0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::liquidity_pool::borrow_pool<T0, T1, T2>(arg0), 0x2::coin::value<T1>(&arg1), true);
        assert!(v0 >= arg2, 10007);
        swap_coin_y_for_coin_x_unchecked<T0, T1, T2>(arg0, arg1, v0, arg3)
    }

    public fun zap_cal_swap_in_amount<T0, T1, T2>(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        assert!(arg3 > 0, 10018);
        let v0 = (arg0 as u256) * (arg3 as u256);
        let v1 = (arg3 as u256) - (arg2 as u256);
        assert!(v1 > 0, 10018);
        let v2 = (arg3 as u256) + v1;
        (((0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::math::sqrt_u256(v0 * ((arg1 as u256) * (arg3 as u256) * 4 * v1 * (arg3 as u256) + v0 * v2 * v2)) - v0 * v2) / 2 * v1 * (arg3 as u256)) as u64)
    }

    public fun zap_in_x<T0, T1, T2>(arg0: &mut 0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::liquidity_pool::GlobalStorage, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x2::coin::Coin<0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::liquidity_pool::LPToken<T0, T1, T2>>) {
        0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::curves::assert_valid_curve<T2>();
        assert!(0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::helper::is_sorted<T0, T1>(), 10001);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 10015);
        let v1 = 0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::liquidity_pool::borrow_pool<T0, T1, T2>(arg0);
        let (v2, v3) = 0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::liquidity_pool::get_fees_config<T0, T1, T2>(v1);
        let (v4, _, _) = 0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::liquidity_pool::get_amounts<T0, T1, T2>(v1);
        assert!(v4 > 0, 10019);
        let v7 = if (0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::curves::is_stable<T2>()) {
            v0 / 2
        } else {
            zap_cal_swap_in_amount<T0, T1, T2>(v4, v0, v2, v3)
        };
        let v8 = 0x2::coin::split<T0>(&mut arg1, v7, arg3);
        let v9 = swap_exact_coin_x_for_coin_y<T0, T1, T2>(arg0, v8, 1, arg3);
        add_liquidity<T0, T1, T2>(arg0, arg1, 1, v9, 1, arg2, arg3)
    }

    public fun zap_in_y<T0, T1, T2>(arg0: &mut 0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::liquidity_pool::GlobalStorage, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x2::coin::Coin<0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::liquidity_pool::LPToken<T0, T1, T2>>) {
        0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::curves::assert_valid_curve<T2>();
        assert!(0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::helper::is_sorted<T0, T1>(), 10001);
        let v0 = 0x2::coin::value<T1>(&arg1);
        assert!(v0 > 0, 10015);
        let v1 = 0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::liquidity_pool::borrow_pool<T0, T1, T2>(arg0);
        let (v2, v3) = 0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::liquidity_pool::get_fees_config<T0, T1, T2>(v1);
        let (_, v5, _) = 0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::liquidity_pool::get_amounts<T0, T1, T2>(v1);
        assert!(v5 > 0, 10019);
        let v7 = if (0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::curves::is_stable<T2>()) {
            v0 / 2
        } else {
            zap_cal_swap_in_amount<T0, T1, T2>(v5, v0, v2, v3)
        };
        let v8 = 0x2::coin::split<T1>(&mut arg1, v7, arg3);
        let v9 = swap_exact_coin_y_for_coin_x<T0, T1, T2>(arg0, v8, 1, arg3);
        add_liquidity<T0, T1, T2>(arg0, v9, 1, arg1, 1, arg2, arg3)
    }

    // decompiled from Move bytecode v6
}

