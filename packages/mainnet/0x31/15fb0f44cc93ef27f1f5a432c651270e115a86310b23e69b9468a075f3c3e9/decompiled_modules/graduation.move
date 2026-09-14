module 0x3115fb0f44cc93ef27f1f5a432c651270e115a86310b23e69b9468a075f3c3e9::graduation {
    struct TokenVault<phantom T0> has key {
        id: 0x2::object::UID,
        curve_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        proof: 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::CetusLPBurnProof,
    }

    struct Graduated has copy, drop {
        curve_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
        raised: u64,
        pool_sui: u64,
        pool_tokens: u64,
        creator_fee: u64,
        platform_fee: u64,
        caller_reward: u64,
        sqrt_price: u128,
        burned_tokens: u64,
        season_dust: u64,
    }

    struct Harvested has copy, drop {
        vault_id: 0x2::object::ID,
        sui_to_creator: u64,
        sui_to_platform: u64,
        caller_reward: u64,
        tokens_to_creator: u64,
    }

    public fun pool_id<T0>(arg0: &TokenVault<T0>) : 0x2::object::ID {
        arg0.pool_id
    }

    public fun curve_id<T0>(arg0: &TokenVault<T0>) : 0x2::object::ID {
        arg0.curve_id
    }

    public fun graduate<T0>(arg0: &mut 0x3115fb0f44cc93ef27f1f5a432c651270e115a86310b23e69b9468a075f3c3e9::curve::Curve<T0>, arg1: &0x3115fb0f44cc93ef27f1f5a432c651270e115a86310b23e69b9468a075f3c3e9::config::Config, arg2: &mut 0x3115fb0f44cc93ef27f1f5a432c651270e115a86310b23e69b9468a075f3c3e9::config::Treasury, arg3: &mut 0x2::coin_registry::Currency<T0>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg6: &mut 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x3115fb0f44cc93ef27f1f5a432c651270e115a86310b23e69b9468a075f3c3e9::config::assert_version(arg1);
        graduate_internal<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    fun graduate_internal<T0>(arg0: &mut 0x3115fb0f44cc93ef27f1f5a432c651270e115a86310b23e69b9468a075f3c3e9::curve::Curve<T0>, arg1: &0x3115fb0f44cc93ef27f1f5a432c651270e115a86310b23e69b9468a075f3c3e9::config::Config, arg2: &mut 0x3115fb0f44cc93ef27f1f5a432c651270e115a86310b23e69b9468a075f3c3e9::config::Treasury, arg3: &mut 0x2::coin_registry::Currency<T0>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg6: &mut 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(!0x3115fb0f44cc93ef27f1f5a432c651270e115a86310b23e69b9468a075f3c3e9::config::is_sell_only(arg1), 502);
        assert!(0x3115fb0f44cc93ef27f1f5a432c651270e115a86310b23e69b9468a075f3c3e9::curve::is_ready_to_graduate<T0>(arg0), 501);
        let (v0, v1, v2, v3, v4, v5) = 0x3115fb0f44cc93ef27f1f5a432c651270e115a86310b23e69b9468a075f3c3e9::curve::settle_graduation<T0>(arg0, arg2, 100000000);
        let v6 = v2;
        let v7 = v1;
        let v8 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v6, arg8), 0x2::tx_context::sender(arg8));
        let v9 = 0x2::balance::value<0x2::sui::SUI>(&v8);
        let v10 = 0x2::balance::value<T0>(&v7);
        let v11 = 0x3115fb0f44cc93ef27f1f5a432c651270e115a86310b23e69b9468a075f3c3e9::math::sqrt_price_x64(v10, 0x3115fb0f44cc93ef27f1f5a432c651270e115a86310b23e69b9468a075f3c3e9::math::mul_div(v9, 10000 - 1, 10000));
        let v12 = 0x3115fb0f44cc93ef27f1f5a432c651270e115a86310b23e69b9468a075f3c3e9::curve::cetus_tick_spacing();
        let (v13, v14) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool_creator::full_range_tick_range(v12);
        let (v15, v16, v17) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool_creator::create_pool_v3_with_creation_cap<T0, 0x2::sui::SUI>(arg4, arg5, 0x3115fb0f44cc93ef27f1f5a432c651270e115a86310b23e69b9468a075f3c3e9::curve::pool_creation_cap<T0>(arg0), v12, v11, 0x1::string::utf8(b""), v13, v14, 0x2::coin::from_balance<T0>(v7, arg8), 0x2::coin::from_balance<0x2::sui::SUI>(v8, arg8), true, arg7, arg8);
        let v18 = v17;
        let v19 = v16;
        let v20 = v15;
        let v21 = 0x2::coin::value<T0>(&v19);
        0x3115fb0f44cc93ef27f1f5a432c651270e115a86310b23e69b9468a075f3c3e9::curve::burn_balance<T0>(arg0, 0x2::coin::into_balance<T0>(v19));
        let v22 = 0x2::coin::value<0x2::sui::SUI>(&v18);
        0x3115fb0f44cc93ef27f1f5a432c651270e115a86310b23e69b9468a075f3c3e9::config::deposit_season(arg2, 0x2::coin::into_balance<0x2::sui::SUI>(v18));
        0x2::coin_registry::make_supply_burn_only<T0>(arg3, 0x3115fb0f44cc93ef27f1f5a432c651270e115a86310b23e69b9468a075f3c3e9::curve::take_treasury_cap<T0>(arg0));
        let v23 = 0x3115fb0f44cc93ef27f1f5a432c651270e115a86310b23e69b9468a075f3c3e9::curve::take_metadata_cap<T0>(arg0);
        if (0x1::option::is_some<0x2::coin_registry::MetadataCap<T0>>(&v23)) {
            0x2::coin_registry::delete_metadata_cap<T0>(arg3, 0x1::option::destroy_some<0x2::coin_registry::MetadataCap<T0>>(v23));
        } else {
            0x1::option::destroy_none<0x2::coin_registry::MetadataCap<T0>>(v23);
        };
        let v24 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::pool_id(&v20);
        let v25 = 0x2::object::id<0x3115fb0f44cc93ef27f1f5a432c651270e115a86310b23e69b9468a075f3c3e9::curve::Curve<T0>>(arg0);
        let v26 = TokenVault<T0>{
            id       : 0x2::object::new(arg8),
            curve_id : v25,
            pool_id  : v24,
            proof    : 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::burn_lp_v2(arg6, v20, arg8),
        };
        0x2::transfer::share_object<TokenVault<T0>>(v26);
        0x3115fb0f44cc93ef27f1f5a432c651270e115a86310b23e69b9468a075f3c3e9::curve::mark_graduated<T0>(arg0);
        let v27 = Graduated{
            curve_id      : v25,
            pool_id       : v24,
            vault_id      : 0x2::object::id<TokenVault<T0>>(&v26),
            raised        : v3,
            pool_sui      : v9 - v22,
            pool_tokens   : v10 - v21,
            creator_fee   : v4,
            platform_fee  : v5,
            caller_reward : 0x2::balance::value<0x2::sui::SUI>(&v6),
            sqrt_price    : v11,
            burned_tokens : v21,
            season_dust   : v22,
        };
        0x2::event::emit<Graduated>(v27);
    }

    public fun harvest<T0>(arg0: &mut TokenVault<T0>, arg1: &mut 0x3115fb0f44cc93ef27f1f5a432c651270e115a86310b23e69b9468a075f3c3e9::curve::Curve<T0>, arg2: &0x3115fb0f44cc93ef27f1f5a432c651270e115a86310b23e69b9468a075f3c3e9::config::Config, arg3: &mut 0x3115fb0f44cc93ef27f1f5a432c651270e115a86310b23e69b9468a075f3c3e9::config::Treasury, arg4: &0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg7: &mut 0x2::tx_context::TxContext) {
        0x3115fb0f44cc93ef27f1f5a432c651270e115a86310b23e69b9468a075f3c3e9::config::assert_version(arg2);
        harvest_internal<T0>(arg0, arg1, arg3, arg4, arg5, arg6, arg7);
    }

    fun harvest_internal<T0>(arg0: &mut TokenVault<T0>, arg1: &mut 0x3115fb0f44cc93ef27f1f5a432c651270e115a86310b23e69b9468a075f3c3e9::curve::Curve<T0>, arg2: &mut 0x3115fb0f44cc93ef27f1f5a432c651270e115a86310b23e69b9468a075f3c3e9::config::Treasury, arg3: &0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.curve_id == 0x2::object::id<0x3115fb0f44cc93ef27f1f5a432c651270e115a86310b23e69b9468a075f3c3e9::curve::Curve<T0>>(arg1), 503);
        assert!(0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>>(arg5) == arg0.pool_id, 503);
        let (v0, v1) = 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::collect_fee<T0, 0x2::sui::SUI>(arg3, arg4, arg5, &mut arg0.proof, arg6);
        let v2 = 0x2::coin::into_balance<0x2::sui::SUI>(v1);
        let v3 = 0x2::balance::value<0x2::sui::SUI>(&v2) - 0x2::balance::value<0x2::sui::SUI>(&v2) / 2;
        let v4 = 0x2::balance::split<0x2::sui::SUI>(&mut v2, v3);
        let v5 = 0x3115fb0f44cc93ef27f1f5a432c651270e115a86310b23e69b9468a075f3c3e9::math::mul_div(v3, 1000, 10000);
        if (v5 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v4, v5), arg6), 0x2::tx_context::sender(arg6));
        };
        0x3115fb0f44cc93ef27f1f5a432c651270e115a86310b23e69b9468a075f3c3e9::config::deposit_platform(arg2, v4);
        0x3115fb0f44cc93ef27f1f5a432c651270e115a86310b23e69b9468a075f3c3e9::curve::add_creator_fee<T0>(arg1, v2);
        let (v6, _, _) = 0x3115fb0f44cc93ef27f1f5a432c651270e115a86310b23e69b9468a075f3c3e9::curve::fee_mode<T0>(arg1);
        let v9 = 0x2::coin::into_balance<T0>(v0);
        if (v6 < 10000) {
            0x3115fb0f44cc93ef27f1f5a432c651270e115a86310b23e69b9468a075f3c3e9::curve::stash_tokens_to_burn<T0>(arg1, 0x2::balance::split<T0>(&mut v9, 0x2::balance::value<T0>(&v9) - 0x3115fb0f44cc93ef27f1f5a432c651270e115a86310b23e69b9468a075f3c3e9::math::mul_div(0x2::balance::value<T0>(&v9), v6, 10000)));
        };
        let v10 = 0x2::balance::value<T0>(&v9);
        if (v10 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v9, arg6), 0x3115fb0f44cc93ef27f1f5a432c651270e115a86310b23e69b9468a075f3c3e9::curve::creator<T0>(arg1));
        } else {
            0x2::balance::destroy_zero<T0>(v9);
        };
        let v11 = Harvested{
            vault_id          : 0x2::object::id<TokenVault<T0>>(arg0),
            sui_to_creator    : 0x2::balance::value<0x2::sui::SUI>(&v2),
            sui_to_platform   : v3 - v5,
            caller_reward     : v5,
            tokens_to_creator : v10,
        };
        0x2::event::emit<Harvested>(v11);
    }

    public fun proof_id<T0>(arg0: &TokenVault<T0>) : 0x2::object::ID {
        0x2::object::id<0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::CetusLPBurnProof>(&arg0.proof)
    }

    // decompiled from Move bytecode v7
}

