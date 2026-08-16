module 0x5d80bdec168ad1eda6ac9ad8c03155a26a02ddbf1c49c7ae504e07cecaaad7ef::m_skh5lite7l {
    struct T_uwehzdz5ls has key {
        id: 0x2::object::UID,
        admin_cap_id: 0x2::object::ID,
        profit_recipient: address,
    }

    struct T_2lormvfa3h has store, key {
        id: 0x2::object::UID,
        registry_id: 0x2::object::ID,
    }

    struct T_lm5roak32v<phantom T0, phantom T1, phantom T2> has store, key {
        id: 0x2::object::UID,
        registry_id: 0x2::object::ID,
        bluefin_pool_id: 0x2::object::ID,
        owner: address,
        tick_spacing: u32,
        income_policy_version: u8,
        retained_a: 0x2::balance::Balance<T0>,
        retained_b: 0x2::balance::Balance<T1>,
        retained_sui: 0x2::balance::Balance<0x2::sui::SUI>,
        cumulative_gross_income: u128,
        cumulative_payout: u128,
        cumulative_retained: u128,
    }

    struct T_wfjjt3vuxw<phantom T0, phantom T1, phantom T2> has store, key {
        id: 0x2::object::UID,
        registry_id: 0x2::object::ID,
        route_id: 0x2::object::ID,
        bluefin_pool_id: 0x2::object::ID,
        bluefin_position_id: 0x2::object::ID,
        owner: address,
        tick_lower: u32,
        tick_upper: u32,
        registered_liquidity: u128,
    }

    struct T_bf2izpppac<phantom T0, phantom T1, phantom T2, phantom T3, phantom T4, phantom T5> has store, key {
        id: 0x2::object::UID,
        registry_id: 0x2::object::ID,
        source_route_id: 0x2::object::ID,
        destination_route_id: 0x2::object::ID,
        source_pool_id: 0x2::object::ID,
        destination_pool_id: 0x2::object::ID,
        owner: address,
        source_tick_spacing: u32,
        destination_tick_spacing: u32,
        destination_width_intervals: u32,
        income_policy_version: u8,
        retained_destination_a: 0x2::balance::Balance<T3>,
        retained_destination_b: 0x2::balance::Balance<T4>,
        retained_sui: 0x2::balance::Balance<0x2::sui::SUI>,
        cumulative_gross_income: u128,
        cumulative_payout: u128,
        cumulative_retained: u128,
    }

    struct T_miprd2fdco<phantom T0, phantom T1, phantom T2, phantom T3, phantom T4, phantom T5> {
        registry_id: 0x2::object::ID,
        route_id: 0x2::object::ID,
        source_route_id: 0x2::object::ID,
        destination_route_id: 0x2::object::ID,
        source_pool_id: 0x2::object::ID,
        destination_pool_id: 0x2::object::ID,
        owner: address,
        source_position_cap_id: 0x2::object::ID,
        source_position_id: 0x2::object::ID,
        source_liquidity: u128,
        source_tick_lower: u32,
        source_tick_upper: u32,
        reward_amount: u64,
        fee_a: u64,
        fee_b: u64,
        source_principal_a: u64,
        source_principal_b: u64,
    }

    struct T_5rxyyb35j4<phantom T0, phantom T1, phantom T2, phantom T3, phantom T4, phantom T5> {
        registry_id: 0x2::object::ID,
        route_id: 0x2::object::ID,
        source_position_id: 0x2::object::ID,
        profit_recipient: address,
        reward_as_sui: u64,
        fee_a_as_sui: u64,
        fee_b_as_sui: u64,
        gross_income_sui: u64,
        payout_sui: u64,
        newly_retained_sui: u64,
        rounding_to_recipient: u64,
        prior_retained_destination_a: u64,
        prior_retained_destination_b: u64,
        prior_retained_sui: u64,
        cumulative_gross_income: u128,
        cumulative_payout: u128,
        cumulative_retained: u128,
    }

    struct T_hbj4avovmz has copy, drop {
        source_a: u64,
        source_b: u64,
        conversion_input_a: u64,
        conversion_input_b: u64,
        conversion_output_a: u64,
        conversion_output_b: u64,
        destination_available_a: u64,
        destination_available_b: u64,
        deposited_a: u64,
        deposited_b: u64,
        residual_a: u64,
        residual_b: u64,
    }

    struct T_7us22zail3 has copy, drop {
        sui_to_destination_a_input: u64,
        sui_to_destination_a_output: u64,
        sui_to_destination_b_input: u64,
        sui_to_destination_b_output: u64,
        available_a: u64,
        available_b: u64,
        available_sui: u64,
        deposited_a: u64,
        deposited_b: u64,
        residual_a: u64,
        residual_b: u64,
        residual_sui: u64,
    }

    struct T_seegehhros<phantom T0, phantom T1, phantom T2, phantom T3, phantom T4, phantom T5> has copy, drop {
        registry_id: 0x2::object::ID,
        route_id: 0x2::object::ID,
        source_route_id: 0x2::object::ID,
        destination_route_id: 0x2::object::ID,
        source_pool_id: 0x2::object::ID,
        destination_pool_id: 0x2::object::ID,
        source_position_cap_id: 0x2::object::ID,
        source_position_id: 0x2::object::ID,
        destination_position_cap_id: 0x2::object::ID,
        destination_position_id: 0x2::object::ID,
        owner: address,
        source_liquidity: u128,
        destination_liquidity: u128,
        source_tick_lower: u32,
        source_tick_upper: u32,
        destination_tick_lower: u32,
        destination_tick_upper: u32,
        tick_spacing: u32,
        width_intervals: u32,
        income: T_47j7hh4zol,
        principal: T_hbj4avovmz,
        retained: T_7us22zail3,
    }

    struct T_uygben3tzu has copy, drop {
        registry_id: 0x2::object::ID,
        route_id: 0x2::object::ID,
        source_route_id: 0x2::object::ID,
        destination_route_id: 0x2::object::ID,
        source_pool_id: 0x2::object::ID,
        destination_pool_id: 0x2::object::ID,
        owner: address,
        source_tick_spacing: u32,
        destination_tick_spacing: u32,
        destination_width_intervals: u32,
        income_policy_version: u8,
    }

    struct T_z772z6bxmw has copy, drop {
        registry_id: 0x2::object::ID,
        route_id: 0x2::object::ID,
        position_cap_id: 0x2::object::ID,
        source_pool_id: 0x2::object::ID,
        source_position_id: 0x2::object::ID,
        owner: address,
        tick_lower: u32,
        tick_upper: u32,
        liquidity: u128,
    }

    struct T_puatrxen6t has copy, drop {
        registry_id: 0x2::object::ID,
        route_id: 0x2::object::ID,
        source_route_id: 0x2::object::ID,
        destination_route_id: 0x2::object::ID,
        source_pool_id: 0x2::object::ID,
        destination_pool_id: 0x2::object::ID,
        source_position_cap_id: 0x2::object::ID,
        source_position_id: 0x2::object::ID,
        owner: address,
        source_liquidity: u128,
        source_tick_lower: u32,
        source_tick_upper: u32,
        reward_amount: u64,
        fee_a: u64,
        fee_b: u64,
        source_principal_a: u64,
        source_principal_b: u64,
    }

    struct T_dvgwutblvu has copy, drop {
        registry_id: 0x2::object::ID,
        route_id: 0x2::object::ID,
        source_position_id: 0x2::object::ID,
        owner: address,
        income: T_47j7hh4zol,
    }

    struct T_lafqymjj3z has copy, drop {
        registry_id: 0x2::object::ID,
        route_id: 0x2::object::ID,
        source_position_cap_id: 0x2::object::ID,
        replacement_position_cap_id: 0x2::object::ID,
        bluefin_pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        owner: address,
        liquidity_before: u128,
        liquidity_after: u128,
        additional_a: u64,
        additional_b: u64,
        deposited_a: u64,
        deposited_b: u64,
        residual_a: u64,
        residual_b: u64,
    }

    struct T_7np4ziycu4<phantom T0, phantom T1, phantom T2> {
        registry_id: 0x2::object::ID,
        route_id: 0x2::object::ID,
        bluefin_pool_id: 0x2::object::ID,
        owner: address,
        source_position_cap_id: 0x2::object::ID,
        source_position_id: 0x2::object::ID,
        source_liquidity: u128,
        source_tick_lower: u32,
        source_tick_upper: u32,
        reward_amount: u64,
        fee_a: u64,
        fee_b: u64,
        source_principal_a: u64,
        source_principal_b: u64,
        oor_asserted: bool,
    }

    struct T_t6hkknofvj<phantom T0, phantom T1, phantom T2> {
        registry_id: 0x2::object::ID,
        route_id: 0x2::object::ID,
        source_position_id: 0x2::object::ID,
        profit_recipient: address,
        reward_as_sui: u64,
        fee_a_as_sui: u64,
        fee_b_as_sui: u64,
        gross_income_sui: u64,
        payout_sui: u64,
        newly_retained_sui: u64,
        rounding_to_recipient: u64,
        prior_retained_a: u64,
        prior_retained_b: u64,
        prior_retained_sui: u64,
        cumulative_gross_income: u128,
        cumulative_payout: u128,
        cumulative_retained: u128,
    }

    struct T_f32dxuihah has copy, drop {
        registry_id: 0x2::object::ID,
        admin_cap_id: 0x2::object::ID,
        profit_recipient: address,
    }

    struct T_pu6vodzgzx has copy, drop {
        registry_id: 0x2::object::ID,
        route_id: 0x2::object::ID,
        bluefin_pool_id: 0x2::object::ID,
        owner: address,
        tick_spacing: u32,
        income_policy_version: u8,
        reward_is_sui: bool,
    }

    struct T_v5g66degtb has copy, drop {
        registry_id: 0x2::object::ID,
        route_id: 0x2::object::ID,
        position_cap_id: 0x2::object::ID,
        bluefin_pool_id: 0x2::object::ID,
        bluefin_position_id: 0x2::object::ID,
        owner: address,
        tick_lower: u32,
        tick_upper: u32,
        liquidity: u128,
    }

    struct T_qd4yxudsoc has copy, drop {
        registry_id: 0x2::object::ID,
        route_id: 0x2::object::ID,
        source_position_cap_id: 0x2::object::ID,
        bluefin_pool_id: 0x2::object::ID,
        source_position_id: 0x2::object::ID,
        owner: address,
        source_liquidity: u128,
        source_tick_lower: u32,
        source_tick_upper: u32,
        reward_amount: u64,
        fee_a: u64,
        fee_b: u64,
        source_principal_a: u64,
        source_principal_b: u64,
        min_source_principal_a: u64,
        min_source_principal_b: u64,
    }

    struct T_nggah7yxb5 has copy, drop {
        registry_id: 0x2::object::ID,
        route_id: 0x2::object::ID,
        source_position_id: 0x2::object::ID,
        current_tick: u32,
        source_tick_lower: u32,
        source_tick_upper: u32,
    }

    struct T_47j7hh4zol has copy, drop {
        profit_recipient: address,
        reward_as_sui: u64,
        fee_a_as_sui: u64,
        fee_b_as_sui: u64,
        gross_income_sui: u64,
        payout_sui: u64,
        newly_retained_sui: u64,
        rounding_to_recipient: u64,
        prior_retained_a: u64,
        prior_retained_b: u64,
        prior_retained_sui: u64,
        cumulative_gross_income: u128,
        cumulative_payout: u128,
        cumulative_retained: u128,
    }

    struct T_5ffpvfebjh has copy, drop {
        registry_id: 0x2::object::ID,
        route_id: 0x2::object::ID,
        source_position_id: 0x2::object::ID,
        owner: address,
        income: T_47j7hh4zol,
    }

    struct T_o6pwuxoeop has copy, drop {
        before_a: u64,
        before_b: u64,
        rebalance_direction: u8,
        rebalance_input: u64,
        rebalance_output: u64,
        available_a: u64,
        available_b: u64,
        deposited_a: u64,
        deposited_b: u64,
        residual_a: u64,
        residual_b: u64,
    }

    struct T_wol2enxndn has copy, drop {
        sui_to_a_input: u64,
        sui_to_a_output: u64,
        sui_to_b_input: u64,
        sui_to_b_output: u64,
        available_a: u64,
        available_b: u64,
        available_sui: u64,
        deposited_a: u64,
        deposited_b: u64,
        residual_a: u64,
        residual_b: u64,
        residual_sui: u64,
    }

    struct T_s75dbg5plt has copy, drop {
        registry_id: 0x2::object::ID,
        route_id: 0x2::object::ID,
        source_position_cap_id: 0x2::object::ID,
        replacement_position_cap_id: 0x2::object::ID,
        bluefin_pool_id: 0x2::object::ID,
        source_position_id: 0x2::object::ID,
        replacement_position_id: 0x2::object::ID,
        owner: address,
        source_liquidity: u128,
        replacement_liquidity: u128,
        source_tick_lower: u32,
        source_tick_upper: u32,
        target_tick_lower: u32,
        target_tick_upper: u32,
        tick_spacing: u32,
        width_intervals: u32,
        income: T_47j7hh4zol,
        principal: T_o6pwuxoeop,
        retained: T_wol2enxndn,
    }

    struct T_nq5etekvgh has copy, drop {
        registry_id: 0x2::object::ID,
        route_id: 0x2::object::ID,
        owner: address,
        amount_a: u64,
        amount_b: u64,
        amount_sui: u64,
        live_position_untouched: bool,
    }

    fun f_2d2t32f2sz<T0, T1, T2, T3, T4, T5>(arg0: &T_5rxyyb35j4<T0, T1, T2, T3, T4, T5>) : T_47j7hh4zol {
        T_47j7hh4zol{
            profit_recipient        : arg0.profit_recipient,
            reward_as_sui           : arg0.reward_as_sui,
            fee_a_as_sui            : arg0.fee_a_as_sui,
            fee_b_as_sui            : arg0.fee_b_as_sui,
            gross_income_sui        : arg0.gross_income_sui,
            payout_sui              : arg0.payout_sui,
            newly_retained_sui      : arg0.newly_retained_sui,
            rounding_to_recipient   : arg0.rounding_to_recipient,
            prior_retained_a        : arg0.prior_retained_destination_a,
            prior_retained_b        : arg0.prior_retained_destination_b,
            prior_retained_sui      : arg0.prior_retained_sui,
            cumulative_gross_income : arg0.cumulative_gross_income,
            cumulative_payout       : arg0.cumulative_payout,
            cumulative_retained     : arg0.cumulative_retained,
        }
    }

    fun f_2rakbhkpwv<T0, T1, T2, T3, T4, T5>(arg0: &T_uwehzdz5ls, arg1: &T_bf2izpppac<T0, T1, T2, T3, T4, T5>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>) {
        f_3xczhy5i35(arg0);
        assert!(arg1.registry_id == 0x2::object::id<T_uwehzdz5ls>(arg0), 1);
        assert!(arg1.source_pool_id == 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg2), 4);
        assert!(arg1.source_pool_id != arg1.destination_pool_id, 25);
        assert!(arg1.source_route_id != arg1.destination_route_id, 25);
        assert!(arg1.owner != @0x0, 5);
        f_ny4krmjt6j(arg1.source_tick_spacing);
        f_ny4krmjt6j(arg1.destination_tick_spacing);
        assert!(0x5d80bdec168ad1eda6ac9ad8c03155a26a02ddbf1c49c7ae504e07cecaaad7ef::m_llkg4bq6ji::f_exgc5n24lf(arg1.destination_width_intervals), 7);
        assert!(arg1.income_policy_version == 1, 21);
    }

    public fun f_2xdd6lnobe<T0, T1, T2, T3, T4, T5>(arg0: &0x2::clock::Clock, arg1: &T_uwehzdz5ls, arg2: &mut T_bf2izpppac<T0, T1, T2, T3, T4, T5>, arg3: T_miprd2fdco<T0, T1, T2, T3, T4, T5>, arg4: T_5rxyyb35j4<T0, T1, T2, T3, T4, T5>, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T4>, arg7: 0x2::balance::Balance<T3>, arg8: 0x2::balance::Balance<T4>, arg9: 0x2::balance::Balance<T3>, arg10: 0x2::balance::Balance<T4>, arg11: 0x2::balance::Balance<0x2::sui::SUI>, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: u64, arg19: u64, arg20: u64, arg21: bool, arg22: u64, arg23: u64, arg24: u64, arg25: u64, arg26: u64, arg27: bool, arg28: u64, arg29: u64, arg30: u64, arg31: u64, arg32: &0x5d80bdec168ad1eda6ac9ad8c03155a26a02ddbf1c49c7ae504e07cecaaad7ef::m_nblxzh5qdb::T_5kldtuzgei, arg33: &mut 0x2::tx_context::TxContext) {
        f_vnfimunank<T0, T1, T2, T3, T4, T5>(arg1, arg2, arg6, arg33);
        let v0 = 0x2::object::id<T_uwehzdz5ls>(arg1);
        let v1 = 0x2::object::id<T_bf2izpppac<T0, T1, T2, T3, T4, T5>>(arg2);
        let v2 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T4>>(arg6);
        assert!(arg3.registry_id == v0, 1);
        assert!(arg3.route_id == v1, 3);
        assert!(arg3.source_route_id == arg2.source_route_id, 3);
        assert!(arg3.destination_route_id == arg2.destination_route_id, 28);
        assert!(arg3.destination_pool_id == v2, 28);
        assert!(arg3.source_pool_id == arg2.source_pool_id, 4);
        assert!(arg3.owner == arg2.owner, 5);
        assert!(0x2::balance::value<T3>(&arg2.retained_destination_a) == 0, 14);
        assert!(0x2::balance::value<T4>(&arg2.retained_destination_b) == 0, 14);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg2.retained_sui) == 0, 14);
        f_ntf62xvxkn<T0, T1, T2, T3, T4, T5>(arg1, arg2, &arg3, &arg4);
        let v3 = 0x2::balance::value<T3>(&arg7);
        let v4 = 0x2::balance::value<T4>(&arg8);
        assert!(0x5d80bdec168ad1eda6ac9ad8c03155a26a02ddbf1c49c7ae504e07cecaaad7ef::m_llkg4bq6ji::f_ag7k2yz6j3(arg3.source_principal_a, arg3.source_principal_b, arg12, arg13, arg14, arg15, v3, v4), 26);
        assert!(arg20 > 0, 20);
        let v5 = arg4.prior_retained_destination_a;
        let v6 = arg4.prior_retained_destination_b;
        let v7 = 0x2::balance::value<T3>(&arg9);
        let v8 = 0x2::balance::value<T4>(&arg10);
        let v9 = 0x2::balance::value<0x2::sui::SUI>(&arg11);
        assert!(v7 >= v5, 14);
        assert!(v8 >= v6, 14);
        assert!(arg17 == v7 - v5, 14);
        assert!(arg19 == v8 - v6, 14);
        f_maba7bksjq(arg16, arg17, arg17);
        f_maba7bksjq(arg18, arg19, arg19);
        assert!(0x5d80bdec168ad1eda6ac9ad8c03155a26a02ddbf1c49c7ae504e07cecaaad7ef::m_llkg4bq6ji::f_4alod2uun2(v5, v6, arg4.prior_retained_sui, arg4.newly_retained_sui, v7, v8, v9, arg16, arg17, arg18, arg19), 14);
        let (v10, v11) = f_lrfk6ltbkc(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T3, T4>(arg6), 0x5d80bdec168ad1eda6ac9ad8c03155a26a02ddbf1c49c7ae504e07cecaaad7ef::m_llkg4bq6ji::f_r5njkme6mj(arg2.destination_tick_spacing, arg2.destination_width_intervals), arg2.destination_tick_spacing, arg2.destination_width_intervals);
        let v12 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::open_position<T3, T4>(arg5, arg6, v10, v11, arg33);
        let v13 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&v12);
        let (v14, v15, v16, v17) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::add_liquidity_with_fixed_amount<T3, T4>(arg0, arg5, arg6, &mut v12, arg7, arg8, arg20, arg21);
        let v18 = v17;
        let v19 = v16;
        let v20 = 0x2::balance::value<T3>(&v19);
        let v21 = 0x2::balance::value<T4>(&v18);
        assert!(v14 + v20 == v3, 14);
        assert!(v15 + v21 == v4, 14);
        assert!(v14 >= arg22, 16);
        assert!(v15 >= arg23, 17);
        assert!(v20 <= arg24, 18);
        assert!(v21 <= arg25, 19);
        let (v22, v23, v24, v25) = if (v7 == 0 && v8 == 0) {
            assert!(arg26 == 0, 20);
            assert!(arg28 == 0, 16);
            assert!(arg29 == 0, 17);
            (0, 0, arg9, arg10)
        } else {
            assert!(arg26 > 0, 20);
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::add_liquidity_with_fixed_amount<T3, T4>(arg0, arg5, arg6, &mut v12, arg9, arg10, arg26, arg27)
        };
        let v26 = v25;
        let v27 = v24;
        let v28 = 0x2::balance::value<T3>(&v27);
        let v29 = 0x2::balance::value<T4>(&v26);
        assert!(v22 + v28 == v7, 14);
        assert!(v23 + v29 == v8, 14);
        assert!(v22 >= arg28, 16);
        assert!(v23 >= arg29, 17);
        assert!(v28 <= arg30, 18);
        assert!(v29 <= arg31, 19);
        0x2::balance::join<T3>(&mut arg2.retained_destination_a, v27);
        0x2::balance::join<T4>(&mut arg2.retained_destination_b, v26);
        0x2::balance::join<0x2::sui::SUI>(&mut arg2.retained_sui, arg11);
        let v30 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(&v12);
        assert!(v30 > 0, 8);
        f_4j5hc5vnu5(&v12, v2, v10, v11);
        let v31 = T_wfjjt3vuxw<T3, T4, T5>{
            id                   : 0x2::object::new(arg33),
            registry_id          : v0,
            route_id             : arg2.destination_route_id,
            bluefin_pool_id      : v2,
            bluefin_position_id  : v13,
            owner                : arg2.owner,
            tick_lower           : v10,
            tick_upper           : v11,
            registered_liquidity : v30,
        };
        let v32 = T_hbj4avovmz{
            source_a                : arg3.source_principal_a,
            source_b                : arg3.source_principal_b,
            conversion_input_a      : arg12,
            conversion_input_b      : arg13,
            conversion_output_a     : arg14,
            conversion_output_b     : arg15,
            destination_available_a : v3,
            destination_available_b : v4,
            deposited_a             : v14,
            deposited_b             : v15,
            residual_a              : v20,
            residual_b              : v21,
        };
        let v33 = T_7us22zail3{
            sui_to_destination_a_input  : arg16,
            sui_to_destination_a_output : arg17,
            sui_to_destination_b_input  : arg18,
            sui_to_destination_b_output : arg19,
            available_a                 : v7,
            available_b                 : v8,
            available_sui               : v9,
            deposited_a                 : v22,
            deposited_b                 : v23,
            residual_a                  : v28,
            residual_b                  : v29,
            residual_sui                : v9,
        };
        let v34 = T_seegehhros<T0, T1, T2, T3, T4, T5>{
            registry_id                 : v0,
            route_id                    : v1,
            source_route_id             : arg2.source_route_id,
            destination_route_id        : arg2.destination_route_id,
            source_pool_id              : arg3.source_pool_id,
            destination_pool_id         : v2,
            source_position_cap_id      : arg3.source_position_cap_id,
            source_position_id          : arg3.source_position_id,
            destination_position_cap_id : 0x2::object::id<T_wfjjt3vuxw<T3, T4, T5>>(&v31),
            destination_position_id     : v13,
            owner                       : arg2.owner,
            source_liquidity            : arg3.source_liquidity,
            destination_liquidity       : v30,
            source_tick_lower           : arg3.source_tick_lower,
            source_tick_upper           : arg3.source_tick_upper,
            destination_tick_lower      : v10,
            destination_tick_upper      : v11,
            tick_spacing                : arg2.destination_tick_spacing,
            width_intervals             : arg2.destination_width_intervals,
            income                      : f_2d2t32f2sz<T0, T1, T2, T3, T4, T5>(&arg4),
            principal                   : v32,
            retained                    : v33,
        };
        0x2::event::emit<T_seegehhros<T0, T1, T2, T3, T4, T5>>(v34);
        let T_miprd2fdco {
            registry_id            : _,
            route_id               : _,
            source_route_id        : _,
            destination_route_id   : _,
            source_pool_id         : _,
            destination_pool_id    : _,
            owner                  : _,
            source_position_cap_id : _,
            source_position_id     : _,
            source_liquidity       : _,
            source_tick_lower      : _,
            source_tick_upper      : _,
            reward_amount          : _,
            fee_a                  : _,
            fee_b                  : _,
            source_principal_a     : _,
            source_principal_b     : _,
        } = arg3;
        let T_5rxyyb35j4 {
            registry_id                  : _,
            route_id                     : _,
            source_position_id           : _,
            profit_recipient             : _,
            reward_as_sui                : _,
            fee_a_as_sui                 : _,
            fee_b_as_sui                 : _,
            gross_income_sui             : _,
            payout_sui                   : _,
            newly_retained_sui           : _,
            rounding_to_recipient        : _,
            prior_retained_destination_a : _,
            prior_retained_destination_b : _,
            prior_retained_sui           : _,
            cumulative_gross_income      : _,
            cumulative_payout            : _,
            cumulative_retained          : _,
        } = arg4;
        0x2::transfer::public_transfer<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v12, arg2.owner);
        0x2::transfer::public_transfer<T_wfjjt3vuxw<T3, T4, T5>>(v31, arg2.owner);
        f_rw75dmqnxw<T3>(v19, arg2.owner);
        f_rw75dmqnxw<T4>(v18, arg2.owner);
    }

    public(friend) fun f_33ffjhntca<T0, T1, T2, T3, T4, T5>(arg0: &T_uwehzdz5ls, arg1: &T_2lormvfa3h, arg2: &T_lm5roak32v<T0, T1, T2>, arg3: &T_lm5roak32v<T3, T4, T5>, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T4>, arg6: u32, arg7: &mut 0x2::tx_context::TxContext) {
        f_beqne4j46m(arg0, arg1);
        f_w5bzbijaxt<T0, T1, T2, T3, T4, T5>(arg0, arg2, arg3, arg4, arg5);
        assert!(0x5d80bdec168ad1eda6ac9ad8c03155a26a02ddbf1c49c7ae504e07cecaaad7ef::m_llkg4bq6ji::f_exgc5n24lf(arg6), 7);
        let v0 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg4);
        let v1 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T4>>(arg5);
        let v2 = 0x2::object::id<T_lm5roak32v<T0, T1, T2>>(arg2);
        let v3 = 0x2::object::id<T_lm5roak32v<T3, T4, T5>>(arg3);
        let v4 = arg2.owner;
        let v5 = T_bf2izpppac<T0, T1, T2, T3, T4, T5>{
            id                          : 0x2::object::new(arg7),
            registry_id                 : 0x2::object::id<T_uwehzdz5ls>(arg0),
            source_route_id             : v2,
            destination_route_id        : v3,
            source_pool_id              : v0,
            destination_pool_id         : v1,
            owner                       : v4,
            source_tick_spacing         : arg2.tick_spacing,
            destination_tick_spacing    : arg3.tick_spacing,
            destination_width_intervals : arg6,
            income_policy_version       : 1,
            retained_destination_a      : 0x2::balance::zero<T3>(),
            retained_destination_b      : 0x2::balance::zero<T4>(),
            retained_sui                : 0x2::balance::zero<0x2::sui::SUI>(),
            cumulative_gross_income     : 0,
            cumulative_payout           : 0,
            cumulative_retained         : 0,
        };
        let v6 = T_uygben3tzu{
            registry_id                 : 0x2::object::id<T_uwehzdz5ls>(arg0),
            route_id                    : 0x2::object::id<T_bf2izpppac<T0, T1, T2, T3, T4, T5>>(&v5),
            source_route_id             : v2,
            destination_route_id        : v3,
            source_pool_id              : v0,
            destination_pool_id         : v1,
            owner                       : v4,
            source_tick_spacing         : arg2.tick_spacing,
            destination_tick_spacing    : arg3.tick_spacing,
            destination_width_intervals : arg6,
            income_policy_version       : 1,
        };
        0x2::event::emit<T_uygben3tzu>(v6);
        0x2::transfer::public_transfer<T_bf2izpppac<T0, T1, T2, T3, T4, T5>>(v5, v4);
    }

    fun f_3nce72pqt2<T0, T1, T2>(arg0: &T_uwehzdz5ls, arg1: &T_lm5roak32v<T0, T1, T2>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &0x2::tx_context::TxContext) {
        f_vusvmvjklx<T0, T1, T2>(arg0, arg1, arg2);
        assert!(arg1.owner == 0x2::tx_context::sender(arg3), 5);
    }

    fun f_3xczhy5i35(arg0: &T_uwehzdz5ls) {
        assert!(arg0.profit_recipient == @0xa10aecd2e9e45698e8c36ccaf3c4ea51cdda87f3c098a71d1e77be3351000498, 2);
    }

    fun f_4j5hc5vnu5(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg1: 0x2::object::ID, arg2: u32, arg3: u32) {
        assert!(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::pool_id(arg0) == arg1, 22);
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::eq(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::lower_tick(arg0), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg2)), 23);
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::eq(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::upper_tick(arg0), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg3)), 23);
    }

    fun f_4p4lmvcra2<T0, T1, T2>(arg0: &T_uwehzdz5ls, arg1: &T_lm5roak32v<T0, T1, T2>, arg2: &T_7np4ziycu4<T0, T1, T2>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>) {
        assert!(arg2.registry_id == 0x2::object::id<T_uwehzdz5ls>(arg0), 1);
        assert!(arg2.route_id == 0x2::object::id<T_lm5roak32v<T0, T1, T2>>(arg1), 3);
        assert!(arg2.bluefin_pool_id == 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg3), 4);
        assert!(arg2.owner == arg1.owner, 5);
        f_5zu3to7gdh(arg2.source_tick_lower, arg2.source_tick_upper);
    }

    fun f_5riqzgtrzy(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u8, arg5: u64) : u64 {
        if (arg4 == 0) {
            assert!(arg5 == 0, 14);
            0
        } else if (arg4 == 1) {
            assert!(arg5 > 0 && arg3 >= arg1, 14);
            arg3 - arg1
        } else {
            assert!(arg4 == 2, 14);
            assert!(arg5 > 0 && arg2 >= arg0, 14);
            arg2 - arg0
        }
    }

    fun f_5zu3to7gdh(arg0: u32, arg1: u32) {
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg1)), 7);
    }

    public fun f_7aju3ejlai<T0, T1, T2, T3, T4, T5>(arg0: &T_uwehzdz5ls, arg1: &T_2lormvfa3h, arg2: &T_lm5roak32v<T0, T1, T2>, arg3: &T_lm5roak32v<T3, T4, T5>, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T4>, arg6: &0x5d80bdec168ad1eda6ac9ad8c03155a26a02ddbf1c49c7ae504e07cecaaad7ef::m_nblxzh5qdb::T_5kldtuzgei, arg7: &mut 0x2::tx_context::TxContext) {
        f_33ffjhntca<T0, T1, T2, T3, T4, T5>(arg0, arg1, arg2, arg3, arg4, arg5, 1, arg7);
    }

    public fun f_7j4xg4giav<T0, T1>(arg0: &T_uwehzdz5ls, arg1: &T_2lormvfa3h, arg2: &T_lm5roak32v<0x2::sui::SUI, T1, 0x2::sui::SUI>, arg3: &T_lm5roak32v<T0, 0x2::sui::SUI, T0>, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, T1>, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, 0x2::sui::SUI>, arg6: &0x5d80bdec168ad1eda6ac9ad8c03155a26a02ddbf1c49c7ae504e07cecaaad7ef::m_nblxzh5qdb::T_5kldtuzgei, arg7: &mut 0x2::tx_context::TxContext) {
        f_oczdxmsgu2(0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, T1>>(arg4));
        assert!(arg2.tick_spacing == 5, 7);
        assert!(arg3.tick_spacing == 1, 7);
        f_33ffjhntca<0x2::sui::SUI, T1, 0x2::sui::SUI, T0, 0x2::sui::SUI, T0>(arg0, arg1, arg2, arg3, arg4, arg5, 4, arg7);
    }

    fun f_ad3j2evozt<T0, T1, T2, T3, T4, T5>(arg0: &T_uwehzdz5ls, arg1: &T_bf2izpppac<T0, T1, T2, T3, T4, T5>, arg2: &0x2::tx_context::TxContext) {
        f_3xczhy5i35(arg0);
        assert!(arg1.registry_id == 0x2::object::id<T_uwehzdz5ls>(arg0), 1);
        assert!(arg1.source_pool_id != arg1.destination_pool_id, 25);
        assert!(arg1.owner != @0x0, 5);
        assert!(arg1.owner == 0x2::tx_context::sender(arg2), 5);
        f_ny4krmjt6j(arg1.source_tick_spacing);
        f_ny4krmjt6j(arg1.destination_tick_spacing);
        assert!(0x5d80bdec168ad1eda6ac9ad8c03155a26a02ddbf1c49c7ae504e07cecaaad7ef::m_llkg4bq6ji::f_exgc5n24lf(arg1.destination_width_intervals), 7);
        assert!(arg1.income_policy_version == 1, 21);
    }

    public fun f_ae2veo2zdj<T0, T1>(arg0: &T_uwehzdz5ls, arg1: &T_2lormvfa3h, arg2: &T_lm5roak32v<T0, 0x2::sui::SUI, T0>, arg3: &T_lm5roak32v<0x2::sui::SUI, T1, 0x2::sui::SUI>, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, 0x2::sui::SUI>, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, T1>, arg6: &0x5d80bdec168ad1eda6ac9ad8c03155a26a02ddbf1c49c7ae504e07cecaaad7ef::m_nblxzh5qdb::T_5kldtuzgei, arg7: &mut 0x2::tx_context::TxContext) {
        f_oczdxmsgu2(0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, T1>>(arg5));
        assert!(arg2.tick_spacing == 1, 7);
        assert!(arg3.tick_spacing == 5, 7);
        f_33ffjhntca<T0, 0x2::sui::SUI, T0, 0x2::sui::SUI, T1, 0x2::sui::SUI>(arg0, arg1, arg2, arg3, arg4, arg5, 4, arg7);
    }

    public fun f_avz5taeydh<T0, T1, T2>(arg0: &T_uwehzdz5ls, arg1: &T_2lormvfa3h, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: u32, arg4: address, arg5: &0x5d80bdec168ad1eda6ac9ad8c03155a26a02ddbf1c49c7ae504e07cecaaad7ef::m_nblxzh5qdb::T_5kldtuzgei, arg6: &mut 0x2::tx_context::TxContext) {
        f_neigviqr7p<T0, T1, T2>(arg0, arg1, arg2, arg3, false, arg4, arg6);
    }

    public fun f_axgzy4j253<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &T_uwehzdz5ls, arg2: &T_lm5roak32v<T0, T1, T2>, arg3: T_wfjjt3vuxw<T0, T1, T2>, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg6: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg7: u128, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: &0x5d80bdec168ad1eda6ac9ad8c03155a26a02ddbf1c49c7ae504e07cecaaad7ef::m_nblxzh5qdb::T_5kldtuzgei, arg14: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, 0x2::balance::Balance<T2>, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, T_7np4ziycu4<T0, T1, T2>) {
        f_3nce72pqt2<T0, T1, T2>(arg1, arg2, arg5, arg14);
        let v0 = 0x2::object::id<T_uwehzdz5ls>(arg1);
        let v1 = 0x2::object::id<T_lm5roak32v<T0, T1, T2>>(arg2);
        let v2 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg5);
        let v3 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&arg6);
        assert!(arg3.registry_id == v0, 1);
        assert!(arg3.route_id == v1, 3);
        assert!(arg3.bluefin_pool_id == v2, 4);
        assert!(arg3.bluefin_position_id == v3, 6);
        assert!(arg3.owner == arg2.owner, 5);
        f_5zu3to7gdh(arg3.tick_lower, arg3.tick_upper);
        f_4j5hc5vnu5(&arg6, v2, arg3.tick_lower, arg3.tick_upper);
        let v4 = 0x2::object::id<T_wfjjt3vuxw<T0, T1, T2>>(&arg3);
        let v5 = arg3.tick_lower;
        let v6 = arg3.tick_upper;
        let v7 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(&arg6);
        assert!(v7 > 0, 8);
        assert!(arg3.registered_liquidity == v7, 24);
        assert!(arg3.registered_liquidity == arg7, 24);
        let v8 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, T1, T2>(arg0, arg4, arg5, &mut arg6);
        let v9 = 0x2::balance::value<T2>(&v8);
        let (v10, v11, v12, v13) = f_iksaeowejj<T0, T1>(arg0, arg4, arg5, arg6);
        let v14 = v13;
        let v15 = v12;
        let v16 = v11;
        let v17 = v10;
        let v18 = 0x2::balance::value<T0>(&v15);
        let v19 = 0x2::balance::value<T1>(&v14);
        let v20 = 0x2::balance::value<T0>(&v17);
        let v21 = 0x2::balance::value<T1>(&v16);
        assert!(v9 >= arg8, 9);
        assert!(v18 >= arg9, 9);
        assert!(v19 >= arg10, 9);
        assert!(v20 >= arg11, 10);
        assert!(v21 >= arg12, 11);
        let v22 = T_7np4ziycu4<T0, T1, T2>{
            registry_id            : v0,
            route_id               : v1,
            bluefin_pool_id        : v2,
            owner                  : arg2.owner,
            source_position_cap_id : v4,
            source_position_id     : v3,
            source_liquidity       : v7,
            source_tick_lower      : v5,
            source_tick_upper      : v6,
            reward_amount          : v9,
            fee_a                  : v18,
            fee_b                  : v19,
            source_principal_a     : v20,
            source_principal_b     : v21,
            oor_asserted           : false,
        };
        let v23 = T_qd4yxudsoc{
            registry_id            : v0,
            route_id               : v1,
            source_position_cap_id : v4,
            bluefin_pool_id        : v2,
            source_position_id     : v3,
            owner                  : arg2.owner,
            source_liquidity       : v7,
            source_tick_lower      : v5,
            source_tick_upper      : v6,
            reward_amount          : v9,
            fee_a                  : v18,
            fee_b                  : v19,
            source_principal_a     : v20,
            source_principal_b     : v21,
            min_source_principal_a : arg11,
            min_source_principal_b : arg12,
        };
        0x2::event::emit<T_qd4yxudsoc>(v23);
        let T_wfjjt3vuxw {
            id                   : v24,
            registry_id          : _,
            route_id             : _,
            bluefin_pool_id      : _,
            bluefin_position_id  : _,
            owner                : _,
            tick_lower           : _,
            tick_upper           : _,
            registered_liquidity : _,
        } = arg3;
        0x2::object::delete(v24);
        (v17, v16, v8, v15, v14, v22)
    }

    fun f_beqne4j46m(arg0: &T_uwehzdz5ls, arg1: &T_2lormvfa3h) {
        f_3xczhy5i35(arg0);
        assert!(arg1.registry_id == 0x2::object::id<T_uwehzdz5ls>(arg0), 0);
        assert!(0x2::object::id<T_2lormvfa3h>(arg1) == arg0.admin_cap_id, 0);
    }

    fun f_ceqrweoewv<T0, T1, T2>(arg0: &T_uwehzdz5ls, arg1: &T_lm5roak32v<T0, T1, T2>, arg2: &0x2::tx_context::TxContext) {
        f_3xczhy5i35(arg0);
        assert!(arg1.registry_id == 0x2::object::id<T_uwehzdz5ls>(arg0), 1);
        assert!(arg1.owner == 0x2::tx_context::sender(arg2), 5);
        f_ny4krmjt6j(arg1.tick_spacing);
        assert!(arg1.income_policy_version == 1, 21);
    }

    public fun f_chtnyzhmfb<T0, T1, T2, T3, T4, T5>(arg0: &T_uwehzdz5ls, arg1: &T_2lormvfa3h, arg2: &T_bf2izpppac<T0, T1, T2, T3, T4, T5>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg5: u32, arg6: u32, arg7: u128, arg8: &0x5d80bdec168ad1eda6ac9ad8c03155a26a02ddbf1c49c7ae504e07cecaaad7ef::m_nblxzh5qdb::T_5kldtuzgei, arg9: &mut 0x2::tx_context::TxContext) {
        f_beqne4j46m(arg0, arg1);
        f_2rakbhkpwv<T0, T1, T2, T3, T4, T5>(arg0, arg2, arg3);
        f_5zu3to7gdh(arg5, arg6);
        let v0 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg3);
        f_4j5hc5vnu5(arg4, v0, arg5, arg6);
        let v1 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(arg4);
        assert!(v1 > 0 && v1 == arg7, 8);
        let v2 = T_wfjjt3vuxw<T0, T1, T2>{
            id                   : 0x2::object::new(arg9),
            registry_id          : 0x2::object::id<T_uwehzdz5ls>(arg0),
            route_id             : arg2.source_route_id,
            bluefin_pool_id      : v0,
            bluefin_position_id  : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(arg4),
            owner                : arg2.owner,
            tick_lower           : arg5,
            tick_upper           : arg6,
            registered_liquidity : v1,
        };
        let v3 = T_z772z6bxmw{
            registry_id        : 0x2::object::id<T_uwehzdz5ls>(arg0),
            route_id           : 0x2::object::id<T_bf2izpppac<T0, T1, T2, T3, T4, T5>>(arg2),
            position_cap_id    : 0x2::object::id<T_wfjjt3vuxw<T0, T1, T2>>(&v2),
            source_pool_id     : v0,
            source_position_id : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(arg4),
            owner              : arg2.owner,
            tick_lower         : arg5,
            tick_upper         : arg6,
            liquidity          : v1,
        };
        0x2::event::emit<T_z772z6bxmw>(v3);
        0x2::transfer::public_transfer<T_wfjjt3vuxw<T0, T1, T2>>(v2, arg2.owner);
    }

    fun f_cvq7wr2l2j<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let (v0, v1) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::get_accrued_fee(arg3);
        if (v0 > 0 || v1 > 0) {
            let (_, _, v6, v7) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_fee<T0, T1>(arg0, arg1, arg2, arg3);
            (v6, v7)
        } else {
            (0x2::balance::zero<T0>(), 0x2::balance::zero<T1>())
        }
    }

    public fun f_dtoqdfrpsc<T0, T1, T2, T3, T4, T5>(arg0: &T_uwehzdz5ls, arg1: &mut T_bf2izpppac<T0, T1, T2, T3, T4, T5>, arg2: &0x5d80bdec168ad1eda6ac9ad8c03155a26a02ddbf1c49c7ae504e07cecaaad7ef::m_nblxzh5qdb::T_5kldtuzgei, arg3: &mut 0x2::tx_context::TxContext) {
        f_ad3j2evozt<T0, T1, T2, T3, T4, T5>(arg0, arg1, arg3);
        f_rw75dmqnxw<T3>(0x2::balance::split<T3>(&mut arg1.retained_destination_a, 0x2::balance::value<T3>(&arg1.retained_destination_a)), arg1.owner);
        f_rw75dmqnxw<T4>(0x2::balance::split<T4>(&mut arg1.retained_destination_b, 0x2::balance::value<T4>(&arg1.retained_destination_b)), arg1.owner);
        f_rw75dmqnxw<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.retained_sui, 0x2::balance::value<0x2::sui::SUI>(&arg1.retained_sui)), arg1.owner);
    }

    public fun f_ehrabltgjt<T0, T1, T2, T3, T4, T5>(arg0: &T_uwehzdz5ls, arg1: &T_2lormvfa3h, arg2: &T_lm5roak32v<T0, T1, T2>, arg3: &T_lm5roak32v<T3, T4, T5>, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T4>, arg6: &0x5d80bdec168ad1eda6ac9ad8c03155a26a02ddbf1c49c7ae504e07cecaaad7ef::m_nblxzh5qdb::T_5kldtuzgei, arg7: &mut 0x2::tx_context::TxContext) {
        f_33ffjhntca<T0, T1, T2, T3, T4, T5>(arg0, arg1, arg2, arg3, arg4, arg5, 4, arg7);
    }

    public fun f_epr7errbj6<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &T_uwehzdz5ls, arg2: 0x2::object::ID, arg3: T_wfjjt3vuxw<T0, T1, T2>, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg6: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg7: u128, arg8: u32, arg9: u32, arg10: 0x2::balance::Balance<T0>, arg11: 0x2::balance::Balance<T1>, arg12: u64, arg13: u64, arg14: u64, arg15: bool, arg16: u64, arg17: u64, arg18: u64, arg19: u64, arg20: &0x5d80bdec168ad1eda6ac9ad8c03155a26a02ddbf1c49c7ae504e07cecaaad7ef::m_nblxzh5qdb::T_5kldtuzgei, arg21: &mut 0x2::tx_context::TxContext) : (T_wfjjt3vuxw<T0, T1, T2>, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position) {
        f_3xczhy5i35(arg1);
        let v0 = 0x2::object::id<T_uwehzdz5ls>(arg1);
        let v1 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg5);
        let v2 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&arg6);
        assert!(arg3.registry_id == v0, 1);
        assert!(arg3.route_id == arg2, 3);
        assert!(arg3.owner == 0x2::tx_context::sender(arg21), 5);
        assert!(arg3.bluefin_pool_id == v1, 4);
        assert!(arg3.bluefin_position_id == v2, 6);
        assert!(arg3.tick_lower == arg8, 23);
        assert!(arg3.tick_upper == arg9, 23);
        f_5zu3to7gdh(arg3.tick_lower, arg3.tick_upper);
        f_4j5hc5vnu5(&arg6, v1, arg3.tick_lower, arg3.tick_upper);
        let v3 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(&arg6);
        assert!(v3 > 0, 8);
        assert!(arg3.registered_liquidity == v3, 24);
        assert!(v3 == arg7, 24);
        let v4 = 0x2::balance::value<T0>(&arg10);
        let v5 = 0x2::balance::value<T1>(&arg11);
        assert!(v4 > 0 || v5 > 0, 29);
        assert!(v4 <= arg12, 29);
        assert!(v5 <= arg13, 29);
        assert!(arg14 > 0, 20);
        let (v6, v7, v8, v9) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::add_liquidity_with_fixed_amount<T0, T1>(arg0, arg4, arg5, &mut arg6, arg10, arg11, arg14, arg15);
        let v10 = v9;
        let v11 = v8;
        let v12 = 0x2::balance::value<T0>(&v11);
        let v13 = 0x2::balance::value<T1>(&v10);
        assert!(v6 + v12 == v4, 14);
        assert!(v7 + v13 == v5, 14);
        assert!(v6 >= arg16, 16);
        assert!(v7 >= arg17, 17);
        assert!(v12 <= arg18, 18);
        assert!(v13 <= arg19, 19);
        let v14 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(&arg6);
        assert!(v14 > v3, 8);
        f_4j5hc5vnu5(&arg6, v1, arg3.tick_lower, arg3.tick_upper);
        let v15 = T_wfjjt3vuxw<T0, T1, T2>{
            id                   : 0x2::object::new(arg21),
            registry_id          : v0,
            route_id             : arg3.route_id,
            bluefin_pool_id      : v1,
            bluefin_position_id  : v2,
            owner                : arg3.owner,
            tick_lower           : arg3.tick_lower,
            tick_upper           : arg3.tick_upper,
            registered_liquidity : v14,
        };
        let v16 = T_lafqymjj3z{
            registry_id                 : v0,
            route_id                    : arg3.route_id,
            source_position_cap_id      : 0x2::object::id<T_wfjjt3vuxw<T0, T1, T2>>(&arg3),
            replacement_position_cap_id : 0x2::object::id<T_wfjjt3vuxw<T0, T1, T2>>(&v15),
            bluefin_pool_id             : v1,
            position_id                 : v2,
            owner                       : arg3.owner,
            liquidity_before            : v3,
            liquidity_after             : v14,
            additional_a                : v4,
            additional_b                : v5,
            deposited_a                 : v6,
            deposited_b                 : v7,
            residual_a                  : v12,
            residual_b                  : v13,
        };
        0x2::event::emit<T_lafqymjj3z>(v16);
        let v17 = v15.owner;
        let T_wfjjt3vuxw {
            id                   : v18,
            registry_id          : _,
            route_id             : _,
            bluefin_pool_id      : _,
            bluefin_position_id  : _,
            owner                : _,
            tick_lower           : _,
            tick_upper           : _,
            registered_liquidity : _,
        } = arg3;
        0x2::object::delete(v18);
        f_rw75dmqnxw<T0>(v11, v17);
        f_rw75dmqnxw<T1>(v10, v17);
        (v15, arg6)
    }

    public fun f_h4bmhvschm<T0, T1, T2, T3, T4, T5>(arg0: &0x2::clock::Clock, arg1: &T_uwehzdz5ls, arg2: &T_bf2izpppac<T0, T1, T2, T3, T4, T5>, arg3: T_wfjjt3vuxw<T0, T1, T2>, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg6: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T4>, arg7: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg8: u128, arg9: u32, arg10: u32, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: &0x5d80bdec168ad1eda6ac9ad8c03155a26a02ddbf1c49c7ae504e07cecaaad7ef::m_nblxzh5qdb::T_5kldtuzgei, arg17: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, 0x2::balance::Balance<T2>, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, T_miprd2fdco<T0, T1, T2, T3, T4, T5>) {
        f_rrnc2jnqxd<T0, T1, T2, T3, T4, T5>(arg1, arg2, arg5, arg6, arg17);
        let v0 = 0x2::object::id<T_uwehzdz5ls>(arg1);
        let v1 = 0x2::object::id<T_bf2izpppac<T0, T1, T2, T3, T4, T5>>(arg2);
        let v2 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg5);
        let v3 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T4>>(arg6);
        let v4 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&arg7);
        assert!(arg3.registry_id == v0, 1);
        assert!(arg3.route_id == arg2.source_route_id, 3);
        assert!(arg3.bluefin_pool_id == v2, 4);
        assert!(arg3.bluefin_position_id == v4, 6);
        assert!(arg3.owner == arg2.owner, 5);
        assert!(arg3.tick_lower == arg9, 23);
        assert!(arg3.tick_upper == arg10, 23);
        f_5zu3to7gdh(arg3.tick_lower, arg3.tick_upper);
        let v5 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg5);
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gte(v5, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg3.tick_lower)) && 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v5, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg3.tick_upper)), 27);
        f_4j5hc5vnu5(&arg7, v2, arg3.tick_lower, arg3.tick_upper);
        let v6 = 0x2::object::id<T_wfjjt3vuxw<T0, T1, T2>>(&arg3);
        let v7 = arg3.tick_lower;
        let v8 = arg3.tick_upper;
        let v9 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(&arg7);
        assert!(v9 > 0, 8);
        assert!(arg3.registered_liquidity == v9, 24);
        assert!(arg3.registered_liquidity == arg8, 24);
        let v10 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, T1, T2>(arg0, arg4, arg5, &mut arg7);
        let v11 = 0x2::balance::value<T2>(&v10);
        let (v12, v13, v14, v15) = f_iksaeowejj<T0, T1>(arg0, arg4, arg5, arg7);
        let v16 = v15;
        let v17 = v14;
        let v18 = v13;
        let v19 = v12;
        let v20 = 0x2::balance::value<T0>(&v17);
        let v21 = 0x2::balance::value<T1>(&v16);
        let v22 = 0x2::balance::value<T0>(&v19);
        let v23 = 0x2::balance::value<T1>(&v18);
        assert!(v11 >= arg11, 9);
        assert!(v20 >= arg12, 9);
        assert!(v21 >= arg13, 9);
        assert!(v22 >= arg14, 10);
        assert!(v23 >= arg15, 11);
        let v24 = T_puatrxen6t{
            registry_id            : v0,
            route_id               : v1,
            source_route_id        : arg2.source_route_id,
            destination_route_id   : arg2.destination_route_id,
            source_pool_id         : v2,
            destination_pool_id    : v3,
            source_position_cap_id : v6,
            source_position_id     : v4,
            owner                  : arg2.owner,
            source_liquidity       : v9,
            source_tick_lower      : v7,
            source_tick_upper      : v8,
            reward_amount          : v11,
            fee_a                  : v20,
            fee_b                  : v21,
            source_principal_a     : v22,
            source_principal_b     : v23,
        };
        0x2::event::emit<T_puatrxen6t>(v24);
        let T_wfjjt3vuxw {
            id                   : v25,
            registry_id          : _,
            route_id             : _,
            bluefin_pool_id      : _,
            bluefin_position_id  : _,
            owner                : _,
            tick_lower           : _,
            tick_upper           : _,
            registered_liquidity : _,
        } = arg3;
        0x2::object::delete(v25);
        let v34 = T_miprd2fdco<T0, T1, T2, T3, T4, T5>{
            registry_id            : v0,
            route_id               : v1,
            source_route_id        : arg2.source_route_id,
            destination_route_id   : arg2.destination_route_id,
            source_pool_id         : v2,
            destination_pool_id    : v3,
            owner                  : arg2.owner,
            source_position_cap_id : v6,
            source_position_id     : v4,
            source_liquidity       : v9,
            source_tick_lower      : v7,
            source_tick_upper      : v8,
            reward_amount          : v11,
            fee_a                  : v20,
            fee_b                  : v21,
            source_principal_a     : v22,
            source_principal_b     : v23,
        };
        (v19, v18, v10, v17, v16, v34)
    }

    public fun f_hw346vgvpx<T0, T1>(arg0: &T_uwehzdz5ls, arg1: &T_2lormvfa3h, arg2: &T_lm5roak32v<T0, 0x2::sui::SUI, T0>, arg3: &T_lm5roak32v<0x2::sui::SUI, T1, 0x2::sui::SUI>, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, 0x2::sui::SUI>, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, T1>, arg6: &0x5d80bdec168ad1eda6ac9ad8c03155a26a02ddbf1c49c7ae504e07cecaaad7ef::m_nblxzh5qdb::T_5kldtuzgei, arg7: &mut 0x2::tx_context::TxContext) {
        f_oczdxmsgu2(0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, T1>>(arg5));
        assert!(arg2.tick_spacing == 1, 7);
        assert!(arg3.tick_spacing == 5, 7);
        f_33ffjhntca<T0, 0x2::sui::SUI, T0, 0x2::sui::SUI, T1, 0x2::sui::SUI>(arg0, arg1, arg2, arg3, arg4, arg5, 1, arg7);
    }

    fun f_iksaeowejj<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let v0 = &mut arg3;
        let (v1, v2) = f_cvq7wr2l2j<T0, T1>(arg0, arg1, arg2, v0);
        let v3 = v2;
        let v4 = v1;
        let (_, _, v7, v8) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::remove_liquidity<T0, T1>(arg1, arg2, &mut arg3, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(&arg3), arg0);
        let v9 = &mut arg3;
        let (v10, v11) = f_cvq7wr2l2j<T0, T1>(arg0, arg1, arg2, v9);
        0x2::balance::join<T0>(&mut v4, v10);
        0x2::balance::join<T1>(&mut v3, v11);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::close_position_v2<T0, T1>(arg0, arg1, arg2, arg3);
        (v7, v8, v4, v3)
    }

    public fun f_isex6xui7k<T0, T1, T2>(arg0: &T_uwehzdz5ls, arg1: &T_2lormvfa3h, arg2: &T_lm5roak32v<T0, T1, T2>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg5: u32, arg6: u32, arg7: u128, arg8: &0x5d80bdec168ad1eda6ac9ad8c03155a26a02ddbf1c49c7ae504e07cecaaad7ef::m_nblxzh5qdb::T_5kldtuzgei, arg9: &mut 0x2::tx_context::TxContext) {
        f_beqne4j46m(arg0, arg1);
        f_vusvmvjklx<T0, T1, T2>(arg0, arg2, arg3);
        f_5zu3to7gdh(arg5, arg6);
        let v0 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg3);
        f_4j5hc5vnu5(arg4, v0, arg5, arg6);
        let v1 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(arg4);
        assert!(v1 > 0 && v1 == arg7, 8);
        let v2 = T_wfjjt3vuxw<T0, T1, T2>{
            id                   : 0x2::object::new(arg9),
            registry_id          : 0x2::object::id<T_uwehzdz5ls>(arg0),
            route_id             : 0x2::object::id<T_lm5roak32v<T0, T1, T2>>(arg2),
            bluefin_pool_id      : v0,
            bluefin_position_id  : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(arg4),
            owner                : arg2.owner,
            tick_lower           : arg5,
            tick_upper           : arg6,
            registered_liquidity : v1,
        };
        let v3 = T_v5g66degtb{
            registry_id         : 0x2::object::id<T_uwehzdz5ls>(arg0),
            route_id            : 0x2::object::id<T_lm5roak32v<T0, T1, T2>>(arg2),
            position_cap_id     : 0x2::object::id<T_wfjjt3vuxw<T0, T1, T2>>(&v2),
            bluefin_pool_id     : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg3),
            bluefin_position_id : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(arg4),
            owner               : arg2.owner,
            tick_lower          : arg5,
            tick_upper          : arg6,
            liquidity           : v1,
        };
        0x2::event::emit<T_v5g66degtb>(v3);
        0x2::transfer::public_transfer<T_wfjjt3vuxw<T0, T1, T2>>(v2, arg2.owner);
    }

    public fun f_ju2doxmgzy<T0, T1, T2>(arg0: &T_uwehzdz5ls, arg1: &mut T_lm5roak32v<T0, T1, T2>, arg2: &T_7np4ziycu4<T0, T1, T2>, arg3: 0x2::balance::Balance<0x2::sui::SUI>, arg4: 0x2::balance::Balance<0x2::sui::SUI>, arg5: 0x2::balance::Balance<0x2::sui::SUI>, arg6: u64, arg7: &0x5d80bdec168ad1eda6ac9ad8c03155a26a02ddbf1c49c7ae504e07cecaaad7ef::m_nblxzh5qdb::T_5kldtuzgei, arg8: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, 0x2::balance::Balance<0x2::sui::SUI>, T_t6hkknofvj<T0, T1, T2>) {
        f_ceqrweoewv<T0, T1, T2>(arg0, arg1, arg8);
        assert!(arg2.registry_id == 0x2::object::id<T_uwehzdz5ls>(arg0), 1);
        assert!(arg2.route_id == 0x2::object::id<T_lm5roak32v<T0, T1, T2>>(arg1), 3);
        assert!(arg2.bluefin_pool_id == arg1.bluefin_pool_id, 4);
        assert!(arg2.owner == arg1.owner, 5);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg3);
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&arg4);
        let v2 = 0x2::balance::value<0x2::sui::SUI>(&arg5);
        let v3 = v0 + v1 + v2;
        assert!(0x5d80bdec168ad1eda6ac9ad8c03155a26a02ddbf1c49c7ae504e07cecaaad7ef::m_llkg4bq6ji::f_uctldn5vyl(arg2.reward_amount, arg2.fee_a, arg2.fee_b, v0, v1, v2, v3), 14);
        assert!(v3 >= arg6, 15);
        0x2::balance::join<0x2::sui::SUI>(&mut arg3, arg4);
        0x2::balance::join<0x2::sui::SUI>(&mut arg3, arg5);
        let (v4, v5, v6) = 0x5d80bdec168ad1eda6ac9ad8c03155a26a02ddbf1c49c7ae504e07cecaaad7ef::m_llkg4bq6ji::f_i3bdbiucyq(v3);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg3) == v5, 14);
        f_rw75dmqnxw<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg3, v4), arg0.profit_recipient);
        let v7 = 0x2::balance::value<T0>(&arg1.retained_a);
        let v8 = 0x2::balance::value<T1>(&arg1.retained_b);
        let v9 = 0x2::balance::value<0x2::sui::SUI>(&arg1.retained_sui);
        0x2::balance::join<0x2::sui::SUI>(&mut arg3, 0x2::balance::split<0x2::sui::SUI>(&mut arg1.retained_sui, v9));
        arg1.cumulative_gross_income = arg1.cumulative_gross_income + (v3 as u128);
        arg1.cumulative_payout = arg1.cumulative_payout + (v4 as u128);
        arg1.cumulative_retained = arg1.cumulative_retained + (v5 as u128);
        let v10 = T_t6hkknofvj<T0, T1, T2>{
            registry_id             : 0x2::object::id<T_uwehzdz5ls>(arg0),
            route_id                : 0x2::object::id<T_lm5roak32v<T0, T1, T2>>(arg1),
            source_position_id      : arg2.source_position_id,
            profit_recipient        : arg0.profit_recipient,
            reward_as_sui           : v0,
            fee_a_as_sui            : v1,
            fee_b_as_sui            : v2,
            gross_income_sui        : v3,
            payout_sui              : v4,
            newly_retained_sui      : v5,
            rounding_to_recipient   : v6,
            prior_retained_a        : v7,
            prior_retained_b        : v8,
            prior_retained_sui      : v9,
            cumulative_gross_income : arg1.cumulative_gross_income,
            cumulative_payout       : arg1.cumulative_payout,
            cumulative_retained     : arg1.cumulative_retained,
        };
        let v11 = T_5ffpvfebjh{
            registry_id        : 0x2::object::id<T_uwehzdz5ls>(arg0),
            route_id           : 0x2::object::id<T_lm5roak32v<T0, T1, T2>>(arg1),
            source_position_id : arg2.source_position_id,
            owner              : arg1.owner,
            income             : f_ymim6m3jkl<T0, T1, T2>(&v10),
        };
        0x2::event::emit<T_5ffpvfebjh>(v11);
        (0x2::balance::split<T0>(&mut arg1.retained_a, v7), 0x2::balance::split<T1>(&mut arg1.retained_b, v8), arg3, v10)
    }

    public fun f_kbbilkbbro<T0, T1>(arg0: &T_uwehzdz5ls, arg1: &T_2lormvfa3h, arg2: &T_lm5roak32v<0x2::sui::SUI, T1, 0x2::sui::SUI>, arg3: &T_lm5roak32v<T0, 0x2::sui::SUI, T0>, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, T1>, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, 0x2::sui::SUI>, arg6: &0x5d80bdec168ad1eda6ac9ad8c03155a26a02ddbf1c49c7ae504e07cecaaad7ef::m_nblxzh5qdb::T_5kldtuzgei, arg7: &mut 0x2::tx_context::TxContext) {
        f_oczdxmsgu2(0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, T1>>(arg4));
        assert!(arg2.tick_spacing == 5, 7);
        assert!(arg3.tick_spacing == 1, 7);
        f_33ffjhntca<0x2::sui::SUI, T1, 0x2::sui::SUI, T0, 0x2::sui::SUI, T0>(arg0, arg1, arg2, arg3, arg4, arg5, 1, arg7);
    }

    public fun f_lcimvpmsaa<T0, T1, T2>(arg0: &T_uwehzdz5ls, arg1: &T_lm5roak32v<T0, T1, T2>, arg2: T_7np4ziycu4<T0, T1, T2>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: &0x5d80bdec168ad1eda6ac9ad8c03155a26a02ddbf1c49c7ae504e07cecaaad7ef::m_nblxzh5qdb::T_5kldtuzgei, arg5: &0x2::tx_context::TxContext) : T_7np4ziycu4<T0, T1, T2> {
        f_3nce72pqt2<T0, T1, T2>(arg0, arg1, arg3, arg5);
        f_4p4lmvcra2<T0, T1, T2>(arg0, arg1, &arg2, arg3);
        assert!(!arg2.oor_asserted, 13);
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg3);
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v0, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg2.source_tick_lower)) || 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gte(v0, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg2.source_tick_upper)), 12);
        arg2.oor_asserted = true;
        let v1 = T_nggah7yxb5{
            registry_id        : arg2.registry_id,
            route_id           : arg2.route_id,
            source_position_id : arg2.source_position_id,
            current_tick       : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v0),
            source_tick_lower  : arg2.source_tick_lower,
            source_tick_upper  : arg2.source_tick_upper,
        };
        0x2::event::emit<T_nggah7yxb5>(v1);
        arg2
    }

    fun f_lrfk6ltbkc(arg0: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg1: u32, arg2: u32, arg3: u32) : (u32, u32) {
        f_ny4krmjt6j(arg2);
        assert!(0x5d80bdec168ad1eda6ac9ad8c03155a26a02ddbf1c49c7ae504e07cecaaad7ef::m_llkg4bq6ji::f_56twi7c5r3(arg3), 7);
        assert!(arg1 == arg2 * arg3, 7);
        let v0 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(arg2);
        let v1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::mul(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::div(arg0, v0), v0);
        let v2 = v1;
        if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::is_neg(arg0) && !0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::eq(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::mod(arg0, v0), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::zero())) {
            v2 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(v1, v0);
        };
        let v3 = if (arg3 == 2) {
            1
        } else {
            (arg3 - 1) / 2
        };
        let v4 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(v2, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(v3 * arg2));
        let v5 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(v4, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(arg1));
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gte(arg0, v4) && 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(arg0, v5), 7);
        (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v4), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v5))
    }

    public fun f_ltcht5m4s3<T0, T1, T2, T3, T4, T5>(arg0: &T_uwehzdz5ls, arg1: &mut T_bf2izpppac<T0, T1, T2, T3, T4, T5>, arg2: &T_miprd2fdco<T0, T1, T2, T3, T4, T5>, arg3: 0x2::balance::Balance<0x2::sui::SUI>, arg4: 0x2::balance::Balance<0x2::sui::SUI>, arg5: 0x2::balance::Balance<0x2::sui::SUI>, arg6: u64, arg7: &0x5d80bdec168ad1eda6ac9ad8c03155a26a02ddbf1c49c7ae504e07cecaaad7ef::m_nblxzh5qdb::T_5kldtuzgei, arg8: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T3>, 0x2::balance::Balance<T4>, 0x2::balance::Balance<0x2::sui::SUI>, T_5rxyyb35j4<T0, T1, T2, T3, T4, T5>) {
        f_ad3j2evozt<T0, T1, T2, T3, T4, T5>(arg0, arg1, arg8);
        assert!(arg2.registry_id == 0x2::object::id<T_uwehzdz5ls>(arg0), 1);
        assert!(arg2.route_id == 0x2::object::id<T_bf2izpppac<T0, T1, T2, T3, T4, T5>>(arg1), 3);
        assert!(arg2.source_route_id == arg1.source_route_id, 3);
        assert!(arg2.destination_route_id == arg1.destination_route_id, 28);
        assert!(arg2.source_pool_id == arg1.source_pool_id, 4);
        assert!(arg2.destination_pool_id == arg1.destination_pool_id, 28);
        assert!(arg2.owner == arg1.owner, 5);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg3);
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&arg4);
        let v2 = 0x2::balance::value<0x2::sui::SUI>(&arg5);
        let v3 = v0 + v1 + v2;
        assert!(0x5d80bdec168ad1eda6ac9ad8c03155a26a02ddbf1c49c7ae504e07cecaaad7ef::m_llkg4bq6ji::f_uctldn5vyl(arg2.reward_amount, arg2.fee_a, arg2.fee_b, v0, v1, v2, v3), 14);
        assert!(v3 >= arg6, 15);
        0x2::balance::join<0x2::sui::SUI>(&mut arg3, arg4);
        0x2::balance::join<0x2::sui::SUI>(&mut arg3, arg5);
        let (v4, v5, v6) = 0x5d80bdec168ad1eda6ac9ad8c03155a26a02ddbf1c49c7ae504e07cecaaad7ef::m_llkg4bq6ji::f_i3bdbiucyq(v3);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg3) == v5, 14);
        f_rw75dmqnxw<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg3, v4), arg0.profit_recipient);
        let v7 = 0x2::balance::value<T3>(&arg1.retained_destination_a);
        let v8 = 0x2::balance::value<T4>(&arg1.retained_destination_b);
        let v9 = 0x2::balance::value<0x2::sui::SUI>(&arg1.retained_sui);
        0x2::balance::join<0x2::sui::SUI>(&mut arg3, 0x2::balance::split<0x2::sui::SUI>(&mut arg1.retained_sui, v9));
        arg1.cumulative_gross_income = arg1.cumulative_gross_income + (v3 as u128);
        arg1.cumulative_payout = arg1.cumulative_payout + (v4 as u128);
        arg1.cumulative_retained = arg1.cumulative_retained + (v5 as u128);
        let v10 = T_5rxyyb35j4<T0, T1, T2, T3, T4, T5>{
            registry_id                  : 0x2::object::id<T_uwehzdz5ls>(arg0),
            route_id                     : 0x2::object::id<T_bf2izpppac<T0, T1, T2, T3, T4, T5>>(arg1),
            source_position_id           : arg2.source_position_id,
            profit_recipient             : arg0.profit_recipient,
            reward_as_sui                : v0,
            fee_a_as_sui                 : v1,
            fee_b_as_sui                 : v2,
            gross_income_sui             : v3,
            payout_sui                   : v4,
            newly_retained_sui           : v5,
            rounding_to_recipient        : v6,
            prior_retained_destination_a : v7,
            prior_retained_destination_b : v8,
            prior_retained_sui           : v9,
            cumulative_gross_income      : arg1.cumulative_gross_income,
            cumulative_payout            : arg1.cumulative_payout,
            cumulative_retained          : arg1.cumulative_retained,
        };
        let v11 = T_dvgwutblvu{
            registry_id        : 0x2::object::id<T_uwehzdz5ls>(arg0),
            route_id           : 0x2::object::id<T_bf2izpppac<T0, T1, T2, T3, T4, T5>>(arg1),
            source_position_id : arg2.source_position_id,
            owner              : arg1.owner,
            income             : f_2d2t32f2sz<T0, T1, T2, T3, T4, T5>(&v10),
        };
        0x2::event::emit<T_dvgwutblvu>(v11);
        (0x2::balance::split<T3>(&mut arg1.retained_destination_a, v7), 0x2::balance::split<T4>(&mut arg1.retained_destination_b, v8), arg3, v10)
    }

    fun f_lwe6y6ookt<T0, T1, T2>(arg0: &T_uwehzdz5ls, arg1: &T_lm5roak32v<T0, T1, T2>, arg2: &T_7np4ziycu4<T0, T1, T2>, arg3: &T_t6hkknofvj<T0, T1, T2>) {
        assert!(arg3.registry_id == 0x2::object::id<T_uwehzdz5ls>(arg0), 1);
        assert!(arg3.route_id == 0x2::object::id<T_lm5roak32v<T0, T1, T2>>(arg1), 3);
        assert!(arg3.source_position_id == arg2.source_position_id, 6);
        assert!(arg3.profit_recipient == arg0.profit_recipient, 2);
        assert!(0x5d80bdec168ad1eda6ac9ad8c03155a26a02ddbf1c49c7ae504e07cecaaad7ef::m_llkg4bq6ji::f_uctldn5vyl(arg2.reward_amount, arg2.fee_a, arg2.fee_b, arg3.reward_as_sui, arg3.fee_a_as_sui, arg3.fee_b_as_sui, arg3.gross_income_sui), 14);
        let (v0, v1, v2) = 0x5d80bdec168ad1eda6ac9ad8c03155a26a02ddbf1c49c7ae504e07cecaaad7ef::m_llkg4bq6ji::f_i3bdbiucyq(arg3.gross_income_sui);
        assert!(arg3.payout_sui == v0, 14);
        assert!(arg3.newly_retained_sui == v1, 14);
        assert!(arg3.rounding_to_recipient == v2, 14);
        assert!(arg1.cumulative_gross_income == arg3.cumulative_gross_income, 14);
        assert!(arg1.cumulative_payout == arg3.cumulative_payout, 14);
        assert!(arg1.cumulative_retained == arg3.cumulative_retained, 14);
    }

    fun f_maba7bksjq(arg0: u64, arg1: u64, arg2: u64) {
        if (arg0 == 0) {
            assert!(arg1 == 0 && arg2 == 0, 14);
        } else {
            assert!(arg1 > 0 && arg1 >= arg2, 15);
        };
    }

    public(friend) fun f_neigviqr7p<T0, T1, T2>(arg0: &T_uwehzdz5ls, arg1: &T_2lormvfa3h, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: u32, arg4: bool, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        f_beqne4j46m(arg0, arg1);
        assert!(arg5 != @0x0, 5);
        f_ny4krmjt6j(arg3);
        let v0 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg2);
        let v1 = T_lm5roak32v<T0, T1, T2>{
            id                      : 0x2::object::new(arg6),
            registry_id             : 0x2::object::id<T_uwehzdz5ls>(arg0),
            bluefin_pool_id         : v0,
            owner                   : arg5,
            tick_spacing            : arg3,
            income_policy_version   : 1,
            retained_a              : 0x2::balance::zero<T0>(),
            retained_b              : 0x2::balance::zero<T1>(),
            retained_sui            : 0x2::balance::zero<0x2::sui::SUI>(),
            cumulative_gross_income : 0,
            cumulative_payout       : 0,
            cumulative_retained     : 0,
        };
        let v2 = T_pu6vodzgzx{
            registry_id           : 0x2::object::id<T_uwehzdz5ls>(arg0),
            route_id              : 0x2::object::id<T_lm5roak32v<T0, T1, T2>>(&v1),
            bluefin_pool_id       : v0,
            owner                 : arg5,
            tick_spacing          : arg3,
            income_policy_version : 1,
            reward_is_sui         : arg4,
        };
        0x2::event::emit<T_pu6vodzgzx>(v2);
        0x2::transfer::public_transfer<T_lm5roak32v<T0, T1, T2>>(v1, arg5);
    }

    fun f_ntf62xvxkn<T0, T1, T2, T3, T4, T5>(arg0: &T_uwehzdz5ls, arg1: &T_bf2izpppac<T0, T1, T2, T3, T4, T5>, arg2: &T_miprd2fdco<T0, T1, T2, T3, T4, T5>, arg3: &T_5rxyyb35j4<T0, T1, T2, T3, T4, T5>) {
        assert!(arg3.registry_id == 0x2::object::id<T_uwehzdz5ls>(arg0), 1);
        assert!(arg3.route_id == 0x2::object::id<T_bf2izpppac<T0, T1, T2, T3, T4, T5>>(arg1), 3);
        assert!(arg3.source_position_id == arg2.source_position_id, 6);
        assert!(arg3.profit_recipient == arg0.profit_recipient, 2);
        assert!(0x5d80bdec168ad1eda6ac9ad8c03155a26a02ddbf1c49c7ae504e07cecaaad7ef::m_llkg4bq6ji::f_uctldn5vyl(arg2.reward_amount, arg2.fee_a, arg2.fee_b, arg3.reward_as_sui, arg3.fee_a_as_sui, arg3.fee_b_as_sui, arg3.gross_income_sui), 14);
        let (v0, v1, v2) = 0x5d80bdec168ad1eda6ac9ad8c03155a26a02ddbf1c49c7ae504e07cecaaad7ef::m_llkg4bq6ji::f_i3bdbiucyq(arg3.gross_income_sui);
        assert!(arg3.payout_sui == v0, 14);
        assert!(arg3.newly_retained_sui == v1, 14);
        assert!(arg3.rounding_to_recipient == v2, 14);
        assert!(arg1.cumulative_gross_income == arg3.cumulative_gross_income, 14);
        assert!(arg1.cumulative_payout == arg3.cumulative_payout, 14);
        assert!(arg1.cumulative_retained == arg3.cumulative_retained, 14);
    }

    fun f_ny4krmjt6j(arg0: u32) {
        assert!(arg0 > 0 && arg0 <= 1000000, 7);
    }

    fun f_oczdxmsgu2(arg0: 0x2::object::ID) {
        assert!(arg0 == 0x2::object::id_from_address(@0xa0153768c7ed857ffd8bad4708da873fb7825a6878e5f4c83f5df4c091933e56), 4);
    }

    public fun f_pjluajrjx3<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &T_uwehzdz5ls, arg2: &mut T_lm5roak32v<T0, T1, T2>, arg3: T_7np4ziycu4<T0, T1, T2>, arg4: T_t6hkknofvj<T0, T1, T2>, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg7: 0x2::balance::Balance<T0>, arg8: 0x2::balance::Balance<T1>, arg9: 0x2::balance::Balance<T0>, arg10: 0x2::balance::Balance<T1>, arg11: 0x2::balance::Balance<0x2::sui::SUI>, arg12: u8, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: u64, arg19: u32, arg20: u64, arg21: bool, arg22: u64, arg23: u64, arg24: u64, arg25: u64, arg26: u64, arg27: bool, arg28: u64, arg29: u64, arg30: u64, arg31: u64, arg32: &0x5d80bdec168ad1eda6ac9ad8c03155a26a02ddbf1c49c7ae504e07cecaaad7ef::m_nblxzh5qdb::T_5kldtuzgei, arg33: &mut 0x2::tx_context::TxContext) {
        f_3nce72pqt2<T0, T1, T2>(arg1, arg2, arg6, arg33);
        f_4p4lmvcra2<T0, T1, T2>(arg1, arg2, &arg3, arg6);
        assert!(arg3.oor_asserted, 13);
        f_lwe6y6ookt<T0, T1, T2>(arg1, arg2, &arg3, &arg4);
        assert!(0x2::balance::value<T0>(&arg2.retained_a) == 0, 14);
        assert!(0x2::balance::value<T1>(&arg2.retained_b) == 0, 14);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg2.retained_sui) == 0, 14);
        let v0 = 0x2::balance::value<T0>(&arg7);
        let v1 = 0x2::balance::value<T1>(&arg8);
        let v2 = f_5riqzgtrzy(arg3.source_principal_a, arg3.source_principal_b, v0, v1, arg12, arg13);
        assert!(0x5d80bdec168ad1eda6ac9ad8c03155a26a02ddbf1c49c7ae504e07cecaaad7ef::m_llkg4bq6ji::f_dzy5yr2xgt(arg3.source_principal_a, arg3.source_principal_b, v0, v1, arg12, arg13, v2), 14);
        assert!(v2 >= arg14, 15);
        let v3 = 0x2::balance::value<T0>(&arg9);
        let v4 = 0x2::balance::value<T1>(&arg10);
        let v5 = 0x2::balance::value<0x2::sui::SUI>(&arg11);
        assert!(v3 >= arg4.prior_retained_a, 14);
        assert!(v4 >= arg4.prior_retained_b, 14);
        let v6 = v3 - arg4.prior_retained_a;
        let v7 = v4 - arg4.prior_retained_b;
        f_maba7bksjq(arg15, v6, arg16);
        f_maba7bksjq(arg17, v7, arg18);
        assert!(0x5d80bdec168ad1eda6ac9ad8c03155a26a02ddbf1c49c7ae504e07cecaaad7ef::m_llkg4bq6ji::f_4alod2uun2(arg4.prior_retained_a, arg4.prior_retained_b, arg4.prior_retained_sui, arg4.newly_retained_sui, v3, v4, v5, arg15, v6, arg17, v7), 14);
        let (v8, v9) = f_lrfk6ltbkc(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg6), 0x5d80bdec168ad1eda6ac9ad8c03155a26a02ddbf1c49c7ae504e07cecaaad7ef::m_llkg4bq6ji::f_r5njkme6mj(arg2.tick_spacing, arg19), arg2.tick_spacing, arg19);
        let v10 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::open_position<T0, T1>(arg5, arg6, v8, v9, arg33);
        let v11 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&v10);
        assert!(arg20 > 0, 20);
        let (v12, v13, v14, v15) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::add_liquidity_with_fixed_amount<T0, T1>(arg0, arg5, arg6, &mut v10, arg7, arg8, arg20, arg21);
        let v16 = v15;
        let v17 = v14;
        let v18 = 0x2::balance::value<T0>(&v17);
        let v19 = 0x2::balance::value<T1>(&v16);
        assert!(v12 + v18 == v0, 14);
        assert!(v13 + v19 == v1, 14);
        assert!(v12 >= arg22, 16);
        assert!(v13 >= arg23, 17);
        assert!(v18 <= arg24, 18);
        assert!(v19 <= arg25, 19);
        let (v20, v21, v22, v23) = if (v3 == 0 && v4 == 0) {
            assert!(arg26 == 0, 20);
            assert!(arg28 == 0, 16);
            assert!(arg29 == 0, 17);
            (0, 0, arg9, arg10)
        } else {
            assert!(arg26 > 0, 20);
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::add_liquidity_with_fixed_amount<T0, T1>(arg0, arg5, arg6, &mut v10, arg9, arg10, arg26, arg27)
        };
        let v24 = v23;
        let v25 = v22;
        let v26 = 0x2::balance::value<T0>(&v25);
        let v27 = 0x2::balance::value<T1>(&v24);
        assert!(v20 + v26 == v3, 14);
        assert!(v21 + v27 == v4, 14);
        assert!(v20 >= arg28, 16);
        assert!(v21 >= arg29, 17);
        assert!(v26 <= arg30, 18);
        assert!(v27 <= arg31, 19);
        0x2::balance::join<T0>(&mut arg2.retained_a, v25);
        0x2::balance::join<T1>(&mut arg2.retained_b, v24);
        0x2::balance::join<0x2::sui::SUI>(&mut arg2.retained_sui, arg11);
        let v28 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(&v10);
        assert!(v28 > 0, 8);
        f_4j5hc5vnu5(&v10, 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg6), v8, v9);
        let v29 = T_wfjjt3vuxw<T0, T1, T2>{
            id                   : 0x2::object::new(arg33),
            registry_id          : 0x2::object::id<T_uwehzdz5ls>(arg1),
            route_id             : 0x2::object::id<T_lm5roak32v<T0, T1, T2>>(arg2),
            bluefin_pool_id      : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg6),
            bluefin_position_id  : v11,
            owner                : arg2.owner,
            tick_lower           : v8,
            tick_upper           : v9,
            registered_liquidity : v28,
        };
        let v30 = T_o6pwuxoeop{
            before_a            : arg3.source_principal_a,
            before_b            : arg3.source_principal_b,
            rebalance_direction : arg12,
            rebalance_input     : arg13,
            rebalance_output    : v2,
            available_a         : v0,
            available_b         : v1,
            deposited_a         : v12,
            deposited_b         : v13,
            residual_a          : v18,
            residual_b          : v19,
        };
        let v31 = T_wol2enxndn{
            sui_to_a_input  : arg15,
            sui_to_a_output : v6,
            sui_to_b_input  : arg17,
            sui_to_b_output : v7,
            available_a     : v3,
            available_b     : v4,
            available_sui   : v5,
            deposited_a     : v20,
            deposited_b     : v21,
            residual_a      : v26,
            residual_b      : v27,
            residual_sui    : v5,
        };
        let v32 = T_s75dbg5plt{
            registry_id                 : 0x2::object::id<T_uwehzdz5ls>(arg1),
            route_id                    : 0x2::object::id<T_lm5roak32v<T0, T1, T2>>(arg2),
            source_position_cap_id      : arg3.source_position_cap_id,
            replacement_position_cap_id : 0x2::object::id<T_wfjjt3vuxw<T0, T1, T2>>(&v29),
            bluefin_pool_id             : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg6),
            source_position_id          : arg3.source_position_id,
            replacement_position_id     : v11,
            owner                       : arg2.owner,
            source_liquidity            : arg3.source_liquidity,
            replacement_liquidity       : v28,
            source_tick_lower           : arg3.source_tick_lower,
            source_tick_upper           : arg3.source_tick_upper,
            target_tick_lower           : v8,
            target_tick_upper           : v9,
            tick_spacing                : arg2.tick_spacing,
            width_intervals             : arg19,
            income                      : f_ymim6m3jkl<T0, T1, T2>(&arg4),
            principal                   : v30,
            retained                    : v31,
        };
        0x2::event::emit<T_s75dbg5plt>(v32);
        let T_7np4ziycu4 {
            registry_id            : _,
            route_id               : _,
            bluefin_pool_id        : _,
            owner                  : _,
            source_position_cap_id : _,
            source_position_id     : _,
            source_liquidity       : _,
            source_tick_lower      : _,
            source_tick_upper      : _,
            reward_amount          : _,
            fee_a                  : _,
            fee_b                  : _,
            source_principal_a     : _,
            source_principal_b     : _,
            oor_asserted           : _,
        } = arg3;
        let T_t6hkknofvj {
            registry_id             : _,
            route_id                : _,
            source_position_id      : _,
            profit_recipient        : _,
            reward_as_sui           : _,
            fee_a_as_sui            : _,
            fee_b_as_sui            : _,
            gross_income_sui        : _,
            payout_sui              : _,
            newly_retained_sui      : _,
            rounding_to_recipient   : _,
            prior_retained_a        : _,
            prior_retained_b        : _,
            prior_retained_sui      : _,
            cumulative_gross_income : _,
            cumulative_payout       : _,
            cumulative_retained     : _,
        } = arg4;
        0x2::transfer::public_transfer<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v10, arg2.owner);
        0x2::transfer::public_transfer<T_wfjjt3vuxw<T0, T1, T2>>(v29, arg2.owner);
        f_rw75dmqnxw<T0>(v17, arg2.owner);
        f_rw75dmqnxw<T1>(v16, arg2.owner);
    }

    public fun f_rpopvrkrgy<T0>(arg0: &T_uwehzdz5ls, arg1: &T_2lormvfa3h, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, T0>, arg3: address, arg4: &0x5d80bdec168ad1eda6ac9ad8c03155a26a02ddbf1c49c7ae504e07cecaaad7ef::m_nblxzh5qdb::T_5kldtuzgei, arg5: &mut 0x2::tx_context::TxContext) {
        f_oczdxmsgu2(0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, T0>>(arg2));
        f_neigviqr7p<0x2::sui::SUI, T0, 0x2::sui::SUI>(arg0, arg1, arg2, 5, true, arg3, arg5);
    }

    fun f_rrnc2jnqxd<T0, T1, T2, T3, T4, T5>(arg0: &T_uwehzdz5ls, arg1: &T_bf2izpppac<T0, T1, T2, T3, T4, T5>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T4>, arg4: &0x2::tx_context::TxContext) {
        f_2rakbhkpwv<T0, T1, T2, T3, T4, T5>(arg0, arg1, arg2);
        assert!(arg1.destination_pool_id == 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T4>>(arg3), 28);
        assert!(arg1.owner == 0x2::tx_context::sender(arg4), 5);
    }

    fun f_rw75dmqnxw<T0>(arg0: 0x2::balance::Balance<T0>, arg1: address) {
        if (0x2::balance::value<T0>(&arg0) > 0) {
            0x2::balance::send_funds<T0>(arg0, arg1);
        } else {
            0x2::balance::destroy_zero<T0>(arg0);
        };
    }

    public fun f_vfcc4bt7uf<T0, T1, T2>(arg0: &T_uwehzdz5ls, arg1: &mut T_lm5roak32v<T0, T1, T2>, arg2: &0x5d80bdec168ad1eda6ac9ad8c03155a26a02ddbf1c49c7ae504e07cecaaad7ef::m_nblxzh5qdb::T_5kldtuzgei, arg3: &mut 0x2::tx_context::TxContext) {
        f_ceqrweoewv<T0, T1, T2>(arg0, arg1, arg3);
        let v0 = 0x2::balance::value<T0>(&arg1.retained_a);
        let v1 = 0x2::balance::value<T1>(&arg1.retained_b);
        let v2 = 0x2::balance::value<0x2::sui::SUI>(&arg1.retained_sui);
        let v3 = T_nq5etekvgh{
            registry_id             : 0x2::object::id<T_uwehzdz5ls>(arg0),
            route_id                : 0x2::object::id<T_lm5roak32v<T0, T1, T2>>(arg1),
            owner                   : arg1.owner,
            amount_a                : v0,
            amount_b                : v1,
            amount_sui              : v2,
            live_position_untouched : true,
        };
        0x2::event::emit<T_nq5etekvgh>(v3);
        f_rw75dmqnxw<T0>(0x2::balance::split<T0>(&mut arg1.retained_a, v0), arg1.owner);
        f_rw75dmqnxw<T1>(0x2::balance::split<T1>(&mut arg1.retained_b, v1), arg1.owner);
        f_rw75dmqnxw<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.retained_sui, v2), arg1.owner);
    }

    fun f_vnfimunank<T0, T1, T2, T3, T4, T5>(arg0: &T_uwehzdz5ls, arg1: &T_bf2izpppac<T0, T1, T2, T3, T4, T5>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T4>, arg3: &0x2::tx_context::TxContext) {
        f_ad3j2evozt<T0, T1, T2, T3, T4, T5>(arg0, arg1, arg3);
        assert!(arg1.destination_pool_id == 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T4>>(arg2), 28);
    }

    fun f_vusvmvjklx<T0, T1, T2>(arg0: &T_uwehzdz5ls, arg1: &T_lm5roak32v<T0, T1, T2>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>) {
        f_3xczhy5i35(arg0);
        assert!(arg1.registry_id == 0x2::object::id<T_uwehzdz5ls>(arg0), 1);
        assert!(arg1.bluefin_pool_id == 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg2), 4);
        assert!(arg1.owner != @0x0, 5);
        f_ny4krmjt6j(arg1.tick_spacing);
        assert!(arg1.income_policy_version == 1, 21);
    }

    fun f_w5bzbijaxt<T0, T1, T2, T3, T4, T5>(arg0: &T_uwehzdz5ls, arg1: &T_lm5roak32v<T0, T1, T2>, arg2: &T_lm5roak32v<T3, T4, T5>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T4>) {
        f_3xczhy5i35(arg0);
        let v0 = 0x2::object::id<T_uwehzdz5ls>(arg0);
        let v1 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg3);
        let v2 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T4>>(arg4);
        assert!(arg1.registry_id == v0, 1);
        assert!(arg2.registry_id == v0, 1);
        assert!(arg1.bluefin_pool_id == v1, 4);
        assert!(arg2.bluefin_pool_id == v2, 28);
        assert!(v1 != v2, 25);
        assert!(arg1.owner != @0x0, 5);
        assert!(arg1.owner == arg2.owner, 5);
        f_ny4krmjt6j(arg1.tick_spacing);
        f_ny4krmjt6j(arg2.tick_spacing);
        assert!(arg1.income_policy_version == 1, 21);
        assert!(arg2.income_policy_version == 1, 21);
    }

    fun f_ymim6m3jkl<T0, T1, T2>(arg0: &T_t6hkknofvj<T0, T1, T2>) : T_47j7hh4zol {
        T_47j7hh4zol{
            profit_recipient        : arg0.profit_recipient,
            reward_as_sui           : arg0.reward_as_sui,
            fee_a_as_sui            : arg0.fee_a_as_sui,
            fee_b_as_sui            : arg0.fee_b_as_sui,
            gross_income_sui        : arg0.gross_income_sui,
            payout_sui              : arg0.payout_sui,
            newly_retained_sui      : arg0.newly_retained_sui,
            rounding_to_recipient   : arg0.rounding_to_recipient,
            prior_retained_a        : arg0.prior_retained_a,
            prior_retained_b        : arg0.prior_retained_b,
            prior_retained_sui      : arg0.prior_retained_sui,
            cumulative_gross_income : arg0.cumulative_gross_income,
            cumulative_payout       : arg0.cumulative_payout,
            cumulative_retained     : arg0.cumulative_retained,
        }
    }

    public fun f_zj7nd7qitf<T0>(arg0: &T_uwehzdz5ls, arg1: &T_2lormvfa3h, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, 0x2::sui::SUI>, arg3: address, arg4: &0x5d80bdec168ad1eda6ac9ad8c03155a26a02ddbf1c49c7ae504e07cecaaad7ef::m_nblxzh5qdb::T_5kldtuzgei, arg5: &mut 0x2::tx_context::TxContext) {
        f_neigviqr7p<T0, 0x2::sui::SUI, T0>(arg0, arg1, arg2, 1, false, arg3, arg5);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg0);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = T_2lormvfa3h{
            id          : 0x2::object::new(arg0),
            registry_id : v1,
        };
        let v3 = 0x2::object::id<T_2lormvfa3h>(&v2);
        let v4 = T_uwehzdz5ls{
            id               : v0,
            admin_cap_id     : v3,
            profit_recipient : @0xa10aecd2e9e45698e8c36ccaf3c4ea51cdda87f3c098a71d1e77be3351000498,
        };
        let v5 = T_f32dxuihah{
            registry_id      : v1,
            admin_cap_id     : v3,
            profit_recipient : @0xa10aecd2e9e45698e8c36ccaf3c4ea51cdda87f3c098a71d1e77be3351000498,
        };
        0x2::event::emit<T_f32dxuihah>(v5);
        0x2::transfer::public_transfer<T_2lormvfa3h>(v2, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<T_uwehzdz5ls>(v4);
    }

    // decompiled from Move bytecode v7
}

