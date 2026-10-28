module 0x7e009c69fcaab269617359fc9ea2b3a308e71c82165af30f3b91ffc445800416::cetus {
    struct Witness has drop {
        dummy_field: bool,
    }

    struct Venue has drop {
        dummy_field: bool,
    }

    struct CreationCapKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct CastKey has copy, drop, store {
        dummy_field: bool,
    }

    fun swap<T0, T1>(arg0: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: 0x2::balance::Balance<T0>, arg3: 0x2::balance::Balance<T1>, arg4: bool, arg5: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let (v0, v1) = if (arg4) {
            (0x2::balance::value<T0>(&arg2), 4295048017)
        } else {
            (0x2::balance::value<T1>(&arg3), 79226673515401279992447579054)
        };
        let (v2, v3, v4) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg0, arg4, true, v0, v1, arg5);
        let v5 = v4;
        let (v6, v7) = if (arg4) {
            (0x2::balance::split<T0>(&mut arg2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v5)), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut arg3, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v5)))
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg0, v6, v7, v5);
        0x2::balance::join<T0>(&mut arg2, v2);
        0x2::balance::join<T1>(&mut arg3, v3);
        (arg2, arg3)
    }

    public fun new<T0, T1>(arg0: 0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::launch_ticket::LaunchTicket<T0>, arg1: &0x7e009c69fcaab269617359fc9ea2b3a308e71c82165af30f3b91ffc445800416::blast_fun_migrators::PackageVersion, arg2: &0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::blast_fun::PackageVersion, arg3: &0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::launch_config::LaunchConfig, arg4: &mut 0x7e009c69fcaab269617359fc9ea2b3a308e71c82165af30f3b91ffc445800416::venue_config::VenueConfig, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg7: u32, arg8: &mut 0x2::tx_context::TxContext) : 0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::launch::LaunchInitializer<T0, T1> {
        0x7e009c69fcaab269617359fc9ea2b3a308e71c82165af30f3b91ffc445800416::blast_fun_migrators::assert_current(arg1);
        let v0 = Witness{dummy_field: false};
        let v1 = 0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::launch::new<T0, T1, Witness>(arg0, arg2, arg3, v0, arg7, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::get_fee_rate(arg7, arg5));
        let v2 = Witness{dummy_field: false};
        let v3 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::mint_pool_creation_cap<T0>(arg5, arg6, 0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::launch::treasury_cap_mut<T0, T1, Witness>(&mut v1, v2), arg8);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::register_permission_pair<T0, T1>(arg5, arg6, arg7, &v3, arg8);
        let v4 = CreationCapKey<T0>{dummy_field: false};
        0x7e009c69fcaab269617359fc9ea2b3a308e71c82165af30f3b91ffc445800416::venue_config::add_object<CreationCapKey<T0>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::PoolCreationCap>(arg4, v4, v3);
        0x7e009c69fcaab269617359fc9ea2b3a308e71c82165af30f3b91ffc445800416::blast_events::cetus_pool_reserved<T0, T1>(0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::PoolCreationCap>(&v3), arg7);
        v1
    }

    fun add_liquidity<T0, T1, T2, T3>(arg0: &mut 0x7e009c69fcaab269617359fc9ea2b3a308e71c82165af30f3b91ffc445800416::vault::LpVault<T2, T3>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: 0x2::balance::Balance<T0>, arg4: 0x2::balance::Balance<T1>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, u64, u64) {
        if (0x2::balance::value<T0>(&arg3) == 0 || 0x2::balance::value<T1>(&arg4) == 0) {
            return (arg3, arg4, 0, 0)
        };
        let v0 = Venue{dummy_field: false};
        if (!0x7e009c69fcaab269617359fc9ea2b3a308e71c82165af30f3b91ffc445800416::vault::has_auto_lp_position<T2, T3, Venue>(arg0, &v0)) {
            let (v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool_creator::full_range_tick_range(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::tick_spacing<T0, T1>(arg2));
            let v3 = Venue{dummy_field: false};
            0x7e009c69fcaab269617359fc9ea2b3a308e71c82165af30f3b91ffc445800416::vault::attach_auto_lp_position<T2, T3, Venue, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg0, &v3, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::open_position<T0, T1>(arg1, arg2, v1, v2, arg6));
        };
        let v4 = Venue{dummy_field: false};
        let v5 = 0x7e009c69fcaab269617359fc9ea2b3a308e71c82165af30f3b91ffc445800416::vault::auto_lp_position_mut<T2, T3, Venue, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg0, &v4);
        let (v6, v7) = fixed_side<T0, T1>(arg2, v5, 0x2::balance::value<T0>(&arg3), 0x2::balance::value<T1>(&arg4));
        if (v7 == 0) {
            return (arg3, arg4, 0, 0)
        };
        let v8 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<T0, T1>(arg1, arg2, v5, v7, v6, arg5);
        let (v9, v10) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<T0, T1>(&v8);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T0, T1>(arg1, arg2, 0x2::balance::split<T0>(&mut arg3, v9), 0x2::balance::split<T1>(&mut arg4, v10), v8);
        (arg3, arg4, v9, v10)
    }

    fun burn_into_vault<T0, T1>(arg0: &0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::launch::Launch<T0, T1>, arg1: &mut 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg2: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = Venue{dummy_field: false};
        0x7e009c69fcaab269617359fc9ea2b3a308e71c82165af30f3b91ffc445800416::vault::create<T0, T1, Venue, 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::CetusLPBurnProof>(arg0, &v0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::pool_id(&arg2), 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::burn_lp_v2(arg1, arg2, arg5), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(&arg2), 0x2::coin::into_balance<T0>(arg3), 0x2::coin::into_balance<T1>(arg4), arg5);
    }

    public fun buyback_and_burn<T0, T1, T2, T3>(arg0: &mut 0x7e009c69fcaab269617359fc9ea2b3a308e71c82165af30f3b91ffc445800416::vault::LpVault<T0, T1>, arg1: &0x7e009c69fcaab269617359fc9ea2b3a308e71c82165af30f3b91ffc445800416::blast_fun_migrators::PackageVersion, arg2: &0x2136ba8efa373b04d237c4eb5154d240f526e65f27a06164e88e9513d28f50df::blast_acl::AdminWitness<0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::blast_fun_domain::BuybackAdmin>, arg3: &mut 0x2::coin_registry::Currency<T0>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0x7e009c69fcaab269617359fc9ea2b3a308e71c82165af30f3b91ffc445800416::blast_fun_migrators::assert_current(arg1);
        assert!(0x7e009c69fcaab269617359fc9ea2b3a308e71c82165af30f3b91ffc445800416::vault::pool_id<T0, T1>(arg0) == 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg5), 13835340496626647043);
        let (v0, v1) = swap_quote_for_meme<T0, T1, T2, T3>(arg5, arg4, 0x7e009c69fcaab269617359fc9ea2b3a308e71c82165af30f3b91ffc445800416::vault::take_buyback_quote<T0, T1>(arg0, arg2, arg6), is_meme_coin_a<T0, T1, T2, T3>(), arg8, arg9);
        0x7e009c69fcaab269617359fc9ea2b3a308e71c82165af30f3b91ffc445800416::vault::burn_buyback<T0, T1>(arg0, arg3, v0, v1, arg6, arg7, arg9);
    }

    fun cast<T0: store, T1: store>(arg0: &mut 0x2::object::UID, arg1: T0) : T1 {
        let v0 = CastKey{dummy_field: false};
        0x2::dynamic_field::add<CastKey, T0>(arg0, v0, arg1);
        let v1 = CastKey{dummy_field: false};
        0x2::dynamic_field::remove<CastKey, T1>(arg0, v1)
    }

    public fun collect_fees<T0, T1, T2, T3>(arg0: &mut 0x7e009c69fcaab269617359fc9ea2b3a308e71c82165af30f3b91ffc445800416::vault::LpVault<T0, T1>, arg1: &0x7e009c69fcaab269617359fc9ea2b3a308e71c82165af30f3b91ffc445800416::blast_fun_migrators::PackageVersion, arg2: &0x7e009c69fcaab269617359fc9ea2b3a308e71c82165af30f3b91ffc445800416::lp_fee_policy::LpFeePolicy, arg3: &mut 0x2::coin_registry::Currency<T0>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x7e009c69fcaab269617359fc9ea2b3a308e71c82165af30f3b91ffc445800416::blast_fun_migrators::assert_current(arg1);
        settle_fees<T0, T1, T2, T3>(arg0, arg2, arg3, arg4, arg5, arg6, is_meme_coin_a<T0, T1, T2, T3>(), arg7, arg8);
    }

    fun collect_position_fees<T0, T1, T2, T3>(arg0: &mut 0x7e009c69fcaab269617359fc9ea2b3a308e71c82165af30f3b91ffc445800416::vault::LpVault<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        assert!(0x7e009c69fcaab269617359fc9ea2b3a308e71c82165af30f3b91ffc445800416::vault::pool_id<T0, T1>(arg0) == 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg3), 13835340934713311235);
        let v0 = Venue{dummy_field: false};
        let (v1, v2) = 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::collect_fee<T2, T3>(arg2, arg1, arg3, 0x7e009c69fcaab269617359fc9ea2b3a308e71c82165af30f3b91ffc445800416::vault::position_mut<T0, T1, Venue, 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::CetusLPBurnProof>(arg0, &v0), arg5);
        let v3 = 0x2::coin::into_balance<T2>(v1);
        let v4 = 0x2::coin::into_balance<T3>(v2);
        let v5 = Venue{dummy_field: false};
        if (0x7e009c69fcaab269617359fc9ea2b3a308e71c82165af30f3b91ffc445800416::vault::has_auto_lp_position<T0, T1, Venue>(arg0, &v5)) {
            let v6 = Venue{dummy_field: false};
            let (v7, v8) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T2, T3>(arg1, arg3, 0x7e009c69fcaab269617359fc9ea2b3a308e71c82165af30f3b91ffc445800416::vault::auto_lp_position<T0, T1, Venue, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg0, &v6), true);
            0x2::balance::join<T2>(&mut v3, v7);
            0x2::balance::join<T3>(&mut v4, v8);
        };
        reorder<0x2::balance::Balance<T2>, 0x2::balance::Balance<T3>, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>>(v3, v4, arg4, arg5)
    }

    fun compound<T0, T1, T2, T3>(arg0: &mut 0x7e009c69fcaab269617359fc9ea2b3a308e71c82165af30f3b91ffc445800416::vault::LpVault<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg3: bool, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x7e009c69fcaab269617359fc9ea2b3a308e71c82165af30f3b91ffc445800416::vault::take_auto_lp<T0, T1>(arg0);
        let (v2, v3) = reorder<0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, 0x2::balance::Balance<T2>, 0x2::balance::Balance<T3>>(v0, v1, arg3, arg5);
        let (v4, v5, v6, v7) = add_liquidity<T2, T3, T0, T1>(arg0, arg1, arg2, v2, v3, arg4, arg5);
        let (v8, v9) = reorder<0x2::balance::Balance<T2>, 0x2::balance::Balance<T3>, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>>(v4, v5, arg3, arg5);
        let (v10, v11) = if (arg3) {
            (v6, v7)
        } else {
            (v7, v6)
        };
        0x7e009c69fcaab269617359fc9ea2b3a308e71c82165af30f3b91ffc445800416::vault::keep_auto_lp<T0, T1>(arg0, v10, v11, v8, v9);
    }

    fun fixed_side<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg2: u64, arg3: u64) : (bool, u64) {
        let (v0, v1) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::tick_range(arg1);
        let v2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg0);
        let v3 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg0);
        let (v4, _, v6) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_liquidity_by_amount(v0, v1, v2, v3, arg2, true);
        let (v7, v8, _) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_liquidity_by_amount(v0, v1, v2, v3, arg3, false);
        if (v4 > 0 && v6 <= arg3) {
            return (true, arg2)
        };
        if (v7 > 0 && v8 <= arg2) {
            return (false, arg3)
        };
        (true, 0)
    }

    fun is_coin_a_seed_side(arg0: u32, arg1: u32, arg2: u128, arg3: u64, arg4: u64, arg5: bool) : bool {
        let (v0, v1) = if (arg5) {
            (arg3, arg4)
        } else {
            (arg4, arg3)
        };
        let v2 = arg3 >= arg4 == arg5;
        let v3 = if (v2) {
            v0
        } else {
            v1
        };
        let (_, v5, v6) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_liquidity_by_amount(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg1), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::zero(), arg2, v3, v2);
        v5 <= v0 && v6 <= v1 && v2 || !v2
    }

    fun is_meme_coin_a<T0, T1, T2, T3>() : bool {
        let v0 = 0x1::type_name::with_original_ids<T0>();
        let v1 = 0x1::type_name::with_original_ids<T1>();
        let v2 = 0x1::type_name::with_original_ids<T2>();
        let v3 = 0x1::type_name::with_original_ids<T3>();
        assert!(v0 == v2 && v1 == v3 || v0 == v3 && v1 == v2, 13835623131244658693);
        v0 == v2
    }

    public fun migrate<T0, T1, T2, T3>(arg0: &mut 0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::launch::Launch<T0, T1>, arg1: &0x7e009c69fcaab269617359fc9ea2b3a308e71c82165af30f3b91ffc445800416::blast_fun_migrators::PackageVersion, arg2: &0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::blast_fun::PackageVersion, arg3: &mut 0x2::coin_registry::Currency<T0>, arg4: &0x7e009c69fcaab269617359fc9ea2b3a308e71c82165af30f3b91ffc445800416::venue_config::VenueConfig, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg7: &mut 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0x7e009c69fcaab269617359fc9ea2b3a308e71c82165af30f3b91ffc445800416::blast_fun_migrators::assert_current(arg1);
        assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::is_right_order<T2, T3>(), 13835058570678239233);
        let v0 = is_meme_coin_a<T0, T1, T2, T3>();
        let (v1, _) = 0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::launch::pool_tier<T0, T1>(arg0);
        let (v3, v4) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool_creator::full_range_tick_range(v1);
        let v5 = Witness{dummy_field: false};
        let (v6, v7) = 0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::launch::migrate<T0, T1, Witness>(arg0, arg2, arg3, v5, arg9);
        let v8 = v7;
        let v9 = v6;
        let v10 = 0x2::balance::value<T0>(&v9);
        let v11 = 0x2::balance::value<T1>(&v8);
        let v12 = 0x7e009c69fcaab269617359fc9ea2b3a308e71c82165af30f3b91ffc445800416::migration_math::sqrt_price_x64(v10, v11, v0);
        let v13 = 0x2::coin::from_balance<T0>(v9, arg9);
        let v14 = 0x2::coin::from_balance<T1>(v8, arg9);
        let (v15, v16) = reorder<0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x2::coin::Coin<T2>, 0x2::coin::Coin<T3>>(v13, v14, v0, arg9);
        let (v17, v18, v19) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool_creator::create_pool_v3_with_creation_cap<T2, T3>(arg5, arg6, pool_creation_cap<T0>(arg4), v1, v12, 0x1::string::utf8(b""), v3, v4, v15, v16, is_coin_a_seed_side(v3, v4, v12, v10, v11, v0), arg8, arg9);
        let (v20, v21) = reorder<0x2::coin::Coin<T2>, 0x2::coin::Coin<T3>, 0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>>(v18, v19, v0, arg9);
        burn_into_vault<T0, T1>(arg0, arg7, v17, v20, v21, arg9);
    }

    fun pool_creation_cap<T0>(arg0: &0x7e009c69fcaab269617359fc9ea2b3a308e71c82165af30f3b91ffc445800416::venue_config::VenueConfig) : &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::PoolCreationCap {
        let v0 = CreationCapKey<T0>{dummy_field: false};
        0x7e009c69fcaab269617359fc9ea2b3a308e71c82165af30f3b91ffc445800416::venue_config::object<CreationCapKey<T0>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::PoolCreationCap>(arg0, v0)
    }

    fun reorder<T0: store, T1: store, T2: store, T3: store>(arg0: T0, arg1: T1, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) : (T2, T3) {
        let v0 = 0x2::object::new(arg3);
        let (v1, v2) = if (arg2) {
            let v3 = &mut v0;
            let v4 = &mut v0;
            (cast<T0, T2>(v3, arg0), cast<T1, T3>(v4, arg1))
        } else {
            let v5 = &mut v0;
            let v6 = &mut v0;
            (cast<T1, T2>(v5, arg1), cast<T0, T3>(v6, arg0))
        };
        0x2::object::delete(v0);
        (v1, v2)
    }

    public fun settle_and_update_fee_split<T0, T1, T2, T3>(arg0: &mut 0x7e009c69fcaab269617359fc9ea2b3a308e71c82165af30f3b91ffc445800416::vault::LpVault<T0, T1>, arg1: &0x7e009c69fcaab269617359fc9ea2b3a308e71c82165af30f3b91ffc445800416::blast_fun_migrators::PackageVersion, arg2: &0x7e009c69fcaab269617359fc9ea2b3a308e71c82165af30f3b91ffc445800416::lp_fee_policy::LpFeePolicy, arg3: &0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::launch::Launch<T0, T1>, arg4: &0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::creator_authority::CurveFeeCap<T0>, arg5: &mut 0x2::coin_registry::Currency<T0>, arg6: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg7: &0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg8: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg9: 0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::allocation::FeeSplit, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        0x7e009c69fcaab269617359fc9ea2b3a308e71c82165af30f3b91ffc445800416::blast_fun_migrators::assert_current(arg1);
        0x7e009c69fcaab269617359fc9ea2b3a308e71c82165af30f3b91ffc445800416::vault::assert_fee_split_update<T0, T1>(arg0, arg3, arg4, arg9);
        settle_fees<T0, T1, T2, T3>(arg0, arg2, arg5, arg6, arg7, arg8, is_meme_coin_a<T0, T1, T2, T3>(), arg10, arg11);
        0x7e009c69fcaab269617359fc9ea2b3a308e71c82165af30f3b91ffc445800416::vault::update_fee_split<T0, T1>(arg0, arg9);
    }

    fun settle_fees<T0, T1, T2, T3>(arg0: &mut 0x7e009c69fcaab269617359fc9ea2b3a308e71c82165af30f3b91ffc445800416::vault::LpVault<T0, T1>, arg1: &0x7e009c69fcaab269617359fc9ea2b3a308e71c82165af30f3b91ffc445800416::lp_fee_policy::LpFeePolicy, arg2: &mut 0x2::coin_registry::Currency<T0>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg6: bool, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = collect_position_fees<T0, T1, T2, T3>(arg0, arg3, arg4, arg5, arg6, arg8);
        0x7e009c69fcaab269617359fc9ea2b3a308e71c82165af30f3b91ffc445800416::vault::split_fees<T0, T1>(arg0, arg1, arg2, v0, v1, arg8);
        compound<T0, T1, T2, T3>(arg0, arg3, arg5, arg6, arg7, arg8);
    }

    fun swap_quote_for_meme<T0, T1, T2, T3>(arg0: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: 0x2::balance::Balance<T1>, arg3: bool, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let (v0, v1) = reorder<0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, 0x2::balance::Balance<T2>, 0x2::balance::Balance<T3>>(0x2::balance::zero<T0>(), arg2, arg3, arg5);
        let (v2, v3) = swap<T2, T3>(arg0, arg1, v0, v1, !arg3, arg4);
        reorder<0x2::balance::Balance<T2>, 0x2::balance::Balance<T3>, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>>(v2, v3, arg3, arg5)
    }

    // decompiled from Move bytecode v7
}

