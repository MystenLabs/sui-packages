module 0x53e7ae7e4f54295fc2946532cc0803ebe535e699afce631a9b92e9fc58e401::bluefin {
    struct Witness has drop {
        dummy_field: bool,
    }

    struct Venue has drop {
        dummy_field: bool,
    }

    public fun buyback_and_burn<T0, T1>(arg0: &mut 0x53e7ae7e4f54295fc2946532cc0803ebe535e699afce631a9b92e9fc58e401::vault::LpVault<T0, T1>, arg1: &0x53e7ae7e4f54295fc2946532cc0803ebe535e699afce631a9b92e9fc58e401::blast_fun_migrators::PackageVersion, arg2: &0xcaf80b8d1624043c3b1b58cd44f67552bad20f2e88eb349e6693bfd36cee556c::blast_acl::AdminWitness<0x5ffb509589a9c287da16b2c5f969897d4e98436a8c5252657b4f73c876b68278::blast_fun_domain::BuybackAdmin>, arg3: &mut 0x2::coin_registry::Currency<T0>, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x53e7ae7e4f54295fc2946532cc0803ebe535e699afce631a9b92e9fc58e401::blast_fun_migrators::assert_current(arg1);
        assert!(0x53e7ae7e4f54295fc2946532cc0803ebe535e699afce631a9b92e9fc58e401::vault::pool_id<T0, T1>(arg0) == 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg5), 13835058725297061889);
        let v0 = 0x53e7ae7e4f54295fc2946532cc0803ebe535e699afce631a9b92e9fc58e401::vault::take_buyback_quote<T0, T1>(arg0, arg2);
        let v1 = 0x2::balance::value<T1>(&v0);
        let (v2, v3) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T0, T1>(arg7, arg4, arg5, 0x2::balance::zero<T0>(), v0, false, true, v1, 0, 79226673515401279992447579054);
        0x53e7ae7e4f54295fc2946532cc0803ebe535e699afce631a9b92e9fc58e401::vault::burn_buyback<T0, T1>(arg0, arg3, v2, v3, v1, arg6, arg8);
    }

    public fun collect_fees<T0, T1>(arg0: &mut 0x53e7ae7e4f54295fc2946532cc0803ebe535e699afce631a9b92e9fc58e401::vault::LpVault<T0, T1>, arg1: &0x53e7ae7e4f54295fc2946532cc0803ebe535e699afce631a9b92e9fc58e401::blast_fun_migrators::PackageVersion, arg2: &0x53e7ae7e4f54295fc2946532cc0803ebe535e699afce631a9b92e9fc58e401::lp_fee_policy::LpFeePolicy, arg3: &mut 0x2::coin_registry::Currency<T0>, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x53e7ae7e4f54295fc2946532cc0803ebe535e699afce631a9b92e9fc58e401::blast_fun_migrators::assert_current(arg1);
        settle_fees<T0, T1>(arg0, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    fun collect_position_fees<T0, T1>(arg0: &mut 0x53e7ae7e4f54295fc2946532cc0803ebe535e699afce631a9b92e9fc58e401::vault::LpVault<T0, T1>, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let v0 = Venue{dummy_field: false};
        let v1 = 0x53e7ae7e4f54295fc2946532cc0803ebe535e699afce631a9b92e9fc58e401::vault::position_mut<T0, T1, Venue, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(arg0, &v0);
        assert!(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::pool_id(v1) == 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg2), 13835059326592483329);
        let (_, _, v4, v5) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_fee<T0, T1>(arg3, arg1, arg2, v1);
        (v4, v5)
    }

    fun compound<T0, T1>(arg0: &mut 0x53e7ae7e4f54295fc2946532cc0803ebe535e699afce631a9b92e9fc58e401::vault::LpVault<T0, T1>, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock) {
        let (v0, v1) = 0x53e7ae7e4f54295fc2946532cc0803ebe535e699afce631a9b92e9fc58e401::vault::take_auto_lp<T0, T1>(arg0);
        let v2 = v1;
        let v3 = v0;
        let v4 = Venue{dummy_field: false};
        let v5 = 0x53e7ae7e4f54295fc2946532cc0803ebe535e699afce631a9b92e9fc58e401::vault::position_mut<T0, T1, Venue, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(arg0, &v4);
        let (v6, v7) = fixed_side<T0, T1>(arg2, v5, 0x2::balance::value<T0>(&v3), 0x2::balance::value<T1>(&v2));
        let (v8, v9, v10, v11) = if (v7 > 0) {
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::add_liquidity_with_fixed_amount<T0, T1>(arg3, arg1, arg2, v5, v3, v2, v7, v6)
        } else {
            (0, 0, v3, v2)
        };
        0x53e7ae7e4f54295fc2946532cc0803ebe535e699afce631a9b92e9fc58e401::vault::keep_auto_lp<T0, T1>(arg0, v8, v9, v10, v11);
    }

    fun fixed_side<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg2: u64, arg3: u64) : (bool, u64) {
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_tick_manager<T0, T1>(arg0);
        0x53e7ae7e4f54295fc2946532cc0803ebe535e699afce631a9b92e9fc58e401::migration_math::auto_lp_fixed_side(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick::sqrt_price(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick::get_tick_from_manager(v0, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::lower_tick(arg1))), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg0), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick::sqrt_price(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick::get_tick_from_manager(v0, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::upper_tick(arg1))), arg2, arg3)
    }

    fun full_range_tick_range(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: u32) : (u32, u32) {
        let (v0, v1) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::get_tick_range(arg0);
        let v2 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(arg1);
        (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::mul(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::div(v0, v2), v2)), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::mul(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::div(v1, v2), v2)))
    }

    fun is_meme_seed_side<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg2: u64, arg3: u64) : bool {
        let v0 = arg2 >= arg3;
        let v1 = if (v0) {
            arg2
        } else {
            arg3
        };
        let (_, v3, v4) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_liquidity_by_amount(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::lower_tick(arg1), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::upper_tick(arg1), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg0), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg0), v1, v0);
        v3 <= arg2 && v4 <= arg3 && v0 || !v0
    }

    fun lock_into_vault<T0, T1>(arg0: &0x5ffb509589a9c287da16b2c5f969897d4e98436a8c5252657b4f73c876b68278::launch::Launch<T0, T1>, arg1: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg2: 0x2::balance::Balance<T0>, arg3: 0x2::balance::Balance<T1>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = Venue{dummy_field: false};
        0x53e7ae7e4f54295fc2946532cc0803ebe535e699afce631a9b92e9fc58e401::vault::create<T0, T1, Venue, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(arg0, &v0, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::pool_id(&arg1), arg1, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(&arg1), arg2, arg3, arg4);
    }

    public fun migrate<T0, T1>(arg0: &mut 0x5ffb509589a9c287da16b2c5f969897d4e98436a8c5252657b4f73c876b68278::launch::Launch<T0, T1>, arg1: &0x53e7ae7e4f54295fc2946532cc0803ebe535e699afce631a9b92e9fc58e401::blast_fun_migrators::PackageVersion, arg2: &0x5ffb509589a9c287da16b2c5f969897d4e98436a8c5252657b4f73c876b68278::blast_fun::PackageVersion, arg3: &mut 0x2::coin_registry::Currency<T0>, arg4: &0x2::coin_registry::Currency<T1>, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x53e7ae7e4f54295fc2946532cc0803ebe535e699afce631a9b92e9fc58e401::blast_fun_migrators::assert_current(arg1);
        let (v0, v1) = 0x5ffb509589a9c287da16b2c5f969897d4e98436a8c5252657b4f73c876b68278::launch::pool_tier<T0, T1>(arg0);
        let (v2, v3) = full_range_tick_range(arg5, v0);
        let v4 = Witness{dummy_field: false};
        let (v5, v6) = 0x5ffb509589a9c287da16b2c5f969897d4e98436a8c5252657b4f73c876b68278::launch::migrate<T0, T1, Witness>(arg0, arg2, arg3, v4, arg8);
        let v7 = v6;
        let v8 = v5;
        let v9 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::create_pool_and_get_object<T0, T1, 0x2::sui::SUI>(arg7, arg5, pool_name<T0, T1>(arg3, arg4), b"", 0x1::string::into_bytes(0x2::coin_registry::symbol<T0>(arg3)), 0x2::coin_registry::decimals<T0>(arg3), b"", 0x1::string::into_bytes(0x2::coin_registry::symbol<T1>(arg4)), 0x2::coin_registry::decimals<T1>(arg4), 0x1::string::into_bytes(0x2::coin_registry::icon_url<T1>(arg4)), v0, v1, 0x53e7ae7e4f54295fc2946532cc0803ebe535e699afce631a9b92e9fc58e401::migration_math::sqrt_price_x64(0x2::balance::value<T0>(&v8), 0x2::balance::value<T1>(&v7), true), 0x2::coin::into_balance<0x2::sui::SUI>(arg6), arg8);
        let v10 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::open_position<T0, T1>(arg5, &mut v9, v2, v3, arg8);
        let v11 = &mut v9;
        let v12 = &mut v10;
        let (v13, v14) = seed<T0, T1>(arg5, v11, v12, v8, v7, arg7);
        lock_into_vault<T0, T1>(arg0, v10, v13, v14, arg8);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::share_pool_object<T0, T1>(v9);
    }

    public fun new<T0, T1>(arg0: 0x5ffb509589a9c287da16b2c5f969897d4e98436a8c5252657b4f73c876b68278::launch_ticket::LaunchTicket<T0>, arg1: &0x53e7ae7e4f54295fc2946532cc0803ebe535e699afce631a9b92e9fc58e401::blast_fun_migrators::PackageVersion, arg2: &0x5ffb509589a9c287da16b2c5f969897d4e98436a8c5252657b4f73c876b68278::blast_fun::PackageVersion, arg3: &0x5ffb509589a9c287da16b2c5f969897d4e98436a8c5252657b4f73c876b68278::launch_config::LaunchConfig, arg4: u32, arg5: u64) : 0x5ffb509589a9c287da16b2c5f969897d4e98436a8c5252657b4f73c876b68278::launch::LaunchInitializer<T0, T1> {
        0x53e7ae7e4f54295fc2946532cc0803ebe535e699afce631a9b92e9fc58e401::blast_fun_migrators::assert_current(arg1);
        let v0 = if (arg4 > 0) {
            if (arg4 <= 400) {
                if (arg5 > 0) {
                    arg5 <= 20000
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 13835339697762729987);
        let v1 = Witness{dummy_field: false};
        0x5ffb509589a9c287da16b2c5f969897d4e98436a8c5252657b4f73c876b68278::launch::new<T0, T1, Witness>(arg0, arg2, arg3, v1, arg4, arg5)
    }

    fun pool_name<T0, T1>(arg0: &0x2::coin_registry::Currency<T0>, arg1: &0x2::coin_registry::Currency<T1>) : vector<u8> {
        let v0 = 0x1::string::into_bytes(0x2::coin_registry::symbol<T0>(arg0));
        0x1::vector::append<u8>(&mut v0, b"-");
        0x1::vector::append<u8>(&mut v0, 0x1::string::into_bytes(0x2::coin_registry::symbol<T1>(arg1)));
        v0
    }

    fun seed<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg3: 0x2::balance::Balance<T0>, arg4: 0x2::balance::Balance<T1>, arg5: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let v0 = is_meme_seed_side<T0, T1>(arg1, arg2, 0x2::balance::value<T0>(&arg3), 0x2::balance::value<T1>(&arg4));
        let v1 = if (v0) {
            0x2::balance::value<T0>(&arg3)
        } else {
            0x2::balance::value<T1>(&arg4)
        };
        let (_, _, v4, v5) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::add_liquidity_with_fixed_amount<T0, T1>(arg5, arg0, arg1, arg2, arg3, arg4, v1, v0);
        (v4, v5)
    }

    public fun settle_and_update_fee_split<T0, T1>(arg0: &mut 0x53e7ae7e4f54295fc2946532cc0803ebe535e699afce631a9b92e9fc58e401::vault::LpVault<T0, T1>, arg1: &0x53e7ae7e4f54295fc2946532cc0803ebe535e699afce631a9b92e9fc58e401::blast_fun_migrators::PackageVersion, arg2: &0x53e7ae7e4f54295fc2946532cc0803ebe535e699afce631a9b92e9fc58e401::lp_fee_policy::LpFeePolicy, arg3: &0x5ffb509589a9c287da16b2c5f969897d4e98436a8c5252657b4f73c876b68278::launch::Launch<T0, T1>, arg4: &0x5ffb509589a9c287da16b2c5f969897d4e98436a8c5252657b4f73c876b68278::creator_authority::CurveFeeCap<T0>, arg5: &mut 0x2::coin_registry::Currency<T0>, arg6: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg7: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg8: 0x5ffb509589a9c287da16b2c5f969897d4e98436a8c5252657b4f73c876b68278::allocation::FeeSplit, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        0x53e7ae7e4f54295fc2946532cc0803ebe535e699afce631a9b92e9fc58e401::blast_fun_migrators::assert_current(arg1);
        0x53e7ae7e4f54295fc2946532cc0803ebe535e699afce631a9b92e9fc58e401::vault::assert_fee_split_update<T0, T1>(arg0, arg3, arg4, arg8);
        settle_fees<T0, T1>(arg0, arg2, arg5, arg6, arg7, arg9, arg10);
        0x53e7ae7e4f54295fc2946532cc0803ebe535e699afce631a9b92e9fc58e401::vault::update_fee_split<T0, T1>(arg0, arg8);
    }

    fun settle_fees<T0, T1>(arg0: &mut 0x53e7ae7e4f54295fc2946532cc0803ebe535e699afce631a9b92e9fc58e401::vault::LpVault<T0, T1>, arg1: &0x53e7ae7e4f54295fc2946532cc0803ebe535e699afce631a9b92e9fc58e401::lp_fee_policy::LpFeePolicy, arg2: &mut 0x2::coin_registry::Currency<T0>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = collect_position_fees<T0, T1>(arg0, arg3, arg4, arg5);
        0x53e7ae7e4f54295fc2946532cc0803ebe535e699afce631a9b92e9fc58e401::vault::split_fees<T0, T1>(arg0, arg1, arg2, v0, v1, arg6);
        compound<T0, T1>(arg0, arg3, arg4, arg5);
    }

    // decompiled from Move bytecode v7
}

