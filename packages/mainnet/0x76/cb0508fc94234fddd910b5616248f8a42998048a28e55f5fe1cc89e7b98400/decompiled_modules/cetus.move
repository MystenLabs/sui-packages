module 0x76cb0508fc94234fddd910b5616248f8a42998048a28e55f5fe1cc89e7b98400::cetus {
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

    public fun new<T0, T1>(arg0: 0x2::coin::TreasuryCap<T0>, arg1: &mut 0x2::coin_registry::Currency<T0>, arg2: u64, arg3: 0x76cb0508fc94234fddd910b5616248f8a42998048a28e55f5fe1cc89e7b98400::bps::Bps, arg4: 0x76cb0508fc94234fddd910b5616248f8a42998048a28e55f5fe1cc89e7b98400::bps::Bps, arg5: vector<0x76cb0508fc94234fddd910b5616248f8a42998048a28e55f5fe1cc89e7b98400::blast_presale::RecipientShare>, arg6: bool, arg7: u64, arg8: vector<0x76cb0508fc94234fddd910b5616248f8a42998048a28e55f5fe1cc89e7b98400::blast_presale::RecipientShare>, arg9: u64, arg10: u64, arg11: 0x76cb0508fc94234fddd910b5616248f8a42998048a28e55f5fe1cc89e7b98400::blast_presale::EligibilityPolicy, arg12: 0x1::option::Option<0x76cb0508fc94234fddd910b5616248f8a42998048a28e55f5fe1cc89e7b98400::blast_presale::UncappedPhase>, arg13: vector<0x76cb0508fc94234fddd910b5616248f8a42998048a28e55f5fe1cc89e7b98400::blast_presale::RecipientShare>, arg14: 0x76cb0508fc94234fddd910b5616248f8a42998048a28e55f5fe1cc89e7b98400::bps::Bps, arg15: &0x76cb0508fc94234fddd910b5616248f8a42998048a28e55f5fe1cc89e7b98400::creation_policy::CreationPolicy, arg16: &0x76cb0508fc94234fddd910b5616248f8a42998048a28e55f5fe1cc89e7b98400::fee_policy::FeePolicy, arg17: &mut 0x76cb0508fc94234fddd910b5616248f8a42998048a28e55f5fe1cc89e7b98400::venue_config::VenueConfig, arg18: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg19: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg20: u32, arg21: &mut 0x2::tx_context::TxContext) : (0x76cb0508fc94234fddd910b5616248f8a42998048a28e55f5fe1cc89e7b98400::blast_presale::Presale<T0, T1>, 0x76cb0508fc94234fddd910b5616248f8a42998048a28e55f5fe1cc89e7b98400::blast_presale::PresaleCap) {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::mint_pool_creation_cap<T0>(arg18, arg19, &mut arg0, arg21);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::register_permission_pair<T0, T1>(arg18, arg19, arg20, &v0, arg21);
        let v1 = CreationCapKey<T0>{dummy_field: false};
        0x76cb0508fc94234fddd910b5616248f8a42998048a28e55f5fe1cc89e7b98400::venue_config::add_object<CreationCapKey<T0>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::PoolCreationCap>(arg17, v1, v0);
        let v2 = Witness{dummy_field: false};
        0x76cb0508fc94234fddd910b5616248f8a42998048a28e55f5fe1cc89e7b98400::blast_presale::new<T0, T1, Witness>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, v2, arg20, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::get_fee_rate(arg20, arg18), arg13, arg14, arg15, arg16, arg21)
    }

    public fun migrate<T0, T1, T2, T3>(arg0: &mut 0x76cb0508fc94234fddd910b5616248f8a42998048a28e55f5fe1cc89e7b98400::blast_presale::Presale<T0, T1>, arg1: &0x76cb0508fc94234fddd910b5616248f8a42998048a28e55f5fe1cc89e7b98400::fee_policy::FeePolicy, arg2: &0x76cb0508fc94234fddd910b5616248f8a42998048a28e55f5fe1cc89e7b98400::venue_config::VenueConfig, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg5: &mut 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::is_right_order<T2, T3>(), 13835058476188958721);
        let v0 = meme_is_coin_a<T0, T1, T2, T3>();
        let (v1, _) = 0x76cb0508fc94234fddd910b5616248f8a42998048a28e55f5fe1cc89e7b98400::blast_presale::pool_tier<T0, T1>(arg0);
        let v3 = Witness{dummy_field: false};
        let (v4, v5) = 0x76cb0508fc94234fddd910b5616248f8a42998048a28e55f5fe1cc89e7b98400::blast_presale::migrate<T0, T1, Witness>(arg0, arg1, v3, arg6, arg7);
        let v6 = v5;
        let v7 = v4;
        let v8 = 0x2::balance::value<T0>(&v7);
        let v9 = 0x2::balance::value<T1>(&v6);
        let (v10, v11) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool_creator::full_range_tick_range(v1);
        let v12 = 0x76cb0508fc94234fddd910b5616248f8a42998048a28e55f5fe1cc89e7b98400::migration_math::sqrt_price_x64(v8, v9, v0);
        let v13 = 0x2::object::new(arg7);
        let v14 = &mut v13;
        let (v15, v16) = cast_pair<0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, 0x2::balance::Balance<T2>, 0x2::balance::Balance<T3>>(v14, v7, v6, v0);
        let (v17, v18, v19) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool_creator::create_pool_v3_with_creation_cap<T2, T3>(arg3, arg4, pool_creation_cap<T0>(arg2), v1, v12, 0x1::string::utf8(b""), v10, v11, 0x2::coin::from_balance<T2>(v15, arg7), 0x2::coin::from_balance<T3>(v16, arg7), fixed_side_is_a(v10, v11, v12, v8, v9, v0), arg6, arg7);
        let v20 = &mut v13;
        let (v21, v22) = cast_pair<0x2::coin::Coin<T2>, 0x2::coin::Coin<T3>, 0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>>(v20, v18, v19, v0);
        0x2::object::delete(v13);
        burn_into_vault<T0, T1>(arg0, arg5, v17, v21, v22, arg7);
    }

    fun burn_into_vault<T0, T1>(arg0: &0x76cb0508fc94234fddd910b5616248f8a42998048a28e55f5fe1cc89e7b98400::blast_presale::Presale<T0, T1>, arg1: &mut 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg2: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = Venue{dummy_field: false};
        0x76cb0508fc94234fddd910b5616248f8a42998048a28e55f5fe1cc89e7b98400::presale_vault::create<T0, T1, Venue, 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::CetusLPBurnProof>(arg0, &v0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::pool_id(&arg2), 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::burn_lp_v2(arg1, arg2, arg5), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(&arg2), 0x2::coin::into_balance<T0>(arg3), 0x2::coin::into_balance<T1>(arg4), arg5);
    }

    fun cast<T0: store, T1: store>(arg0: &mut 0x2::object::UID, arg1: T0) : T1 {
        let v0 = CastKey{dummy_field: false};
        0x2::dynamic_field::add<CastKey, T0>(arg0, v0, arg1);
        let v1 = CastKey{dummy_field: false};
        0x2::dynamic_field::remove<CastKey, T1>(arg0, v1)
    }

    fun cast_pair<T0: store, T1: store, T2: store, T3: store>(arg0: &mut 0x2::object::UID, arg1: T0, arg2: T1, arg3: bool) : (T2, T3) {
        if (arg3) {
            let v2 = cast<T0, T2>(arg0, arg1);
            (v2, cast<T1, T3>(arg0, arg2))
        } else {
            let v3 = cast<T1, T2>(arg0, arg2);
            (v3, cast<T0, T3>(arg0, arg1))
        }
    }

    public fun collect_fees<T0, T1, T2, T3>(arg0: &mut 0x76cb0508fc94234fddd910b5616248f8a42998048a28e55f5fe1cc89e7b98400::presale_vault::PresaleVault<T0, T1>, arg1: &0x76cb0508fc94234fddd910b5616248f8a42998048a28e55f5fe1cc89e7b98400::fee_policy::FeePolicy, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x76cb0508fc94234fddd910b5616248f8a42998048a28e55f5fe1cc89e7b98400::presale_vault::pool_id<T0, T1>(arg0) == 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg4), 13835340221748740099);
        let v0 = Venue{dummy_field: false};
        let (v1, v2) = 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::collect_fee<T2, T3>(arg3, arg2, arg4, 0x76cb0508fc94234fddd910b5616248f8a42998048a28e55f5fe1cc89e7b98400::presale_vault::position_mut<T0, T1, Venue, 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::CetusLPBurnProof>(arg0, &v0), arg5);
        let v3 = 0x2::object::new(arg5);
        let v4 = &mut v3;
        let (v5, v6) = cast_pair<0x2::coin::Coin<T2>, 0x2::coin::Coin<T3>, 0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>>(v4, v1, v2, meme_is_coin_a<T0, T1, T2, T3>());
        0x2::object::delete(v3);
        0x76cb0508fc94234fddd910b5616248f8a42998048a28e55f5fe1cc89e7b98400::presale_vault::split_fees<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(v5), 0x2::coin::into_balance<T1>(v6), arg5);
    }

    fun fixed_side_is_a(arg0: u32, arg1: u32, arg2: u128, arg3: u64, arg4: u64, arg5: bool) : bool {
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

    fun meme_is_coin_a<T0, T1, T2, T3>() : bool {
        let v0 = 0x1::type_name::with_original_ids<T0>();
        let v1 = 0x1::type_name::with_original_ids<T1>();
        let v2 = 0x1::type_name::with_original_ids<T2>();
        let v3 = 0x1::type_name::with_original_ids<T3>();
        assert!(v0 == v2 && v1 == v3 || v0 == v3 && v1 == v2, 13835621816984666117);
        v0 == v2
    }

    fun pool_creation_cap<T0>(arg0: &0x76cb0508fc94234fddd910b5616248f8a42998048a28e55f5fe1cc89e7b98400::venue_config::VenueConfig) : &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::PoolCreationCap {
        let v0 = CreationCapKey<T0>{dummy_field: false};
        0x76cb0508fc94234fddd910b5616248f8a42998048a28e55f5fe1cc89e7b98400::venue_config::object<CreationCapKey<T0>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::PoolCreationCap>(arg0, v0)
    }

    // decompiled from Move bytecode v7
}

