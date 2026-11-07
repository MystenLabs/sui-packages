module 0xeb2962af03fa9ea824522e91b9a2130f1b2bef6841c92e33127dd7fdab768c64::bluefin {
    struct Venue has drop {
        dummy_field: bool,
    }

    struct PoolTier has copy, drop, store {
        tick_spacing: u32,
        fee_rate: u64,
    }

    struct PoolTierKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    fun auto_lp_fixed_side(arg0: u128, arg1: u128, arg2: u128, arg3: u64, arg4: u64) : (bool, u64) {
        if (arg1 <= arg0 || arg1 >= arg2) {
            return (true, 0)
        };
        let v0 = (arg0 as u256);
        let v1 = (arg1 as u256);
        let v2 = (arg2 as u256);
        if (can_fix_a(v0, v1, v2, arg3, arg4)) {
            return (true, arg3)
        };
        if (can_fix_b(v0, v1, v2, arg3, arg4)) {
            return (false, arg4)
        };
        (true, 0)
    }

    public fun buyback_and_burn<T0, T1>(arg0: &mut 0x35ea07f57ab632fc215b06e9ae5a3f822764132de72f7a3351acafa037e41b80::vault::Vault<T0, T1>, arg1: &0x7c323cdc962a2875a255ac79cd2fc595dc0a491beed896652fd5182b1820662b::package_version::PackageVersion<0xeb2962af03fa9ea824522e91b9a2130f1b2bef6841c92e33127dd7fdab768c64::blast_migrators::BLAST_MIGRATORS>, arg2: &0x7c323cdc962a2875a255ac79cd2fc595dc0a491beed896652fd5182b1820662b::package_version::PackageVersion<0x35ea07f57ab632fc215b06e9ae5a3f822764132de72f7a3351acafa037e41b80::blast_vault_package::BLAST_VAULT_PACKAGE>, arg3: &0x7c323cdc962a2875a255ac79cd2fc595dc0a491beed896652fd5182b1820662b::blast_acl::AdminWitness<0xf02c2127356906e1fa184be1f065c71df0adfe693ecd9279cedcacc6aa66216::blast_domain::BuybackAdmin>, arg4: &mut 0x2::coin_registry::Currency<T0>, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        0x7c323cdc962a2875a255ac79cd2fc595dc0a491beed896652fd5182b1820662b::package_version::assert_current<0xeb2962af03fa9ea824522e91b9a2130f1b2bef6841c92e33127dd7fdab768c64::blast_migrators::BLAST_MIGRATORS>(arg1, 1);
        assert!(0x35ea07f57ab632fc215b06e9ae5a3f822764132de72f7a3351acafa037e41b80::vault::pool_id<T0, T1>(arg0) == 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg6), 1);
        let v0 = Venue{dummy_field: false};
        let (v1, v2) = 0x35ea07f57ab632fc215b06e9ae5a3f822764132de72f7a3351acafa037e41b80::vault::take_buyback_quote<T0, T1, Venue>(arg0, &v0, arg3, arg2, arg7);
        let (v3, v4) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T0, T1>(arg9, arg5, arg6, 0x2::balance::zero<T0>(), v1, false, true, arg7, 0, 79226673515401279992447579054);
        let v5 = Venue{dummy_field: false};
        0x35ea07f57ab632fc215b06e9ae5a3f822764132de72f7a3351acafa037e41b80::vault::burn_buyback<T0, T1, Venue>(arg0, &v5, arg2, v2, arg4, v3, v4, arg8, arg10);
    }

    fun can_fix_a(arg0: u256, arg1: u256, arg2: u256, arg3: u64, arg4: u64) : bool {
        let v0 = 18446744073709551616;
        let v1 = (arg3 as u256) * arg1 * arg2 / v0 / (arg2 - arg1);
        if (v1 == 0 || v1 >= 340282366920938463463374607431768211456) {
            return false
        };
        0x1::u256::div_ceil(v1 * (arg1 - arg0), v0) + 2 <= (arg4 as u256)
    }

    fun can_fix_b(arg0: u256, arg1: u256, arg2: u256, arg3: u64, arg4: u64) : bool {
        let v0 = ((arg4 as u256) << 64) / (arg1 - arg0);
        if (v0 == 0) {
            return false
        };
        0x1::u256::div_ceil(v0 << 64, arg1) - (v0 << 64) / arg2 + 2 <= (arg3 as u256)
    }

    public fun collect_fees<T0, T1>(arg0: &mut 0x35ea07f57ab632fc215b06e9ae5a3f822764132de72f7a3351acafa037e41b80::vault::Vault<T0, T1>, arg1: &0x7c323cdc962a2875a255ac79cd2fc595dc0a491beed896652fd5182b1820662b::package_version::PackageVersion<0xeb2962af03fa9ea824522e91b9a2130f1b2bef6841c92e33127dd7fdab768c64::blast_migrators::BLAST_MIGRATORS>, arg2: &0x7c323cdc962a2875a255ac79cd2fc595dc0a491beed896652fd5182b1820662b::package_version::PackageVersion<0x35ea07f57ab632fc215b06e9ae5a3f822764132de72f7a3351acafa037e41b80::blast_vault_package::BLAST_VAULT_PACKAGE>, arg3: &0xf02c2127356906e1fa184be1f065c71df0adfe693ecd9279cedcacc6aa66216::blast_treasury::Treasury, arg4: &mut 0x2::coin_registry::Currency<T0>, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x7c323cdc962a2875a255ac79cd2fc595dc0a491beed896652fd5182b1820662b::package_version::assert_current<0xeb2962af03fa9ea824522e91b9a2130f1b2bef6841c92e33127dd7fdab768c64::blast_migrators::BLAST_MIGRATORS>(arg1, 1);
        settle_fees<T0, T1>(arg0, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    fun collect_position_fees<T0, T1>(arg0: &mut 0x35ea07f57ab632fc215b06e9ae5a3f822764132de72f7a3351acafa037e41b80::vault::Vault<T0, T1>, arg1: &0x7c323cdc962a2875a255ac79cd2fc595dc0a491beed896652fd5182b1820662b::package_version::PackageVersion<0x35ea07f57ab632fc215b06e9ae5a3f822764132de72f7a3351acafa037e41b80::blast_vault_package::BLAST_VAULT_PACKAGE>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let v0 = Venue{dummy_field: false};
        let v1 = 0x35ea07f57ab632fc215b06e9ae5a3f822764132de72f7a3351acafa037e41b80::vault::position_mut<T0, T1, Venue, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(arg0, &v0, arg1);
        assert!(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::pool_id(v1) == 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg3), 1);
        let (_, _, v4, v5) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_fee<T0, T1>(arg4, arg2, arg3, v1);
        (v4, v5)
    }

    fun compound<T0, T1>(arg0: &mut 0x35ea07f57ab632fc215b06e9ae5a3f822764132de72f7a3351acafa037e41b80::vault::Vault<T0, T1>, arg1: &0x7c323cdc962a2875a255ac79cd2fc595dc0a491beed896652fd5182b1820662b::package_version::PackageVersion<0x35ea07f57ab632fc215b06e9ae5a3f822764132de72f7a3351acafa037e41b80::blast_vault_package::BLAST_VAULT_PACKAGE>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: &0x2::clock::Clock) {
        let v0 = Venue{dummy_field: false};
        let (v1, v2, v3) = 0x35ea07f57ab632fc215b06e9ae5a3f822764132de72f7a3351acafa037e41b80::vault::take_auto_lp<T0, T1, Venue>(arg0, &v0, arg1);
        let v4 = v2;
        let v5 = v1;
        let v6 = Venue{dummy_field: false};
        let v7 = 0x35ea07f57ab632fc215b06e9ae5a3f822764132de72f7a3351acafa037e41b80::vault::position_mut<T0, T1, Venue, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(arg0, &v6, arg1);
        let (v8, v9) = fixed_side<T0, T1>(arg3, v7, 0x2::balance::value<T0>(&v5), 0x2::balance::value<T1>(&v4));
        let (v10, v11) = if (v9 > 0) {
            let (v12, v13, v14, v15) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::add_liquidity_with_fixed_amount<T0, T1>(arg4, arg2, arg3, v7, v5, v4, v9, v8);
            let _ = v13;
            let _ = v12;
            (v14, v15)
        } else {
            let _ = 0;
            let _ = 0;
            (v5, v4)
        };
        let v18 = Venue{dummy_field: false};
        0x35ea07f57ab632fc215b06e9ae5a3f822764132de72f7a3351acafa037e41b80::vault::keep_auto_lp<T0, T1, Venue>(arg0, &v18, arg1, v3, v10, v11);
    }

    entry fun compound_auto_lp<T0, T1>(arg0: &mut 0x35ea07f57ab632fc215b06e9ae5a3f822764132de72f7a3351acafa037e41b80::vault::Vault<T0, T1>, arg1: &0x7c323cdc962a2875a255ac79cd2fc595dc0a491beed896652fd5182b1820662b::package_version::PackageVersion<0xeb2962af03fa9ea824522e91b9a2130f1b2bef6841c92e33127dd7fdab768c64::blast_migrators::BLAST_MIGRATORS>, arg2: &0x7c323cdc962a2875a255ac79cd2fc595dc0a491beed896652fd5182b1820662b::package_version::PackageVersion<0x35ea07f57ab632fc215b06e9ae5a3f822764132de72f7a3351acafa037e41b80::blast_vault_package::BLAST_VAULT_PACKAGE>, arg3: &0x7c323cdc962a2875a255ac79cd2fc595dc0a491beed896652fd5182b1820662b::blast_acl::ACL, arg4: &0x7c323cdc962a2875a255ac79cd2fc595dc0a491beed896652fd5182b1820662b::blast_acl::AdminCap, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg7: u128, arg8: u128, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        0x7c323cdc962a2875a255ac79cd2fc595dc0a491beed896652fd5182b1820662b::package_version::assert_current<0xeb2962af03fa9ea824522e91b9a2130f1b2bef6841c92e33127dd7fdab768c64::blast_migrators::BLAST_MIGRATORS>(arg1, 1);
        0x7c323cdc962a2875a255ac79cd2fc595dc0a491beed896652fd5182b1820662b::blast_acl::sign_in<0xf02c2127356906e1fa184be1f065c71df0adfe693ecd9279cedcacc6aa66216::blast_domain::AutoLpAdmin>(arg3, arg4);
        assert!(arg7 > 0 && arg7 <= arg8, 5);
        assert!(0x35ea07f57ab632fc215b06e9ae5a3f822764132de72f7a3351acafa037e41b80::vault::pool_id<T0, T1>(arg0) == 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(&arg6), 1);
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(&arg6);
        assert!(arg7 <= v0 && v0 <= arg8, 5);
        let v1 = &mut arg6;
        compound<T0, T1>(arg0, arg2, arg5, v1, arg9);
        0x2::transfer::public_share_object<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg6);
    }

    fun fixed_side<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg2: u64, arg3: u64) : (bool, u64) {
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_tick_manager<T0, T1>(arg0);
        auto_lp_fixed_side(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick::sqrt_price(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick::get_tick_from_manager(v0, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::lower_tick(arg1))), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg0), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick::sqrt_price(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick::get_tick_from_manager(v0, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::upper_tick(arg1))), arg2, arg3)
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
        seed_fixed_side(v0, arg2, arg3, v3, v4)
    }

    public fun migrate<T0, T1>(arg0: 0xf02c2127356906e1fa184be1f065c71df0adfe693ecd9279cedcacc6aa66216::migration::Migration<T0, T1>, arg1: &0x7c323cdc962a2875a255ac79cd2fc595dc0a491beed896652fd5182b1820662b::package_version::PackageVersion<0xeb2962af03fa9ea824522e91b9a2130f1b2bef6841c92e33127dd7fdab768c64::blast_migrators::BLAST_MIGRATORS>, arg2: &0xeb2962af03fa9ea824522e91b9a2130f1b2bef6841c92e33127dd7fdab768c64::venue_config::VenueConfig, arg3: &0x2::coin_registry::Currency<T0>, arg4: &0x2::coin_registry::Currency<T1>, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &mut 0x35ea07f57ab632fc215b06e9ae5a3f822764132de72f7a3351acafa037e41b80::blast_vault_package::VaultRegistry, arg7: &0x7c323cdc962a2875a255ac79cd2fc595dc0a491beed896652fd5182b1820662b::package_version::PackageVersion<0x35ea07f57ab632fc215b06e9ae5a3f822764132de72f7a3351acafa037e41b80::blast_vault_package::BLAST_VAULT_PACKAGE>, arg8: &0xf02c2127356906e1fa184be1f065c71df0adfe693ecd9279cedcacc6aa66216::blast_treasury::Treasury, arg9: 0x2::coin::Coin<0x2::sui::SUI>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        0x7c323cdc962a2875a255ac79cd2fc595dc0a491beed896652fd5182b1820662b::package_version::assert_current<0xeb2962af03fa9ea824522e91b9a2130f1b2bef6841c92e33127dd7fdab768c64::blast_migrators::BLAST_MIGRATORS>(arg1, 1);
        let v0 = Venue{dummy_field: false};
        let (v1, v2, v3) = 0xf02c2127356906e1fa184be1f065c71df0adfe693ecd9279cedcacc6aa66216::migration::redeem<T0, T1, Venue>(arg0, v0);
        let v4 = v2;
        let v5 = v1;
        let v6 = PoolTierKey<T0>{dummy_field: false};
        let PoolTier {
            tick_spacing : v7,
            fee_rate     : v8,
        } = *0xeb2962af03fa9ea824522e91b9a2130f1b2bef6841c92e33127dd7fdab768c64::venue_config::value<PoolTierKey<T0>, PoolTier>(arg2, v6);
        let (v9, v10) = full_range_tick_range(arg5, v7);
        let v11 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::create_pool_and_get_object<T0, T1, 0x2::sui::SUI>(arg10, arg5, pool_name<T0, T1>(arg3, arg4), b"", 0x1::string::into_bytes(0x2::coin_registry::symbol<T0>(arg3)), 0x2::coin_registry::decimals<T0>(arg3), b"", 0x1::string::into_bytes(0x2::coin_registry::symbol<T1>(arg4)), 0x2::coin_registry::decimals<T1>(arg4), 0x1::string::into_bytes(0x2::coin_registry::icon_url<T1>(arg4)), v7, v8, 0xf02c2127356906e1fa184be1f065c71df0adfe693ecd9279cedcacc6aa66216::migration::sqrt_price_x64(0x2::balance::value<T0>(&v5), 0x2::balance::value<T1>(&v4), true), 0x2::coin::into_balance<0x2::sui::SUI>(arg9), arg11);
        let v12 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::open_position<T0, T1>(arg5, &mut v11, v9, v10, arg11);
        let v13 = &mut v11;
        let v14 = &mut v12;
        let (v15, v16) = seed<T0, T1>(v13, arg5, v14, v5, v4, arg10);
        let v17 = Venue{dummy_field: false};
        let v18 = Venue{dummy_field: false};
        0x35ea07f57ab632fc215b06e9ae5a3f822764132de72f7a3351acafa037e41b80::vault::share_with_position<T0, T1, Venue, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(0x35ea07f57ab632fc215b06e9ae5a3f822764132de72f7a3351acafa037e41b80::vault::new<T0, T1, Venue>(arg6, &v17, arg7, v3, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::pool_id(&v12), arg11), &v18, arg8, v12, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(&v12), v15, v16, arg11);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::share_pool_object<T0, T1>(v11);
    }

    fun pool_name<T0, T1>(arg0: &0x2::coin_registry::Currency<T0>, arg1: &0x2::coin_registry::Currency<T1>) : vector<u8> {
        let v0 = 0x1::string::into_bytes(0x2::coin_registry::symbol<T0>(arg0));
        0x1::vector::append<u8>(&mut v0, b"-");
        0x1::vector::append<u8>(&mut v0, 0x1::string::into_bytes(0x2::coin_registry::symbol<T1>(arg1)));
        v0
    }

    public fun prepare<T0, T1>(arg0: &0x7c323cdc962a2875a255ac79cd2fc595dc0a491beed896652fd5182b1820662b::package_version::PackageVersion<0xeb2962af03fa9ea824522e91b9a2130f1b2bef6841c92e33127dd7fdab768c64::blast_migrators::BLAST_MIGRATORS>, arg1: &mut 0xeb2962af03fa9ea824522e91b9a2130f1b2bef6841c92e33127dd7fdab768c64::venue_config::VenueConfig, arg2: &0xf02c2127356906e1fa184be1f065c71df0adfe693ecd9279cedcacc6aa66216::sealed_treasury_cap::SealedTreasuryCap<T0>, arg3: &0x2::coin_registry::Currency<T0>, arg4: u32, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : 0xf02c2127356906e1fa184be1f065c71df0adfe693ecd9279cedcacc6aa66216::migration::VenueTicket<T0, T1> {
        0x7c323cdc962a2875a255ac79cd2fc595dc0a491beed896652fd5182b1820662b::package_version::assert_current<0xeb2962af03fa9ea824522e91b9a2130f1b2bef6841c92e33127dd7fdab768c64::blast_migrators::BLAST_MIGRATORS>(arg0, 1);
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
        assert!(v0, 3);
        let v1 = 0x2::coin_registry::symbol<T0>(arg3);
        assert!(0x1::string::length(&v1) <= 32, 4);
        let v2 = PoolTierKey<T0>{dummy_field: false};
        let v3 = PoolTier{
            tick_spacing : arg4,
            fee_rate     : arg5,
        };
        0xeb2962af03fa9ea824522e91b9a2130f1b2bef6841c92e33127dd7fdab768c64::venue_config::add_value<PoolTierKey<T0>, PoolTier>(arg1, v2, v3);
        0xeb2962af03fa9ea824522e91b9a2130f1b2bef6841c92e33127dd7fdab768c64::events::bluefin_pool_tier_recorded<T0, T1>(arg4, arg5);
        let v4 = Venue{dummy_field: false};
        0xf02c2127356906e1fa184be1f065c71df0adfe693ecd9279cedcacc6aa66216::migration::issue_ticket<T0, T1, Venue>(v4)
    }

    fun seed<T0, T1>(arg0: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg3: 0x2::balance::Balance<T0>, arg4: 0x2::balance::Balance<T1>, arg5: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let v0 = is_meme_seed_side<T0, T1>(arg0, arg2, 0x2::balance::value<T0>(&arg3), 0x2::balance::value<T1>(&arg4));
        let v1 = if (v0) {
            0x2::balance::value<T0>(&arg3)
        } else {
            0x2::balance::value<T1>(&arg4)
        };
        let (_, _, v4, v5) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::add_liquidity_with_fixed_amount<T0, T1>(arg5, arg1, arg0, arg2, arg3, arg4, v1, v0);
        (v4, v5)
    }

    fun seed_fixed_side(arg0: bool, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : bool {
        arg3 <= arg1 && arg4 <= arg2 && arg0 || !arg0
    }

    public fun settle_and_apply_fee_split<T0, T1>(arg0: &mut 0x35ea07f57ab632fc215b06e9ae5a3f822764132de72f7a3351acafa037e41b80::vault::Vault<T0, T1>, arg1: &0x7c323cdc962a2875a255ac79cd2fc595dc0a491beed896652fd5182b1820662b::package_version::PackageVersion<0xeb2962af03fa9ea824522e91b9a2130f1b2bef6841c92e33127dd7fdab768c64::blast_migrators::BLAST_MIGRATORS>, arg2: &0x7c323cdc962a2875a255ac79cd2fc595dc0a491beed896652fd5182b1820662b::package_version::PackageVersion<0x35ea07f57ab632fc215b06e9ae5a3f822764132de72f7a3351acafa037e41b80::blast_vault_package::BLAST_VAULT_PACKAGE>, arg3: &0xf02c2127356906e1fa184be1f065c71df0adfe693ecd9279cedcacc6aa66216::blast_treasury::Treasury, arg4: &mut 0x2::coin_registry::Currency<T0>, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x7c323cdc962a2875a255ac79cd2fc595dc0a491beed896652fd5182b1820662b::package_version::assert_current<0xeb2962af03fa9ea824522e91b9a2130f1b2bef6841c92e33127dd7fdab768c64::blast_migrators::BLAST_MIGRATORS>(arg1, 1);
        0x35ea07f57ab632fc215b06e9ae5a3f822764132de72f7a3351acafa037e41b80::vault::assert_fee_split_ready<T0, T1>(arg0, arg7);
        settle_fees<T0, T1>(arg0, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        let v0 = Venue{dummy_field: false};
        0x35ea07f57ab632fc215b06e9ae5a3f822764132de72f7a3351acafa037e41b80::vault::apply_fee_split<T0, T1, Venue>(arg0, &v0, arg2, arg7);
    }

    fun settle_fees<T0, T1>(arg0: &mut 0x35ea07f57ab632fc215b06e9ae5a3f822764132de72f7a3351acafa037e41b80::vault::Vault<T0, T1>, arg1: &0x7c323cdc962a2875a255ac79cd2fc595dc0a491beed896652fd5182b1820662b::package_version::PackageVersion<0x35ea07f57ab632fc215b06e9ae5a3f822764132de72f7a3351acafa037e41b80::blast_vault_package::BLAST_VAULT_PACKAGE>, arg2: &0xf02c2127356906e1fa184be1f065c71df0adfe693ecd9279cedcacc6aa66216::blast_treasury::Treasury, arg3: &mut 0x2::coin_registry::Currency<T0>, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = collect_position_fees<T0, T1>(arg0, arg1, arg4, arg5, arg6);
        let v2 = Venue{dummy_field: false};
        0x35ea07f57ab632fc215b06e9ae5a3f822764132de72f7a3351acafa037e41b80::vault::split_fees<T0, T1, Venue>(arg0, &v2, arg1, arg2, arg3, v0, v1, arg7);
    }

    // decompiled from Move bytecode v7
}

