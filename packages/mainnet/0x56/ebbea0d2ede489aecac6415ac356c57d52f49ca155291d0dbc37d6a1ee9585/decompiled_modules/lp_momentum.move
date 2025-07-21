module 0x56ebbea0d2ede489aecac6415ac356c57d52f49ca155291d0dbc37d6a1ee9585::lp_momentum {
    struct MomentumWitness has drop {
        dummy_field: bool,
    }

    public fun compound<T0, T1>(arg0: &mut 0x6c286cdd52c7ca07ab29a70d1afab565c5899adbdc1acf2ab4554456faa25d68::registry::Registry, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T1>, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0x6c286cdd52c7ca07ab29a70d1afab565c5899adbdc1acf2ab4554456faa25d68::registry::compound_fee_pips(arg0, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::swap_fee_rate<T0, T1>(arg2));
        let (v1, v2, v3, v4) = zap_in_int<T0, T1>(arg0, arg1, arg2, arg3, 0x2::coin::into_balance<T0>(arg4), 0x2::coin::into_balance<T1>(arg5), 0x6c286cdd52c7ca07ab29a70d1afab565c5899adbdc1acf2ab4554456faa25d68::constants::compound_fee_source(), v0, arg8, arg9);
        assert!(v1 >= arg6 && v2 >= arg7, 1);
        let v5 = init_witness();
        0x6c286cdd52c7ca07ab29a70d1afab565c5899adbdc1acf2ab4554456faa25d68::events::emit_compounded<MomentumWitness>(arg0, &v5, 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>>(arg2), 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(arg3), v1, v2);
        (0x2::coin::from_balance<T0>(v3, arg9), 0x2::coin::from_balance<T1>(v4, arg9))
    }

    fun init_witness() : MomentumWitness {
        MomentumWitness{dummy_field: false}
    }

    public fun rebalance<T0, T1>(arg0: &mut 0x6c286cdd52c7ca07ab29a70d1afab565c5899adbdc1acf2ab4554456faa25d68::registry::Registry, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg3: 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position, arg4: u32, arg5: u32, arg6: 0x2::coin::Coin<T0>, arg7: 0x2::coin::Coin<T1>, arg8: u64, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position) {
        let (v0, v1) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::liquidity::remove_liquidity<T0, T1>(arg2, &mut arg3, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::liquidity(&arg3), 0, 0, arg10, arg1, arg11);
        let v2 = v1;
        let v3 = v0;
        0x2::coin::join<T0>(&mut arg6, v3);
        0x2::coin::join<T1>(&mut arg7, v2);
        let v4 = 0x6c286cdd52c7ca07ab29a70d1afab565c5899adbdc1acf2ab4554456faa25d68::registry::rebalance_fee_pips(arg0, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::swap_fee_rate<T0, T1>(arg2));
        let v5 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::liquidity::open_position<T0, T1>(arg2, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::from_u32(arg4), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::from_u32(arg5), arg1, arg11);
        let v6 = &mut v5;
        let (v7, v8, v9, v10) = zap_in_int<T0, T1>(arg0, arg1, arg2, v6, 0x2::coin::into_balance<T0>(arg6), 0x2::coin::into_balance<T1>(arg7), 0x6c286cdd52c7ca07ab29a70d1afab565c5899adbdc1acf2ab4554456faa25d68::constants::rebalance_fee_source(), v4, arg10, arg11);
        assert!(v7 >= arg8 && v8 >= arg9, 1);
        let v11 = init_witness();
        0x6c286cdd52c7ca07ab29a70d1afab565c5899adbdc1acf2ab4554456faa25d68::events::emit_rebalanced<MomentumWitness>(arg0, &v11, 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>>(arg2), 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&arg3), 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&v5), 0x2::coin::value<T0>(&v3), 0x2::coin::value<T1>(&v2), v7, v8);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::liquidity::close_position(arg3, arg1, arg11);
        (0x2::coin::from_balance<T0>(v9, arg11), 0x2::coin::from_balance<T1>(v10, arg11), v5)
    }

    fun swap_to_optimal<T0, T1>(arg0: &0x6c286cdd52c7ca07ab29a70d1afab565c5899adbdc1acf2ab4554456faa25d68::registry::Registry, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg3: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position, arg4: &mut 0x2::balance::Balance<T0>, arg5: &mut 0x2::balance::Balance<T1>, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        let (v0, v1, v2, _) = 0x56ebbea0d2ede489aecac6415ac356c57d52f49ca155291d0dbc37d6a1ee9585::swap_math::optimal_swap<T0, T1>(arg2, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::as_u32(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::tick_lower_index(arg3)), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::as_u32(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::tick_upper_index(arg3)), 0x2::balance::value<T0>(arg4), 0x2::balance::value<T1>(arg5));
        if (v0 == 0 && v1 == 0) {
            return
        };
        let (v4, v5, v6) = if (v2) {
            (0x2::balance::split<T0>(arg4, v0), 0x2::balance::zero<T1>(), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::min_sqrt_price() + 1)
        } else {
            (0x2::balance::zero<T0>(), 0x2::balance::split<T1>(arg5, v0), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::max_sqrt_price() - 1)
        };
        let (v7, v8, v9) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg2, v2, true, v0, v6, arg6, arg1, arg7);
        let v10 = v8;
        let v11 = v7;
        0x6c286cdd52c7ca07ab29a70d1afab565c5899adbdc1acf2ab4554456faa25d68::registry::assert_price(arg0, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::sqrt_price<T0, T1>(arg2), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::sqrt_price<T0, T1>(arg2));
        let v12 = if (v2) {
            0x2::balance::value<T1>(&v10)
        } else {
            0x2::balance::value<T0>(&v11)
        };
        0x6c286cdd52c7ca07ab29a70d1afab565c5899adbdc1acf2ab4554456faa25d68::registry::assert_output(arg0, v1, v12);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg2, v9, v4, v5, arg1, arg7);
        0x2::balance::join<T0>(arg4, v11);
        0x2::balance::join<T1>(arg5, v10);
    }

    public fun zap_in<T0, T1>(arg0: &mut 0x6c286cdd52c7ca07ab29a70d1afab565c5899adbdc1acf2ab4554456faa25d68::registry::Registry, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T1>, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0x6c286cdd52c7ca07ab29a70d1afab565c5899adbdc1acf2ab4554456faa25d68::registry::zap_fee_pips(arg0, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::swap_fee_rate<T0, T1>(arg2));
        let (v1, v2, v3, v4) = zap_in_int<T0, T1>(arg0, arg1, arg2, arg3, 0x2::coin::into_balance<T0>(arg4), 0x2::coin::into_balance<T1>(arg5), 0x6c286cdd52c7ca07ab29a70d1afab565c5899adbdc1acf2ab4554456faa25d68::constants::zap_in_fee_source(), v0, arg8, arg9);
        assert!(v1 >= arg6 && v2 >= arg7, 1);
        let v5 = init_witness();
        0x6c286cdd52c7ca07ab29a70d1afab565c5899adbdc1acf2ab4554456faa25d68::events::emit_zapped_in<MomentumWitness>(arg0, &v5, 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>>(arg2), 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(arg3), v1, v2);
        (0x2::coin::from_balance<T0>(v3, arg9), 0x2::coin::from_balance<T1>(v4, arg9))
    }

    fun zap_in_int<T0, T1>(arg0: &mut 0x6c286cdd52c7ca07ab29a70d1afab565c5899adbdc1acf2ab4554456faa25d68::registry::Registry, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position, arg4: 0x2::balance::Balance<T0>, arg5: 0x2::balance::Balance<T1>, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (u64, u64, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        0x6c286cdd52c7ca07ab29a70d1afab565c5899adbdc1acf2ab4554456faa25d68::registry::collect_fees<T0>(arg0, 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>>(arg2), &mut arg4, arg6, arg7);
        0x6c286cdd52c7ca07ab29a70d1afab565c5899adbdc1acf2ab4554456faa25d68::registry::collect_fees<T1>(arg0, 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>>(arg2), &mut arg5, arg6, arg7);
        let v0 = &mut arg4;
        let v1 = &mut arg5;
        swap_to_optimal<T0, T1>(arg0, arg1, arg2, arg3, v0, v1, arg8, arg9);
        let v2 = 0x2::balance::value<T0>(&arg4);
        let v3 = 0x2::balance::value<T1>(&arg5);
        assert!(v2 > 0 || v3 > 0, 0);
        let (v4, v5) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::liquidity::add_liquidity<T0, T1>(arg2, arg3, 0x2::coin::from_balance<T0>(arg4, arg9), 0x2::coin::from_balance<T1>(arg5, arg9), 0, 0, arg8, arg1, arg9);
        let v6 = v5;
        let v7 = v4;
        (v2 - 0x2::coin::value<T0>(&v7), v3 - 0x2::coin::value<T1>(&v6), 0x2::coin::into_balance<T0>(v7), 0x2::coin::into_balance<T1>(v6))
    }

    public fun zap_out<T0, T1, T2>(arg0: &mut 0x6c286cdd52c7ca07ab29a70d1afab565c5899adbdc1acf2ab4554456faa25d68::registry::Registry, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position, arg3: 0x2::coin::Coin<T2>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        let v0 = 0x2::coin::into_balance<T2>(arg3);
        0x6c286cdd52c7ca07ab29a70d1afab565c5899adbdc1acf2ab4554456faa25d68::registry::collect_fees<T2>(arg0, 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>>(arg1), &mut v0, 0x6c286cdd52c7ca07ab29a70d1afab565c5899adbdc1acf2ab4554456faa25d68::constants::zap_out_fee_source(), 0x6c286cdd52c7ca07ab29a70d1afab565c5899adbdc1acf2ab4554456faa25d68::registry::zap_fee_pips(arg0, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::swap_fee_rate<T0, T1>(arg1)));
        let v1 = init_witness();
        0x6c286cdd52c7ca07ab29a70d1afab565c5899adbdc1acf2ab4554456faa25d68::events::emit_zapped_out<MomentumWitness>(arg0, &v1, 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>>(arg1), 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(arg2), 0x1::type_name::get<T2>(), 0x2::balance::value<T2>(&v0));
        0x2::coin::from_balance<T2>(v0, arg4)
    }

    // decompiled from Move bytecode v6
}

