module 0x4561b692f87e7ab5d424ec4d7f98a747b25cf398a48905c32d6941d653978b52::m_bvk3aksumo {
    struct T_f4fxi74vru has key {
        id: 0x2::object::UID,
        admin_cap_id: 0x2::object::ID,
        profit_recipient: address,
    }

    struct T_gkfgpktxye has store, key {
        id: 0x2::object::UID,
        registry_id: 0x2::object::ID,
    }

    struct T_ppwyv4yz6r<phantom T0, phantom T1, phantom T2> has store, key {
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

    struct T_2ce6tg7ly2<phantom T0, phantom T1, phantom T2> has store, key {
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

    struct T_x4cp5fnodv<phantom T0, phantom T1, phantom T2> {
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

    struct T_j7pyfvqapg<phantom T0, phantom T1, phantom T2> {
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

    struct T_fyj4ycmscu has copy, drop {
        registry_id: 0x2::object::ID,
        admin_cap_id: 0x2::object::ID,
        profit_recipient: address,
    }

    struct T_uhtbzmlf4y has copy, drop {
        registry_id: 0x2::object::ID,
        route_id: 0x2::object::ID,
        bluefin_pool_id: 0x2::object::ID,
        owner: address,
        tick_spacing: u32,
        income_policy_version: u8,
        reward_is_sui: bool,
    }

    struct T_wvxbxlhdbw has copy, drop {
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

    struct T_iz5cyvrq53 has copy, drop {
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

    struct T_4v2iqhpkoz has copy, drop {
        registry_id: 0x2::object::ID,
        route_id: 0x2::object::ID,
        source_position_id: 0x2::object::ID,
        current_tick: u32,
        source_tick_lower: u32,
        source_tick_upper: u32,
    }

    struct T_qw7fcx5qn5 has copy, drop {
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

    struct T_bxqkkmxtpx has copy, drop {
        registry_id: 0x2::object::ID,
        route_id: 0x2::object::ID,
        source_position_id: 0x2::object::ID,
        owner: address,
        income: T_qw7fcx5qn5,
    }

    struct T_o7tscqpl5y has copy, drop {
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

    struct T_nxqtjh3oyk has copy, drop {
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

    struct T_agjcodya3k has copy, drop {
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
        income: T_qw7fcx5qn5,
        principal: T_o7tscqpl5y,
        retained: T_nxqtjh3oyk,
    }

    struct T_ggcwd6qqo5 has copy, drop {
        registry_id: 0x2::object::ID,
        route_id: 0x2::object::ID,
        owner: address,
        amount_a: u64,
        amount_b: u64,
        amount_sui: u64,
        live_position_untouched: bool,
    }

    public fun f_2h7k547x6n<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &T_f4fxi74vru, arg2: &T_ppwyv4yz6r<T0, T1, T2>, arg3: T_2ce6tg7ly2<T0, T1, T2>, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg6: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg7: u128, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: &0x4561b692f87e7ab5d424ec4d7f98a747b25cf398a48905c32d6941d653978b52::m_6dckzdjzpg::T_a7d4rfuwsp, arg14: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, 0x2::balance::Balance<T2>, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, T_x4cp5fnodv<T0, T1, T2>) {
        f_wbodiqlump<T0, T1, T2>(arg1, arg2, arg5, arg14);
        let v0 = 0x2::object::id<T_f4fxi74vru>(arg1);
        let v1 = 0x2::object::id<T_ppwyv4yz6r<T0, T1, T2>>(arg2);
        let v2 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg5);
        let v3 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&arg6);
        assert!(arg3.registry_id == v0, 1);
        assert!(arg3.route_id == v1, 3);
        assert!(arg3.bluefin_pool_id == v2, 4);
        assert!(arg3.bluefin_position_id == v3, 6);
        assert!(arg3.owner == arg2.owner, 5);
        f_biaffj32om(arg3.tick_lower, arg3.tick_upper);
        f_qeu73ytnpp(&arg6, v2, arg3.tick_lower, arg3.tick_upper);
        let v4 = 0x2::object::id<T_2ce6tg7ly2<T0, T1, T2>>(&arg3);
        let v5 = arg3.tick_lower;
        let v6 = arg3.tick_upper;
        let v7 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(&arg6);
        assert!(v7 > 0, 8);
        assert!(arg3.registered_liquidity == v7, 24);
        assert!(arg3.registered_liquidity == arg7, 24);
        let v8 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, T1, T2>(arg0, arg4, arg5, &mut arg6);
        let v9 = 0x2::balance::value<T2>(&v8);
        let (v10, v11, v12, v13) = f_nau2nwsiup<T0, T1>(arg0, arg4, arg5, arg6);
        let v14 = v13;
        let v15 = v12;
        let v16 = v11;
        let v17 = v10;
        let v18 = 0x2::balance::value<T0>(&v15);
        let v19 = 0x2::balance::value<T1>(&v14);
        let v20 = 0x2::balance::value<T0>(&v17);
        let v21 = 0x2::balance::value<T1>(&v16);
        assert!(v9 == arg8, 9);
        assert!(v18 == arg9, 9);
        assert!(v19 == arg10, 9);
        assert!(v20 >= arg11, 10);
        assert!(v21 >= arg12, 11);
        let v22 = T_x4cp5fnodv<T0, T1, T2>{
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
        let v23 = T_iz5cyvrq53{
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
        0x2::event::emit<T_iz5cyvrq53>(v23);
        let T_2ce6tg7ly2 {
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

    public fun f_56spgmfgju<T0, T1>(arg0: &T_f4fxi74vru, arg1: &T_gkfgpktxye, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: address, arg4: &0x4561b692f87e7ab5d424ec4d7f98a747b25cf398a48905c32d6941d653978b52::m_6dckzdjzpg::T_a7d4rfuwsp, arg5: &mut 0x2::tx_context::TxContext) {
        f_zg5f6ephei(arg0, arg1);
        assert!(arg3 != @0x0, 5);
        let v0 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg2);
        f_ai5p56neyp(v0);
        let v1 = T_ppwyv4yz6r<T0, T1, 0x2::sui::SUI>{
            id                      : 0x2::object::new(arg5),
            registry_id             : 0x2::object::id<T_f4fxi74vru>(arg0),
            bluefin_pool_id         : v0,
            owner                   : arg3,
            tick_spacing            : 5,
            income_policy_version   : 1,
            retained_a              : 0x2::balance::zero<T0>(),
            retained_b              : 0x2::balance::zero<T1>(),
            retained_sui            : 0x2::balance::zero<0x2::sui::SUI>(),
            cumulative_gross_income : 0,
            cumulative_payout       : 0,
            cumulative_retained     : 0,
        };
        let v2 = T_uhtbzmlf4y{
            registry_id           : 0x2::object::id<T_f4fxi74vru>(arg0),
            route_id              : 0x2::object::id<T_ppwyv4yz6r<T0, T1, 0x2::sui::SUI>>(&v1),
            bluefin_pool_id       : v0,
            owner                 : arg3,
            tick_spacing          : 5,
            income_policy_version : 1,
            reward_is_sui         : true,
        };
        0x2::event::emit<T_uhtbzmlf4y>(v2);
        0x2::transfer::public_transfer<T_ppwyv4yz6r<T0, T1, 0x2::sui::SUI>>(v1, arg3);
    }

    fun f_5mpoahhrdq<T0, T1, T2>(arg0: &T_j7pyfvqapg<T0, T1, T2>) : T_qw7fcx5qn5 {
        T_qw7fcx5qn5{
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

    fun f_ai5p56neyp(arg0: 0x2::object::ID) {
        assert!(arg0 == 0x2::object::id_from_address(@0xa0153768c7ed857ffd8bad4708da873fb7825a6878e5f4c83f5df4c091933e56), 4);
    }

    public fun f_bcae57ah7u<T0, T1, T2>(arg0: &T_f4fxi74vru, arg1: &mut T_ppwyv4yz6r<T0, T1, T2>, arg2: &T_x4cp5fnodv<T0, T1, T2>, arg3: 0x2::balance::Balance<0x2::sui::SUI>, arg4: 0x2::balance::Balance<0x2::sui::SUI>, arg5: 0x2::balance::Balance<0x2::sui::SUI>, arg6: u64, arg7: &0x4561b692f87e7ab5d424ec4d7f98a747b25cf398a48905c32d6941d653978b52::m_6dckzdjzpg::T_a7d4rfuwsp, arg8: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, 0x2::balance::Balance<0x2::sui::SUI>, T_j7pyfvqapg<T0, T1, T2>) {
        f_mo7yb54ent<T0, T1, T2>(arg0, arg1, arg8);
        assert!(arg2.registry_id == 0x2::object::id<T_f4fxi74vru>(arg0), 1);
        assert!(arg2.route_id == 0x2::object::id<T_ppwyv4yz6r<T0, T1, T2>>(arg1), 3);
        assert!(arg2.bluefin_pool_id == arg1.bluefin_pool_id, 4);
        assert!(arg2.owner == arg1.owner, 5);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg3);
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&arg4);
        let v2 = 0x2::balance::value<0x2::sui::SUI>(&arg5);
        let v3 = v0 + v1 + v2;
        assert!(0x4561b692f87e7ab5d424ec4d7f98a747b25cf398a48905c32d6941d653978b52::m_cgk25bibwz::f_jn5pg2t72q(arg2.reward_amount, arg2.fee_a, arg2.fee_b, v0, v1, v2, v3), 14);
        assert!(v3 >= arg6, 15);
        0x2::balance::join<0x2::sui::SUI>(&mut arg3, arg4);
        0x2::balance::join<0x2::sui::SUI>(&mut arg3, arg5);
        let (v4, v5, v6) = 0x4561b692f87e7ab5d424ec4d7f98a747b25cf398a48905c32d6941d653978b52::m_cgk25bibwz::f_2gkf3ombdy(v3);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg3) == v5, 14);
        f_tuukfzexlz<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg3, v4), arg0.profit_recipient);
        let v7 = 0x2::balance::value<T0>(&arg1.retained_a);
        let v8 = 0x2::balance::value<T1>(&arg1.retained_b);
        let v9 = 0x2::balance::value<0x2::sui::SUI>(&arg1.retained_sui);
        0x2::balance::join<0x2::sui::SUI>(&mut arg3, 0x2::balance::split<0x2::sui::SUI>(&mut arg1.retained_sui, v9));
        arg1.cumulative_gross_income = arg1.cumulative_gross_income + (v3 as u128);
        arg1.cumulative_payout = arg1.cumulative_payout + (v4 as u128);
        arg1.cumulative_retained = arg1.cumulative_retained + (v5 as u128);
        let v10 = T_j7pyfvqapg<T0, T1, T2>{
            registry_id             : 0x2::object::id<T_f4fxi74vru>(arg0),
            route_id                : 0x2::object::id<T_ppwyv4yz6r<T0, T1, T2>>(arg1),
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
        let v11 = T_bxqkkmxtpx{
            registry_id        : 0x2::object::id<T_f4fxi74vru>(arg0),
            route_id           : 0x2::object::id<T_ppwyv4yz6r<T0, T1, T2>>(arg1),
            source_position_id : arg2.source_position_id,
            owner              : arg1.owner,
            income             : f_5mpoahhrdq<T0, T1, T2>(&v10),
        };
        0x2::event::emit<T_bxqkkmxtpx>(v11);
        (0x2::balance::split<T0>(&mut arg1.retained_a, v7), 0x2::balance::split<T1>(&mut arg1.retained_b, v8), arg3, v10)
    }

    fun f_biaffj32om(arg0: u32, arg1: u32) {
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg1)), 7);
    }

    public fun f_e5yk7br6bz<T0, T1, T2>(arg0: &T_f4fxi74vru, arg1: &T_gkfgpktxye, arg2: &T_ppwyv4yz6r<T0, T1, T2>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg5: u32, arg6: u32, arg7: u128, arg8: &0x4561b692f87e7ab5d424ec4d7f98a747b25cf398a48905c32d6941d653978b52::m_6dckzdjzpg::T_a7d4rfuwsp, arg9: &mut 0x2::tx_context::TxContext) {
        f_zg5f6ephei(arg0, arg1);
        f_yvsufm7img<T0, T1, T2>(arg0, arg2, arg3);
        f_biaffj32om(arg5, arg6);
        let v0 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg3);
        f_qeu73ytnpp(arg4, v0, arg5, arg6);
        let v1 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(arg4);
        assert!(v1 > 0 && v1 == arg7, 8);
        let v2 = T_2ce6tg7ly2<T0, T1, T2>{
            id                   : 0x2::object::new(arg9),
            registry_id          : 0x2::object::id<T_f4fxi74vru>(arg0),
            route_id             : 0x2::object::id<T_ppwyv4yz6r<T0, T1, T2>>(arg2),
            bluefin_pool_id      : v0,
            bluefin_position_id  : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(arg4),
            owner                : arg2.owner,
            tick_lower           : arg5,
            tick_upper           : arg6,
            registered_liquidity : v1,
        };
        let v3 = T_wvxbxlhdbw{
            registry_id         : 0x2::object::id<T_f4fxi74vru>(arg0),
            route_id            : 0x2::object::id<T_ppwyv4yz6r<T0, T1, T2>>(arg2),
            position_cap_id     : 0x2::object::id<T_2ce6tg7ly2<T0, T1, T2>>(&v2),
            bluefin_pool_id     : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg3),
            bluefin_position_id : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(arg4),
            owner               : arg2.owner,
            tick_lower          : arg5,
            tick_upper          : arg6,
            liquidity           : v1,
        };
        0x2::event::emit<T_wvxbxlhdbw>(v3);
        0x2::transfer::public_transfer<T_2ce6tg7ly2<T0, T1, T2>>(v2, arg2.owner);
    }

    fun f_fj5mw7pha6<T0, T1, T2>(arg0: &T_f4fxi74vru, arg1: &T_ppwyv4yz6r<T0, T1, T2>, arg2: &T_x4cp5fnodv<T0, T1, T2>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>) {
        assert!(arg2.registry_id == 0x2::object::id<T_f4fxi74vru>(arg0), 1);
        assert!(arg2.route_id == 0x2::object::id<T_ppwyv4yz6r<T0, T1, T2>>(arg1), 3);
        assert!(arg2.bluefin_pool_id == 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg3), 4);
        assert!(arg2.owner == arg1.owner, 5);
        f_biaffj32om(arg2.source_tick_lower, arg2.source_tick_upper);
    }

    public fun f_fwcd24wfre<T0, T1, T2>(arg0: &T_f4fxi74vru, arg1: &T_ppwyv4yz6r<T0, T1, T2>, arg2: T_x4cp5fnodv<T0, T1, T2>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: &0x4561b692f87e7ab5d424ec4d7f98a747b25cf398a48905c32d6941d653978b52::m_6dckzdjzpg::T_a7d4rfuwsp, arg5: &0x2::tx_context::TxContext) : T_x4cp5fnodv<T0, T1, T2> {
        f_wbodiqlump<T0, T1, T2>(arg0, arg1, arg3, arg5);
        f_fj5mw7pha6<T0, T1, T2>(arg0, arg1, &arg2, arg3);
        assert!(!arg2.oor_asserted, 13);
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg3);
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v0, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg2.source_tick_lower)) || 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gte(v0, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg2.source_tick_upper)), 12);
        arg2.oor_asserted = true;
        let v1 = T_4v2iqhpkoz{
            registry_id        : arg2.registry_id,
            route_id           : arg2.route_id,
            source_position_id : arg2.source_position_id,
            current_tick       : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v0),
            source_tick_lower  : arg2.source_tick_lower,
            source_tick_upper  : arg2.source_tick_upper,
        };
        0x2::event::emit<T_4v2iqhpkoz>(v1);
        arg2
    }

    fun f_mo7yb54ent<T0, T1, T2>(arg0: &T_f4fxi74vru, arg1: &T_ppwyv4yz6r<T0, T1, T2>, arg2: &0x2::tx_context::TxContext) {
        f_qaj2mycqej(arg0);
        assert!(arg1.registry_id == 0x2::object::id<T_f4fxi74vru>(arg0), 1);
        f_ai5p56neyp(arg1.bluefin_pool_id);
        assert!(arg1.owner == 0x2::tx_context::sender(arg2), 5);
        assert!(arg1.tick_spacing == 5, 7);
        assert!(arg1.income_policy_version == 1, 21);
    }

    public fun f_nakwxzxgkh<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &T_f4fxi74vru, arg2: &mut T_ppwyv4yz6r<T0, T1, T2>, arg3: T_x4cp5fnodv<T0, T1, T2>, arg4: T_j7pyfvqapg<T0, T1, T2>, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg7: 0x2::balance::Balance<T0>, arg8: 0x2::balance::Balance<T1>, arg9: 0x2::balance::Balance<T0>, arg10: 0x2::balance::Balance<T1>, arg11: 0x2::balance::Balance<0x2::sui::SUI>, arg12: u8, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: u64, arg19: u32, arg20: u64, arg21: bool, arg22: u64, arg23: u64, arg24: u64, arg25: u64, arg26: u64, arg27: bool, arg28: u64, arg29: u64, arg30: u64, arg31: u64, arg32: &0x4561b692f87e7ab5d424ec4d7f98a747b25cf398a48905c32d6941d653978b52::m_6dckzdjzpg::T_a7d4rfuwsp, arg33: &mut 0x2::tx_context::TxContext) {
        f_wbodiqlump<T0, T1, T2>(arg1, arg2, arg6, arg33);
        f_fj5mw7pha6<T0, T1, T2>(arg1, arg2, &arg3, arg6);
        assert!(arg3.oor_asserted, 13);
        f_rp2pexqgyz<T0, T1, T2>(arg1, arg2, &arg3, &arg4);
        assert!(0x2::balance::value<T0>(&arg2.retained_a) == 0, 14);
        assert!(0x2::balance::value<T1>(&arg2.retained_b) == 0, 14);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg2.retained_sui) == 0, 14);
        let v0 = 0x2::balance::value<T0>(&arg7);
        let v1 = 0x2::balance::value<T1>(&arg8);
        let v2 = f_vinxx2jrsb(arg3.source_principal_a, arg3.source_principal_b, v0, v1, arg12, arg13);
        assert!(0x4561b692f87e7ab5d424ec4d7f98a747b25cf398a48905c32d6941d653978b52::m_cgk25bibwz::f_w4tjem7zqm(arg3.source_principal_a, arg3.source_principal_b, v0, v1, arg12, arg13, v2), 14);
        assert!(v2 >= arg14, 15);
        let v3 = 0x2::balance::value<T0>(&arg9);
        let v4 = 0x2::balance::value<T1>(&arg10);
        let v5 = 0x2::balance::value<0x2::sui::SUI>(&arg11);
        assert!(v3 >= arg4.prior_retained_a, 14);
        assert!(v4 >= arg4.prior_retained_b, 14);
        let v6 = v3 - arg4.prior_retained_a;
        let v7 = v4 - arg4.prior_retained_b;
        f_razt6hq7xh(arg15, v6, arg16);
        f_razt6hq7xh(arg17, v7, arg18);
        assert!(0x4561b692f87e7ab5d424ec4d7f98a747b25cf398a48905c32d6941d653978b52::m_cgk25bibwz::f_ernwde2fox(arg4.prior_retained_a, arg4.prior_retained_b, arg4.prior_retained_sui, arg4.newly_retained_sui, v3, v4, v5, arg15, v6, arg17, v7), 14);
        let (v8, v9) = f_pb7pnzff7w(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg6), 0x4561b692f87e7ab5d424ec4d7f98a747b25cf398a48905c32d6941d653978b52::m_cgk25bibwz::f_u7yoggilzz(arg2.tick_spacing, arg19), arg2.tick_spacing, arg19);
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
        f_qeu73ytnpp(&v10, 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg6), v8, v9);
        let v29 = T_2ce6tg7ly2<T0, T1, T2>{
            id                   : 0x2::object::new(arg33),
            registry_id          : 0x2::object::id<T_f4fxi74vru>(arg1),
            route_id             : 0x2::object::id<T_ppwyv4yz6r<T0, T1, T2>>(arg2),
            bluefin_pool_id      : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg6),
            bluefin_position_id  : v11,
            owner                : arg2.owner,
            tick_lower           : v8,
            tick_upper           : v9,
            registered_liquidity : v28,
        };
        let v30 = T_o7tscqpl5y{
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
        let v31 = T_nxqtjh3oyk{
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
        let v32 = T_agjcodya3k{
            registry_id                 : 0x2::object::id<T_f4fxi74vru>(arg1),
            route_id                    : 0x2::object::id<T_ppwyv4yz6r<T0, T1, T2>>(arg2),
            source_position_cap_id      : arg3.source_position_cap_id,
            replacement_position_cap_id : 0x2::object::id<T_2ce6tg7ly2<T0, T1, T2>>(&v29),
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
            income                      : f_5mpoahhrdq<T0, T1, T2>(&arg4),
            principal                   : v30,
            retained                    : v31,
        };
        0x2::event::emit<T_agjcodya3k>(v32);
        let T_x4cp5fnodv {
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
        let T_j7pyfvqapg {
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
        0x2::transfer::public_transfer<T_2ce6tg7ly2<T0, T1, T2>>(v29, arg2.owner);
        f_tuukfzexlz<T0>(v17, arg2.owner);
        f_tuukfzexlz<T1>(v16, arg2.owner);
    }

    fun f_nau2nwsiup<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let v0 = &mut arg3;
        let (v1, v2) = f_ntbj5puosx<T0, T1>(arg0, arg1, arg2, v0);
        let v3 = v2;
        let v4 = v1;
        let (_, _, v7, v8) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::remove_liquidity<T0, T1>(arg1, arg2, &mut arg3, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(&arg3), arg0);
        let v9 = &mut arg3;
        let (v10, v11) = f_ntbj5puosx<T0, T1>(arg0, arg1, arg2, v9);
        0x2::balance::join<T0>(&mut v4, v10);
        0x2::balance::join<T1>(&mut v3, v11);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::close_position_v2<T0, T1>(arg0, arg1, arg2, arg3);
        (v7, v8, v4, v3)
    }

    fun f_ntbj5puosx<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let (v0, v1) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::get_accrued_fee(arg3);
        if (v0 > 0 || v1 > 0) {
            let (_, _, v6, v7) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_fee<T0, T1>(arg0, arg1, arg2, arg3);
            (v6, v7)
        } else {
            (0x2::balance::zero<T0>(), 0x2::balance::zero<T1>())
        }
    }

    fun f_pb7pnzff7w(arg0: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg1: u32, arg2: u32, arg3: u32) : (u32, u32) {
        assert!(arg2 == 5, 7);
        assert!(0x4561b692f87e7ab5d424ec4d7f98a747b25cf398a48905c32d6941d653978b52::m_cgk25bibwz::f_zutbgzxug2(arg3), 7);
        assert!(arg1 == arg2 * arg3, 7);
        let v0 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(arg2);
        let v1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::mul(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::div(arg0, v0), v0);
        let v2 = v1;
        if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::is_neg(arg0) && !0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::eq(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::mod(arg0, v0), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::zero())) {
            v2 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(v1, v0);
        };
        let v3 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(v2, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from((arg3 - 1) / 2 * arg2));
        let v4 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(v3, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(arg1));
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gte(arg0, v3) && 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(arg0, v4), 7);
        (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v3), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v4))
    }

    fun f_qaj2mycqej(arg0: &T_f4fxi74vru) {
        assert!(arg0.profit_recipient == @0xa10aecd2e9e45698e8c36ccaf3c4ea51cdda87f3c098a71d1e77be3351000498, 2);
    }

    fun f_qeu73ytnpp(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg1: 0x2::object::ID, arg2: u32, arg3: u32) {
        assert!(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::pool_id(arg0) == arg1, 22);
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::eq(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::lower_tick(arg0), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg2)), 23);
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::eq(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::upper_tick(arg0), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg3)), 23);
    }

    fun f_razt6hq7xh(arg0: u64, arg1: u64, arg2: u64) {
        if (arg0 == 0) {
            assert!(arg1 == 0 && arg2 == 0, 14);
        } else {
            assert!(arg1 > 0 && arg1 >= arg2, 15);
        };
    }

    fun f_rp2pexqgyz<T0, T1, T2>(arg0: &T_f4fxi74vru, arg1: &T_ppwyv4yz6r<T0, T1, T2>, arg2: &T_x4cp5fnodv<T0, T1, T2>, arg3: &T_j7pyfvqapg<T0, T1, T2>) {
        assert!(arg3.registry_id == 0x2::object::id<T_f4fxi74vru>(arg0), 1);
        assert!(arg3.route_id == 0x2::object::id<T_ppwyv4yz6r<T0, T1, T2>>(arg1), 3);
        assert!(arg3.source_position_id == arg2.source_position_id, 6);
        assert!(arg3.profit_recipient == arg0.profit_recipient, 2);
        assert!(0x4561b692f87e7ab5d424ec4d7f98a747b25cf398a48905c32d6941d653978b52::m_cgk25bibwz::f_jn5pg2t72q(arg2.reward_amount, arg2.fee_a, arg2.fee_b, arg3.reward_as_sui, arg3.fee_a_as_sui, arg3.fee_b_as_sui, arg3.gross_income_sui), 14);
        let (v0, v1, v2) = 0x4561b692f87e7ab5d424ec4d7f98a747b25cf398a48905c32d6941d653978b52::m_cgk25bibwz::f_2gkf3ombdy(arg3.gross_income_sui);
        assert!(arg3.payout_sui == v0, 14);
        assert!(arg3.newly_retained_sui == v1, 14);
        assert!(arg3.rounding_to_recipient == v2, 14);
        assert!(arg1.cumulative_gross_income == arg3.cumulative_gross_income, 14);
        assert!(arg1.cumulative_payout == arg3.cumulative_payout, 14);
        assert!(arg1.cumulative_retained == arg3.cumulative_retained, 14);
    }

    public fun f_s4uorjazz6<T0, T1, T2>(arg0: &T_f4fxi74vru, arg1: &mut T_ppwyv4yz6r<T0, T1, T2>, arg2: &0x4561b692f87e7ab5d424ec4d7f98a747b25cf398a48905c32d6941d653978b52::m_6dckzdjzpg::T_a7d4rfuwsp, arg3: &mut 0x2::tx_context::TxContext) {
        f_mo7yb54ent<T0, T1, T2>(arg0, arg1, arg3);
        let v0 = 0x2::balance::value<T0>(&arg1.retained_a);
        let v1 = 0x2::balance::value<T1>(&arg1.retained_b);
        let v2 = 0x2::balance::value<0x2::sui::SUI>(&arg1.retained_sui);
        let v3 = T_ggcwd6qqo5{
            registry_id             : 0x2::object::id<T_f4fxi74vru>(arg0),
            route_id                : 0x2::object::id<T_ppwyv4yz6r<T0, T1, T2>>(arg1),
            owner                   : arg1.owner,
            amount_a                : v0,
            amount_b                : v1,
            amount_sui              : v2,
            live_position_untouched : true,
        };
        0x2::event::emit<T_ggcwd6qqo5>(v3);
        f_tuukfzexlz<T0>(0x2::balance::split<T0>(&mut arg1.retained_a, v0), arg1.owner);
        f_tuukfzexlz<T1>(0x2::balance::split<T1>(&mut arg1.retained_b, v1), arg1.owner);
        f_tuukfzexlz<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.retained_sui, v2), arg1.owner);
    }

    fun f_tuukfzexlz<T0>(arg0: 0x2::balance::Balance<T0>, arg1: address) {
        if (0x2::balance::value<T0>(&arg0) > 0) {
            0x2::balance::send_funds<T0>(arg0, arg1);
        } else {
            0x2::balance::destroy_zero<T0>(arg0);
        };
    }

    fun f_vinxx2jrsb(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u8, arg5: u64) : u64 {
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

    fun f_wbodiqlump<T0, T1, T2>(arg0: &T_f4fxi74vru, arg1: &T_ppwyv4yz6r<T0, T1, T2>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &0x2::tx_context::TxContext) {
        f_yvsufm7img<T0, T1, T2>(arg0, arg1, arg2);
        assert!(arg1.owner == 0x2::tx_context::sender(arg3), 5);
    }

    fun f_yvsufm7img<T0, T1, T2>(arg0: &T_f4fxi74vru, arg1: &T_ppwyv4yz6r<T0, T1, T2>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>) {
        f_qaj2mycqej(arg0);
        assert!(arg1.registry_id == 0x2::object::id<T_f4fxi74vru>(arg0), 1);
        assert!(arg1.bluefin_pool_id == 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg2), 4);
        f_ai5p56neyp(arg1.bluefin_pool_id);
        assert!(arg1.owner != @0x0, 5);
        assert!(arg1.tick_spacing == 5, 7);
        assert!(arg1.income_policy_version == 1, 21);
    }

    fun f_zg5f6ephei(arg0: &T_f4fxi74vru, arg1: &T_gkfgpktxye) {
        f_qaj2mycqej(arg0);
        assert!(arg1.registry_id == 0x2::object::id<T_f4fxi74vru>(arg0), 0);
        assert!(0x2::object::id<T_gkfgpktxye>(arg1) == arg0.admin_cap_id, 0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg0);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = T_gkfgpktxye{
            id          : 0x2::object::new(arg0),
            registry_id : v1,
        };
        let v3 = 0x2::object::id<T_gkfgpktxye>(&v2);
        let v4 = T_f4fxi74vru{
            id               : v0,
            admin_cap_id     : v3,
            profit_recipient : @0xa10aecd2e9e45698e8c36ccaf3c4ea51cdda87f3c098a71d1e77be3351000498,
        };
        let v5 = T_fyj4ycmscu{
            registry_id      : v1,
            admin_cap_id     : v3,
            profit_recipient : @0xa10aecd2e9e45698e8c36ccaf3c4ea51cdda87f3c098a71d1e77be3351000498,
        };
        0x2::event::emit<T_fyj4ycmscu>(v5);
        0x2::transfer::public_transfer<T_gkfgpktxye>(v2, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<T_f4fxi74vru>(v4);
    }

    // decompiled from Move bytecode v7
}

