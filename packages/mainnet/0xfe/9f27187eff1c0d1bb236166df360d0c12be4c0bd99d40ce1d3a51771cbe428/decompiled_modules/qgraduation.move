module 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::qgraduation {
    struct QTokenVault<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        curve_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        token_first: bool,
        proof: 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::CetusLPBurnProof,
    }

    struct QuoteGraduated has copy, drop {
        curve_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
        quote: 0x1::ascii::String,
        token_first: bool,
        raised: u64,
        pool_quote: u64,
        pool_tokens: u64,
        creator_fee: u64,
        platform_fee: u64,
        caller_reward: u64,
        sqrt_price: u128,
        burned_tokens: u64,
        season_dust: u64,
    }

    struct QuoteHarvested has copy, drop {
        vault_id: 0x2::object::ID,
        quote_to_creator: u64,
        quote_to_platform: u64,
        caller_reward: u64,
        tokens_to_creator: u64,
    }

    public fun pool_id<T0, T1>(arg0: &QTokenVault<T0, T1>) : 0x2::object::ID {
        arg0.pool_id
    }

    fun check_vault<T0, T1>(arg0: &QTokenVault<T0, T1>, arg1: &0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::qcurve::QCurve<T0, T1>, arg2: 0x2::object::ID, arg3: bool) {
        assert!(arg0.curve_id == 0x2::object::id<0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::qcurve::QCurve<T0, T1>>(arg1), 1202);
        assert!(arg0.pool_id == arg2 && arg0.token_first == arg3, 1202);
    }

    public fun curve_id<T0, T1>(arg0: &QTokenVault<T0, T1>) : 0x2::object::ID {
        arg0.curve_id
    }

    fun finish<T0, T1>(arg0: &mut 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::qcurve::QCurve<T0, T1>, arg1: &mut 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::Treasury, arg2: &mut 0x2::coin_registry::Currency<T0>, arg3: &mut 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg4: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg5: bool, arg6: 0x2::coin::Coin<T0>, arg7: 0x2::coin::Coin<T1>, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u128, arg15: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg6);
        0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::qcurve::burn_balance<T0, T1>(arg0, 0x2::coin::into_balance<T0>(arg6));
        let v1 = 0x2::coin::value<T1>(&arg7);
        0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::deposit_quote_season<T1>(arg1, 0x2::coin::into_balance<T1>(arg7));
        0x2::coin_registry::make_supply_burn_only<T0>(arg2, 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::qcurve::take_treasury_cap<T0, T1>(arg0));
        let v2 = 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::qcurve::take_metadata_cap<T0, T1>(arg0);
        if (0x1::option::is_some<0x2::coin_registry::MetadataCap<T0>>(&v2)) {
            0x2::coin_registry::delete_metadata_cap<T0>(arg2, 0x1::option::destroy_some<0x2::coin_registry::MetadataCap<T0>>(v2));
        } else {
            0x1::option::destroy_none<0x2::coin_registry::MetadataCap<T0>>(v2);
        };
        let v3 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::pool_id(&arg4);
        let v4 = 0x2::object::id<0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::qcurve::QCurve<T0, T1>>(arg0);
        let v5 = QTokenVault<T0, T1>{
            id          : 0x2::object::new(arg15),
            curve_id    : v4,
            pool_id     : v3,
            token_first : arg5,
            proof       : 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::burn_lp_v2(arg3, arg4, arg15),
        };
        0x2::transfer::share_object<QTokenVault<T0, T1>>(v5);
        0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::qcurve::mark_graduated<T0, T1>(arg0);
        let v6 = QuoteGraduated{
            curve_id      : v4,
            pool_id       : v3,
            vault_id      : 0x2::object::id<QTokenVault<T0, T1>>(&v5),
            quote         : 0x1::type_name::into_string(0x1::type_name::get<T1>()),
            token_first   : arg5,
            raised        : arg10,
            pool_quote    : arg8 - v1,
            pool_tokens   : arg9 - v0,
            creator_fee   : arg11,
            platform_fee  : arg12,
            caller_reward : arg13,
            sqrt_price    : arg14,
            burned_tokens : v0,
            season_dust   : v1,
        };
        0x2::event::emit<QuoteGraduated>(v6);
    }

    public fun graduate_quote_first<T0, T1>(arg0: &mut 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::qcurve::QCurve<T0, T1>, arg1: &0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::Config, arg2: &mut 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::Treasury, arg3: &mut 0x2::coin_registry::Currency<T0>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg6: &mut 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::assert_version(arg1);
        assert!(!token_first<T0, T1>(), 1203);
        let (v0, v1, v2, v3, v4, v5) = settle<T0, T1>(arg0, arg2, arg8);
        let v6 = v1;
        let v7 = v0;
        let v8 = 0x2::balance::value<T1>(&v7);
        let v9 = 0x2::balance::value<T0>(&v6);
        let v10 = 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::math::sqrt_price_x64(0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::math::mul_div(v8, 10000 - 1, 10000), v9);
        let v11 = 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::curve::cetus_tick_spacing();
        let (v12, v13) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool_creator::full_range_tick_range(v11);
        let (v14, v15, v16) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool_creator::create_pool_v3_with_creation_cap<T1, T0>(arg4, arg5, 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::qcurve::pool_creation_cap<T0, T1>(arg0), v11, v10, 0x1::string::utf8(b""), v12, v13, 0x2::coin::from_balance<T1>(v7, arg8), 0x2::coin::from_balance<T0>(v6, arg8), false, arg7, arg8);
        finish<T0, T1>(arg0, arg2, arg3, arg6, v14, false, v16, v15, v8, v9, v2, v3, v4, v5, v10, arg8);
    }

    public fun graduate_token_first<T0, T1>(arg0: &mut 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::qcurve::QCurve<T0, T1>, arg1: &0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::Config, arg2: &mut 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::Treasury, arg3: &mut 0x2::coin_registry::Currency<T0>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg6: &mut 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::assert_version(arg1);
        assert!(token_first<T0, T1>(), 1203);
        let (v0, v1, v2, v3, v4, v5) = settle<T0, T1>(arg0, arg2, arg8);
        let v6 = v1;
        let v7 = v0;
        let v8 = 0x2::balance::value<T1>(&v7);
        let v9 = 0x2::balance::value<T0>(&v6);
        let v10 = 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::math::sqrt_price_x64(v9, 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::math::mul_div(v8, 10000 - 1, 10000));
        let v11 = 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::curve::cetus_tick_spacing();
        let (v12, v13) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool_creator::full_range_tick_range(v11);
        let (v14, v15, v16) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool_creator::create_pool_v3_with_creation_cap<T0, T1>(arg4, arg5, 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::qcurve::pool_creation_cap<T0, T1>(arg0), v11, v10, 0x1::string::utf8(b""), v12, v13, 0x2::coin::from_balance<T0>(v6, arg8), 0x2::coin::from_balance<T1>(v7, arg8), true, arg7, arg8);
        finish<T0, T1>(arg0, arg2, arg3, arg6, v14, true, v15, v16, v8, v9, v2, v3, v4, v5, v10, arg8);
    }

    public fun harvest_quote_first<T0, T1>(arg0: &mut QTokenVault<T0, T1>, arg1: &mut 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::qcurve::QCurve<T0, T1>, arg2: &0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::Config, arg3: &mut 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::Treasury, arg4: &0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg7: &mut 0x2::tx_context::TxContext) {
        0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::assert_version(arg2);
        check_vault<T0, T1>(arg0, arg1, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg6), false);
        let (v0, v1) = 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::collect_fee<T1, T0>(arg4, arg5, arg6, &mut arg0.proof, arg7);
        split_fees<T0, T1>(arg0, arg1, arg3, 0x2::coin::into_balance<T0>(v1), 0x2::coin::into_balance<T1>(v0), arg7);
    }

    public fun harvest_token_first<T0, T1>(arg0: &mut QTokenVault<T0, T1>, arg1: &mut 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::qcurve::QCurve<T0, T1>, arg2: &0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::Config, arg3: &mut 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::Treasury, arg4: &0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg7: &mut 0x2::tx_context::TxContext) {
        0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::assert_version(arg2);
        check_vault<T0, T1>(arg0, arg1, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg6), true);
        let (v0, v1) = 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::collect_fee<T0, T1>(arg4, arg5, arg6, &mut arg0.proof, arg7);
        split_fees<T0, T1>(arg0, arg1, arg3, 0x2::coin::into_balance<T0>(v0), 0x2::coin::into_balance<T1>(v1), arg7);
    }

    public fun is_token_first<T0, T1>(arg0: &QTokenVault<T0, T1>) : bool {
        arg0.token_first
    }

    public fun proof_id<T0, T1>(arg0: &QTokenVault<T0, T1>) : 0x2::object::ID {
        0x2::object::id<0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::CetusLPBurnProof>(&arg0.proof)
    }

    fun settle<T0, T1>(arg0: &mut 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::qcurve::QCurve<T0, T1>, arg1: &mut 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::Treasury, arg2: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<T0>, u64, u64, u64, u64) {
        assert!(0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::qcurve::is_ready_to_graduate<T0, T1>(arg0), 1201);
        let (v0, v1, v2, v3, v4, v5) = 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::qcurve::settle_graduation<T0, T1>(arg0, arg1, 50);
        let v6 = v2;
        let v7 = 0x2::balance::value<T1>(&v6);
        if (v7 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v6, arg2), 0x2::tx_context::sender(arg2));
        } else {
            0x2::balance::destroy_zero<T1>(v6);
        };
        (v0, v1, v3, v4, v5, v7)
    }

    fun split_fees<T0, T1>(arg0: &QTokenVault<T0, T1>, arg1: &mut 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::qcurve::QCurve<T0, T1>, arg2: &mut 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::Treasury, arg3: 0x2::balance::Balance<T0>, arg4: 0x2::balance::Balance<T1>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<T1>(&arg4) - 0x2::balance::value<T1>(&arg4) / 2;
        let v1 = 0x2::balance::split<T1>(&mut arg4, v0);
        let v2 = 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::math::mul_div(v0, 1000, 10000);
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v1, v2), arg5), 0x2::tx_context::sender(arg5));
        };
        0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::deposit_quote_platform<T1>(arg2, v1);
        0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::qcurve::add_creator_fee<T0, T1>(arg1, arg4);
        let v3 = 0x2::balance::value<T0>(&arg3);
        if (v3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg3, arg5), 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::qcurve::creator<T0, T1>(arg1));
        } else {
            0x2::balance::destroy_zero<T0>(arg3);
        };
        let v4 = QuoteHarvested{
            vault_id          : 0x2::object::id<QTokenVault<T0, T1>>(arg0),
            quote_to_creator  : 0x2::balance::value<T1>(&arg4),
            quote_to_platform : v0 - v2,
            caller_reward     : v2,
            tokens_to_creator : v3,
        };
        0x2::event::emit<QuoteHarvested>(v4);
    }

    public fun token_first<T0, T1>() : bool {
        let v0 = 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>()));
        let v1 = 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T1>()));
        let v2 = 0x1::vector::length<u8>(&v0);
        let v3 = 0x1::vector::length<u8>(&v1);
        let v4 = 0;
        while (v4 < v2 && v4 < v3) {
            if (*0x1::vector::borrow<u8>(&v0, v4) != *0x1::vector::borrow<u8>(&v1, v4)) {
                return *0x1::vector::borrow<u8>(&v0, v4) > *0x1::vector::borrow<u8>(&v1, v4)
            };
            v4 = v4 + 1;
        };
        v2 > v3
    }

    // decompiled from Move bytecode v7
}

