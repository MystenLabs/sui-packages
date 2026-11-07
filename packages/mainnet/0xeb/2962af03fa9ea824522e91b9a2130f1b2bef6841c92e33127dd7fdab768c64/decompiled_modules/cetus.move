module 0xeb2962af03fa9ea824522e91b9a2130f1b2bef6841c92e33127dd7fdab768c64::cetus {
    struct Venue has drop {
        dummy_field: bool,
    }

    struct CreationCapKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct PoolTierKey<phantom T0> has copy, drop, store {
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

    fun add_liquidity<T0, T1, T2, T3>(arg0: &mut 0x35ea07f57ab632fc215b06e9ae5a3f822764132de72f7a3351acafa037e41b80::vault::Vault<T2, T3>, arg1: &0x7c323cdc962a2875a255ac79cd2fc595dc0a491beed896652fd5182b1820662b::package_version::PackageVersion<0x35ea07f57ab632fc215b06e9ae5a3f822764132de72f7a3351acafa037e41b80::blast_vault_package::BLAST_VAULT_PACKAGE>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: 0x2::balance::Balance<T0>, arg5: 0x2::balance::Balance<T1>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        if (0x2::balance::value<T0>(&arg4) == 0 || 0x2::balance::value<T1>(&arg5) == 0) {
            return (arg4, arg5)
        };
        let v0 = Venue{dummy_field: false};
        if (!0x35ea07f57ab632fc215b06e9ae5a3f822764132de72f7a3351acafa037e41b80::vault::has_auto_lp_position<T2, T3, Venue>(arg0, &v0)) {
            let (v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool_creator::full_range_tick_range(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::tick_spacing<T0, T1>(arg3));
            let v3 = Venue{dummy_field: false};
            0x35ea07f57ab632fc215b06e9ae5a3f822764132de72f7a3351acafa037e41b80::vault::attach_auto_lp_position<T2, T3, Venue, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg0, &v3, arg1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::open_position<T0, T1>(arg2, arg3, v1, v2, arg7));
        };
        let v4 = Venue{dummy_field: false};
        let v5 = 0x35ea07f57ab632fc215b06e9ae5a3f822764132de72f7a3351acafa037e41b80::vault::auto_lp_position_mut<T2, T3, Venue, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg0, &v4, arg1);
        let (v6, v7) = fixed_side<T0, T1>(arg3, v5, 0x2::balance::value<T0>(&arg4), 0x2::balance::value<T1>(&arg5));
        if (v7 == 0) {
            return (arg4, arg5)
        };
        let v8 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<T0, T1>(arg2, arg3, v5, v7, v6, arg6);
        let (v9, v10) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<T0, T1>(&v8);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T0, T1>(arg2, arg3, 0x2::balance::split<T0>(&mut arg4, v9), 0x2::balance::split<T1>(&mut arg5, v10), v8);
        (arg4, arg5)
    }

    public fun buyback_and_burn<T0, T1, T2, T3>(arg0: &mut 0x35ea07f57ab632fc215b06e9ae5a3f822764132de72f7a3351acafa037e41b80::vault::Vault<T0, T1>, arg1: &0x7c323cdc962a2875a255ac79cd2fc595dc0a491beed896652fd5182b1820662b::package_version::PackageVersion<0xeb2962af03fa9ea824522e91b9a2130f1b2bef6841c92e33127dd7fdab768c64::blast_migrators::BLAST_MIGRATORS>, arg2: &0x7c323cdc962a2875a255ac79cd2fc595dc0a491beed896652fd5182b1820662b::package_version::PackageVersion<0x35ea07f57ab632fc215b06e9ae5a3f822764132de72f7a3351acafa037e41b80::blast_vault_package::BLAST_VAULT_PACKAGE>, arg3: &0x7c323cdc962a2875a255ac79cd2fc595dc0a491beed896652fd5182b1820662b::blast_acl::AdminWitness<0xf02c2127356906e1fa184be1f065c71df0adfe693ecd9279cedcacc6aa66216::blast_domain::BuybackAdmin>, arg4: &mut 0x2::coin_registry::Currency<T0>, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        0x7c323cdc962a2875a255ac79cd2fc595dc0a491beed896652fd5182b1820662b::package_version::assert_current<0xeb2962af03fa9ea824522e91b9a2130f1b2bef6841c92e33127dd7fdab768c64::blast_migrators::BLAST_MIGRATORS>(arg1, 1);
        assert!(0x35ea07f57ab632fc215b06e9ae5a3f822764132de72f7a3351acafa037e41b80::vault::pool_id<T0, T1>(arg0) == 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg6), 1);
        let v0 = Venue{dummy_field: false};
        let (v1, v2) = 0x35ea07f57ab632fc215b06e9ae5a3f822764132de72f7a3351acafa037e41b80::vault::take_buyback_quote<T0, T1, Venue>(arg0, &v0, arg3, arg2, arg7);
        let (v3, v4) = swap_quote_for_meme<T0, T1, T2, T3>(arg6, arg5, v1, is_meme_coin_a<T0, T1, T2, T3>(), arg9, arg10);
        let v5 = Venue{dummy_field: false};
        0x35ea07f57ab632fc215b06e9ae5a3f822764132de72f7a3351acafa037e41b80::vault::burn_buyback<T0, T1, Venue>(arg0, &v5, arg2, v2, arg4, v3, v4, arg8, arg10);
    }

    fun cast<T0: store, T1: store>(arg0: &mut 0x2::object::UID, arg1: T0) : T1 {
        let v0 = CastKey{dummy_field: false};
        0x2::dynamic_field::add<CastKey, T0>(arg0, v0, arg1);
        let v1 = CastKey{dummy_field: false};
        0x2::dynamic_field::remove<CastKey, T1>(arg0, v1)
    }

    public fun collect_fees<T0, T1, T2, T3>(arg0: &mut 0x35ea07f57ab632fc215b06e9ae5a3f822764132de72f7a3351acafa037e41b80::vault::Vault<T0, T1>, arg1: &0x7c323cdc962a2875a255ac79cd2fc595dc0a491beed896652fd5182b1820662b::package_version::PackageVersion<0xeb2962af03fa9ea824522e91b9a2130f1b2bef6841c92e33127dd7fdab768c64::blast_migrators::BLAST_MIGRATORS>, arg2: &0x7c323cdc962a2875a255ac79cd2fc595dc0a491beed896652fd5182b1820662b::package_version::PackageVersion<0x35ea07f57ab632fc215b06e9ae5a3f822764132de72f7a3351acafa037e41b80::blast_vault_package::BLAST_VAULT_PACKAGE>, arg3: &0xf02c2127356906e1fa184be1f065c71df0adfe693ecd9279cedcacc6aa66216::blast_treasury::Treasury, arg4: &mut 0x2::coin_registry::Currency<T0>, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg8: &mut 0x2::tx_context::TxContext) {
        0x7c323cdc962a2875a255ac79cd2fc595dc0a491beed896652fd5182b1820662b::package_version::assert_current<0xeb2962af03fa9ea824522e91b9a2130f1b2bef6841c92e33127dd7fdab768c64::blast_migrators::BLAST_MIGRATORS>(arg1, 1);
        settle_fees<T0, T1, T2, T3>(arg0, arg2, arg3, arg4, arg5, arg6, arg7, is_meme_coin_a<T0, T1, T2, T3>(), arg8);
    }

    fun collect_position_fees<T0, T1, T2, T3>(arg0: &mut 0x35ea07f57ab632fc215b06e9ae5a3f822764132de72f7a3351acafa037e41b80::vault::Vault<T0, T1>, arg1: &0x7c323cdc962a2875a255ac79cd2fc595dc0a491beed896652fd5182b1820662b::package_version::PackageVersion<0x35ea07f57ab632fc215b06e9ae5a3f822764132de72f7a3351acafa037e41b80::blast_vault_package::BLAST_VAULT_PACKAGE>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        assert!(0x35ea07f57ab632fc215b06e9ae5a3f822764132de72f7a3351acafa037e41b80::vault::pool_id<T0, T1>(arg0) == 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg4), 1);
        let v0 = Venue{dummy_field: false};
        let (v1, v2) = 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::collect_fee<T2, T3>(arg3, arg2, arg4, 0x35ea07f57ab632fc215b06e9ae5a3f822764132de72f7a3351acafa037e41b80::vault::position_mut<T0, T1, Venue, 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::CetusLPBurnProof>(arg0, &v0, arg1), arg6);
        let v3 = 0x2::coin::into_balance<T2>(v1);
        let v4 = 0x2::coin::into_balance<T3>(v2);
        let v5 = Venue{dummy_field: false};
        if (0x35ea07f57ab632fc215b06e9ae5a3f822764132de72f7a3351acafa037e41b80::vault::has_auto_lp_position<T0, T1, Venue>(arg0, &v5)) {
            let v6 = Venue{dummy_field: false};
            let (v7, v8) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T2, T3>(arg2, arg4, 0x35ea07f57ab632fc215b06e9ae5a3f822764132de72f7a3351acafa037e41b80::vault::auto_lp_position<T0, T1, Venue, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg0, &v6), true);
            0x2::balance::join<T2>(&mut v3, v7);
            0x2::balance::join<T3>(&mut v4, v8);
        };
        reorder<0x2::balance::Balance<T2>, 0x2::balance::Balance<T3>, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>>(v3, v4, arg5, arg6)
    }

    fun compound<T0, T1, T2, T3>(arg0: &mut 0x35ea07f57ab632fc215b06e9ae5a3f822764132de72f7a3351acafa037e41b80::vault::Vault<T0, T1>, arg1: &0x7c323cdc962a2875a255ac79cd2fc595dc0a491beed896652fd5182b1820662b::package_version::PackageVersion<0x35ea07f57ab632fc215b06e9ae5a3f822764132de72f7a3351acafa037e41b80::blast_vault_package::BLAST_VAULT_PACKAGE>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg4: bool, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = Venue{dummy_field: false};
        let (v1, v2, v3) = 0x35ea07f57ab632fc215b06e9ae5a3f822764132de72f7a3351acafa037e41b80::vault::take_auto_lp<T0, T1, Venue>(arg0, &v0, arg1);
        let (v4, v5) = reorder<0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, 0x2::balance::Balance<T2>, 0x2::balance::Balance<T3>>(v1, v2, arg4, arg6);
        let (v6, v7) = add_liquidity<T2, T3, T0, T1>(arg0, arg1, arg2, arg3, v4, v5, arg5, arg6);
        let (v8, v9) = reorder<0x2::balance::Balance<T2>, 0x2::balance::Balance<T3>, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>>(v6, v7, arg4, arg6);
        let v10 = Venue{dummy_field: false};
        0x35ea07f57ab632fc215b06e9ae5a3f822764132de72f7a3351acafa037e41b80::vault::keep_auto_lp<T0, T1, Venue>(arg0, &v10, arg1, v3, v8, v9);
    }

    entry fun compound_auto_lp<T0, T1, T2, T3>(arg0: &mut 0x35ea07f57ab632fc215b06e9ae5a3f822764132de72f7a3351acafa037e41b80::vault::Vault<T0, T1>, arg1: &0x7c323cdc962a2875a255ac79cd2fc595dc0a491beed896652fd5182b1820662b::package_version::PackageVersion<0xeb2962af03fa9ea824522e91b9a2130f1b2bef6841c92e33127dd7fdab768c64::blast_migrators::BLAST_MIGRATORS>, arg2: &0x7c323cdc962a2875a255ac79cd2fc595dc0a491beed896652fd5182b1820662b::package_version::PackageVersion<0x35ea07f57ab632fc215b06e9ae5a3f822764132de72f7a3351acafa037e41b80::blast_vault_package::BLAST_VAULT_PACKAGE>, arg3: &0x7c323cdc962a2875a255ac79cd2fc595dc0a491beed896652fd5182b1820662b::blast_acl::ACL, arg4: &0x7c323cdc962a2875a255ac79cd2fc595dc0a491beed896652fd5182b1820662b::blast_acl::AdminCap, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg7: u128, arg8: u128, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        0x7c323cdc962a2875a255ac79cd2fc595dc0a491beed896652fd5182b1820662b::package_version::assert_current<0xeb2962af03fa9ea824522e91b9a2130f1b2bef6841c92e33127dd7fdab768c64::blast_migrators::BLAST_MIGRATORS>(arg1, 1);
        0x7c323cdc962a2875a255ac79cd2fc595dc0a491beed896652fd5182b1820662b::blast_acl::sign_in<0xf02c2127356906e1fa184be1f065c71df0adfe693ecd9279cedcacc6aa66216::blast_domain::AutoLpAdmin>(arg3, arg4);
        assert!(arg7 > 0 && arg7 <= arg8, 5);
        assert!(0x35ea07f57ab632fc215b06e9ae5a3f822764132de72f7a3351acafa037e41b80::vault::pool_id<T0, T1>(arg0) == 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(&arg6), 1);
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T2, T3>(&arg6);
        assert!(arg7 <= v0 && v0 <= arg8, 5);
        let v1 = &mut arg6;
        compound<T0, T1, T2, T3>(arg0, arg2, arg5, v1, is_meme_coin_a<T0, T1, T2, T3>(), arg9, arg10);
        0x2::transfer::public_share_object<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg6);
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
        seed_fixed_side(v2, v0, v1, v5, v6)
    }

    fun is_meme_coin_a<T0, T1, T2, T3>() : bool {
        let v0 = 0x1::type_name::with_original_ids<T0>();
        let v1 = 0x1::type_name::with_original_ids<T1>();
        let v2 = 0x1::type_name::with_original_ids<T2>();
        let v3 = 0x1::type_name::with_original_ids<T3>();
        assert!(v0 == v2 && v1 == v3 || v0 == v3 && v1 == v2, 2);
        v0 == v2
    }

    public fun migrate<T0, T1, T2, T3>(arg0: 0xf02c2127356906e1fa184be1f065c71df0adfe693ecd9279cedcacc6aa66216::migration::Migration<T0, T1>, arg1: &0x7c323cdc962a2875a255ac79cd2fc595dc0a491beed896652fd5182b1820662b::package_version::PackageVersion<0xeb2962af03fa9ea824522e91b9a2130f1b2bef6841c92e33127dd7fdab768c64::blast_migrators::BLAST_MIGRATORS>, arg2: &0xeb2962af03fa9ea824522e91b9a2130f1b2bef6841c92e33127dd7fdab768c64::venue_config::VenueConfig, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg5: &mut 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg6: &mut 0x35ea07f57ab632fc215b06e9ae5a3f822764132de72f7a3351acafa037e41b80::blast_vault_package::VaultRegistry, arg7: &0x7c323cdc962a2875a255ac79cd2fc595dc0a491beed896652fd5182b1820662b::package_version::PackageVersion<0x35ea07f57ab632fc215b06e9ae5a3f822764132de72f7a3351acafa037e41b80::blast_vault_package::BLAST_VAULT_PACKAGE>, arg8: &0xf02c2127356906e1fa184be1f065c71df0adfe693ecd9279cedcacc6aa66216::blast_treasury::Treasury, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        0x7c323cdc962a2875a255ac79cd2fc595dc0a491beed896652fd5182b1820662b::package_version::assert_current<0xeb2962af03fa9ea824522e91b9a2130f1b2bef6841c92e33127dd7fdab768c64::blast_migrators::BLAST_MIGRATORS>(arg1, 1);
        assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::is_right_order<T2, T3>(), 0);
        let v0 = is_meme_coin_a<T0, T1, T2, T3>();
        let v1 = Venue{dummy_field: false};
        let (v2, v3, v4) = 0xf02c2127356906e1fa184be1f065c71df0adfe693ecd9279cedcacc6aa66216::migration::redeem<T0, T1, Venue>(arg0, v1);
        let v5 = v3;
        let v6 = v2;
        let v7 = PoolTierKey<T0>{dummy_field: false};
        let v8 = *0xeb2962af03fa9ea824522e91b9a2130f1b2bef6841c92e33127dd7fdab768c64::venue_config::value<PoolTierKey<T0>, u32>(arg2, v7);
        let (v9, v10) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool_creator::full_range_tick_range(v8);
        let v11 = 0x2::balance::value<T0>(&v6);
        let v12 = 0x2::balance::value<T1>(&v5);
        let v13 = 0xf02c2127356906e1fa184be1f065c71df0adfe693ecd9279cedcacc6aa66216::migration::sqrt_price_x64(v11, v12, v0);
        let v14 = 0x2::coin::from_balance<T0>(v6, arg10);
        let v15 = 0x2::coin::from_balance<T1>(v5, arg10);
        let (v16, v17) = reorder<0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x2::coin::Coin<T2>, 0x2::coin::Coin<T3>>(v14, v15, v0, arg10);
        let (v18, v19, v20) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool_creator::create_pool_v3_with_creation_cap<T2, T3>(arg3, arg4, pool_creation_cap<T0>(arg2), v8, v13, 0x1::string::utf8(b""), v9, v10, v16, v17, is_coin_a_seed_side(v9, v10, v13, v11, v12, v0), arg9, arg10);
        let v21 = v18;
        let (v22, v23) = reorder<0x2::coin::Coin<T2>, 0x2::coin::Coin<T3>, 0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>>(v19, v20, v0, arg10);
        let v24 = Venue{dummy_field: false};
        let v25 = Venue{dummy_field: false};
        0x35ea07f57ab632fc215b06e9ae5a3f822764132de72f7a3351acafa037e41b80::vault::share_with_position<T0, T1, Venue, 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::CetusLPBurnProof>(0x35ea07f57ab632fc215b06e9ae5a3f822764132de72f7a3351acafa037e41b80::vault::new<T0, T1, Venue>(arg6, &v24, arg7, v4, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::pool_id(&v21), arg10), &v25, arg8, 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::burn_lp_v2(arg5, v21, arg10), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(&v21), 0x2::coin::into_balance<T0>(v22), 0x2::coin::into_balance<T1>(v23), arg10);
    }

    fun pool_creation_cap<T0>(arg0: &0xeb2962af03fa9ea824522e91b9a2130f1b2bef6841c92e33127dd7fdab768c64::venue_config::VenueConfig) : &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::PoolCreationCap {
        let v0 = CreationCapKey<T0>{dummy_field: false};
        0xeb2962af03fa9ea824522e91b9a2130f1b2bef6841c92e33127dd7fdab768c64::venue_config::object<CreationCapKey<T0>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::PoolCreationCap>(arg0, v0)
    }

    public fun prepare<T0, T1>(arg0: &0x7c323cdc962a2875a255ac79cd2fc595dc0a491beed896652fd5182b1820662b::package_version::PackageVersion<0xeb2962af03fa9ea824522e91b9a2130f1b2bef6841c92e33127dd7fdab768c64::blast_migrators::BLAST_MIGRATORS>, arg1: &mut 0xeb2962af03fa9ea824522e91b9a2130f1b2bef6841c92e33127dd7fdab768c64::venue_config::VenueConfig, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg4: &mut 0xf02c2127356906e1fa184be1f065c71df0adfe693ecd9279cedcacc6aa66216::sealed_treasury_cap::SealedTreasuryCap<T0>, arg5: 0xf02c2127356906e1fa184be1f065c71df0adfe693ecd9279cedcacc6aa66216::sealed_treasury_cap::VenueAdmission, arg6: u32, arg7: &mut 0x2::tx_context::TxContext) : 0xf02c2127356906e1fa184be1f065c71df0adfe693ecd9279cedcacc6aa66216::migration::VenueTicket<T0, T1> {
        0x7c323cdc962a2875a255ac79cd2fc595dc0a491beed896652fd5182b1820662b::package_version::assert_current<0xeb2962af03fa9ea824522e91b9a2130f1b2bef6841c92e33127dd7fdab768c64::blast_migrators::BLAST_MIGRATORS>(arg0, 1);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::get_fee_rate(arg6, arg2);
        let v0 = Venue{dummy_field: false};
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::mint_pool_creation_cap<T0>(arg2, arg3, 0xf02c2127356906e1fa184be1f065c71df0adfe693ecd9279cedcacc6aa66216::sealed_treasury_cap::treasury_cap_mut<T0, Venue>(arg4, arg5, v0), arg7);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::register_permission_pair<T0, T1>(arg2, arg3, arg6, &v1, arg7);
        let v2 = CreationCapKey<T0>{dummy_field: false};
        0xeb2962af03fa9ea824522e91b9a2130f1b2bef6841c92e33127dd7fdab768c64::venue_config::add_object<CreationCapKey<T0>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::PoolCreationCap>(arg1, v2, v1);
        let v3 = PoolTierKey<T0>{dummy_field: false};
        0xeb2962af03fa9ea824522e91b9a2130f1b2bef6841c92e33127dd7fdab768c64::venue_config::add_value<PoolTierKey<T0>, u32>(arg1, v3, arg6);
        0xeb2962af03fa9ea824522e91b9a2130f1b2bef6841c92e33127dd7fdab768c64::events::cetus_pool_reserved<T0, T1>(0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::PoolCreationCap>(&v1), arg6);
        let v4 = Venue{dummy_field: false};
        0xf02c2127356906e1fa184be1f065c71df0adfe693ecd9279cedcacc6aa66216::migration::issue_ticket<T0, T1, Venue>(v4)
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

    fun seed_fixed_side(arg0: bool, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : bool {
        arg3 <= arg1 && arg4 <= arg2 && arg0 || !arg0
    }

    public fun settle_and_apply_fee_split<T0, T1, T2, T3>(arg0: &mut 0x35ea07f57ab632fc215b06e9ae5a3f822764132de72f7a3351acafa037e41b80::vault::Vault<T0, T1>, arg1: &0x7c323cdc962a2875a255ac79cd2fc595dc0a491beed896652fd5182b1820662b::package_version::PackageVersion<0xeb2962af03fa9ea824522e91b9a2130f1b2bef6841c92e33127dd7fdab768c64::blast_migrators::BLAST_MIGRATORS>, arg2: &0x7c323cdc962a2875a255ac79cd2fc595dc0a491beed896652fd5182b1820662b::package_version::PackageVersion<0x35ea07f57ab632fc215b06e9ae5a3f822764132de72f7a3351acafa037e41b80::blast_vault_package::BLAST_VAULT_PACKAGE>, arg3: &0xf02c2127356906e1fa184be1f065c71df0adfe693ecd9279cedcacc6aa66216::blast_treasury::Treasury, arg4: &mut 0x2::coin_registry::Currency<T0>, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0x7c323cdc962a2875a255ac79cd2fc595dc0a491beed896652fd5182b1820662b::package_version::assert_current<0xeb2962af03fa9ea824522e91b9a2130f1b2bef6841c92e33127dd7fdab768c64::blast_migrators::BLAST_MIGRATORS>(arg1, 1);
        0x35ea07f57ab632fc215b06e9ae5a3f822764132de72f7a3351acafa037e41b80::vault::assert_fee_split_ready<T0, T1>(arg0, arg8);
        settle_fees<T0, T1, T2, T3>(arg0, arg2, arg3, arg4, arg5, arg6, arg7, is_meme_coin_a<T0, T1, T2, T3>(), arg9);
        let v0 = Venue{dummy_field: false};
        0x35ea07f57ab632fc215b06e9ae5a3f822764132de72f7a3351acafa037e41b80::vault::apply_fee_split<T0, T1, Venue>(arg0, &v0, arg2, arg8);
    }

    fun settle_fees<T0, T1, T2, T3>(arg0: &mut 0x35ea07f57ab632fc215b06e9ae5a3f822764132de72f7a3351acafa037e41b80::vault::Vault<T0, T1>, arg1: &0x7c323cdc962a2875a255ac79cd2fc595dc0a491beed896652fd5182b1820662b::package_version::PackageVersion<0x35ea07f57ab632fc215b06e9ae5a3f822764132de72f7a3351acafa037e41b80::blast_vault_package::BLAST_VAULT_PACKAGE>, arg2: &0xf02c2127356906e1fa184be1f065c71df0adfe693ecd9279cedcacc6aa66216::blast_treasury::Treasury, arg3: &mut 0x2::coin_registry::Currency<T0>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg7: bool, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = collect_position_fees<T0, T1, T2, T3>(arg0, arg1, arg4, arg5, arg6, arg7, arg8);
        let v2 = Venue{dummy_field: false};
        0x35ea07f57ab632fc215b06e9ae5a3f822764132de72f7a3351acafa037e41b80::vault::split_fees<T0, T1, Venue>(arg0, &v2, arg1, arg2, arg3, v0, v1, arg8);
    }

    fun swap_quote_for_meme<T0, T1, T2, T3>(arg0: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: 0x2::balance::Balance<T1>, arg3: bool, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let (v0, v1) = reorder<0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, 0x2::balance::Balance<T2>, 0x2::balance::Balance<T3>>(0x2::balance::zero<T0>(), arg2, arg3, arg5);
        let (v2, v3) = swap<T2, T3>(arg0, arg1, v0, v1, !arg3, arg4);
        reorder<0x2::balance::Balance<T2>, 0x2::balance::Balance<T3>, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>>(v2, v3, arg3, arg5)
    }

    // decompiled from Move bytecode v7
}

