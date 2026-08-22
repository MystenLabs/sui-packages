module 0xeb7082ab6da440bec5e4b818ab47395c18dfce0c250f8b32785d662dbdbaf980::aftermath_perp_adapter {
    struct PerpAccount<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        config_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
        af_account_id: 0x2::object::ID,
        account_num: u64,
        clearing_house_id: 0x2::object::ID,
        collateral_scalar: u64,
        mark_band_bps: u64,
        admin_cap: 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::authority::ACCOUNT, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>,
    }

    public fun account_num<T0, T1>(arg0: &PerpAccount<T0, T1>) : u64 {
        arg0.account_num
    }

    public fun account_vault_id<T0, T1>(arg0: &PerpAccount<T0, T1>) : 0x2::object::ID {
        arg0.vault_id
    }

    public fun allocate<T0, T1>(arg0: &0xeb7082ab6da440bec5e4b818ab47395c18dfce0c250f8b32785d662dbdbaf980::vault::Vault<T1>, arg1: &PerpAccount<T0, T1>, arg2: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg3: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg4: &0xeb7082ab6da440bec5e4b818ab47395c18dfce0c250f8b32785d662dbdbaf980::vault::VaultAdminCap<T1>, arg5: &0xeb7082ab6da440bec5e4b818ab47395c18dfce0c250f8b32785d662dbdbaf980::config::LotusConfig, arg6: u64, arg7: u64) {
        0xeb7082ab6da440bec5e4b818ab47395c18dfce0c250f8b32785d662dbdbaf980::config::assert_active(arg5, arg6);
        0xeb7082ab6da440bec5e4b818ab47395c18dfce0c250f8b32785d662dbdbaf980::vault::assert_admin<T1>(arg0, arg4);
        assert_account<T0, T1>(arg1, arg0, arg3);
        assert!(arg1.clearing_house_id == 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>>(arg2), 0xeb7082ab6da440bec5e4b818ab47395c18dfce0c250f8b32785d662dbdbaf980::errors::perp_binding());
        0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::allocate_collateral<T1, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(arg2, &arg1.admin_cap, arg3, arg7);
    }

    fun assert_account<T0, T1>(arg0: &PerpAccount<T0, T1>, arg1: &0xeb7082ab6da440bec5e4b818ab47395c18dfce0c250f8b32785d662dbdbaf980::vault::Vault<T1>, arg2: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>) {
        assert!(arg0.vault_id == 0xeb7082ab6da440bec5e4b818ab47395c18dfce0c250f8b32785d662dbdbaf980::vault::id<T1>(arg1), 0xeb7082ab6da440bec5e4b818ab47395c18dfce0c250f8b32785d662dbdbaf980::errors::perp_binding());
        assert!(arg0.af_account_id == 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>>(arg2), 0xeb7082ab6da440bec5e4b818ab47395c18dfce0c250f8b32785d662dbdbaf980::errors::perp_binding());
    }

    public fun clearing_house_id<T0, T1>(arg0: &PerpAccount<T0, T1>) : 0x2::object::ID {
        arg0.clearing_house_id
    }

    public fun deallocate<T0, T1>(arg0: &0xeb7082ab6da440bec5e4b818ab47395c18dfce0c250f8b32785d662dbdbaf980::vault::Vault<T1>, arg1: &PerpAccount<T0, T1>, arg2: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg3: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg4: &0xeb7082ab6da440bec5e4b818ab47395c18dfce0c250f8b32785d662dbdbaf980::vault::VaultAdminCap<T1>, arg5: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg6: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg7: u64, arg8: &0x2::clock::Clock) : u64 {
        0xeb7082ab6da440bec5e4b818ab47395c18dfce0c250f8b32785d662dbdbaf980::vault::assert_admin<T1>(arg0, arg4);
        assert_account<T0, T1>(arg1, arg0, arg3);
        assert!(arg1.clearing_house_id == 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>>(arg2), 0xeb7082ab6da440bec5e4b818ab47395c18dfce0c250f8b32785d662dbdbaf980::errors::perp_binding());
        0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::deallocate_collateral<T1, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(arg2, &arg1.admin_cap, arg3, arg5, arg6, arg7, arg8)
    }

    public fun defund<T0, T1>(arg0: &mut 0xeb7082ab6da440bec5e4b818ab47395c18dfce0c250f8b32785d662dbdbaf980::vault::Vault<T1>, arg1: &PerpAccount<T0, T1>, arg2: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg3: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg4: &0xeb7082ab6da440bec5e4b818ab47395c18dfce0c250f8b32785d662dbdbaf980::vault::VaultAdminCap<T1>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        0xeb7082ab6da440bec5e4b818ab47395c18dfce0c250f8b32785d662dbdbaf980::vault::assert_admin<T1>(arg0, arg4);
        assert_account<T0, T1>(arg1, arg0, arg2);
        0xeb7082ab6da440bec5e4b818ab47395c18dfce0c250f8b32785d662dbdbaf980::vault::custody_sub<T1>(arg0, 0x2::object::id<PerpAccount<T0, T1>>(arg1), arg5);
        0xeb7082ab6da440bec5e4b818ab47395c18dfce0c250f8b32785d662dbdbaf980::vault::strategy_put_quote<T1>(arg0, 0x2::coin::into_balance<T1>(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::withdraw_collateral<T1>(arg2, &arg1.admin_cap, arg3, arg5, arg6)));
        0xeb7082ab6da440bec5e4b818ab47395c18dfce0c250f8b32785d662dbdbaf980::vault::strategy_settle_principal<T1>(arg0, arg5, arg5);
        0xeb7082ab6da440bec5e4b818ab47395c18dfce0c250f8b32785d662dbdbaf980::events::emit_adapter_flow(0x2::object::id<PerpAccount<T0, T1>>(arg1), arg1.vault_id, arg5, 2);
    }

    public fun fund<T0, T1>(arg0: &mut 0xeb7082ab6da440bec5e4b818ab47395c18dfce0c250f8b32785d662dbdbaf980::vault::Vault<T1>, arg1: &PerpAccount<T0, T1>, arg2: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg3: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg4: &0xeb7082ab6da440bec5e4b818ab47395c18dfce0c250f8b32785d662dbdbaf980::vault::VaultAdminCap<T1>, arg5: &0xeb7082ab6da440bec5e4b818ab47395c18dfce0c250f8b32785d662dbdbaf980::config::LotusConfig, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        0xeb7082ab6da440bec5e4b818ab47395c18dfce0c250f8b32785d662dbdbaf980::config::assert_active(arg5, arg6);
        0xeb7082ab6da440bec5e4b818ab47395c18dfce0c250f8b32785d662dbdbaf980::vault::assert_admin<T1>(arg0, arg4);
        assert_account<T0, T1>(arg1, arg0, arg2);
        0xeb7082ab6da440bec5e4b818ab47395c18dfce0c250f8b32785d662dbdbaf980::vault::custody_add<T1>(arg0, 0x2::object::id<PerpAccount<T0, T1>>(arg1), arg7);
        0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::deposit_collateral<T1, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(arg2, &arg1.admin_cap, arg3, 0x2::coin::from_balance<T1>(0xeb7082ab6da440bec5e4b818ab47395c18dfce0c250f8b32785d662dbdbaf980::vault::strategy_take_quote<T1>(arg0, arg7), arg8));
        0xeb7082ab6da440bec5e4b818ab47395c18dfce0c250f8b32785d662dbdbaf980::events::emit_adapter_flow(0x2::object::id<PerpAccount<T0, T1>>(arg1), arg1.vault_id, arg7, 1);
    }

    public fun mark_account<T0, T1>(arg0: &mut 0xeb7082ab6da440bec5e4b818ab47395c18dfce0c250f8b32785d662dbdbaf980::vault::Vault<T1>, arg1: &PerpAccount<T0, T1>, arg2: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg3: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg4: &0xeb7082ab6da440bec5e4b818ab47395c18dfce0c250f8b32785d662dbdbaf980::oracle::PriceOracle<T0, T1>, arg5: &0xeb7082ab6da440bec5e4b818ab47395c18dfce0c250f8b32785d662dbdbaf980::config::LotusConfig, arg6: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg7: &0x2::clock::Clock) {
        assert_account<T0, T1>(arg1, arg0, arg3);
        assert!(arg1.clearing_house_id == 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>>(arg2), 0xeb7082ab6da440bec5e4b818ab47395c18dfce0c250f8b32785d662dbdbaf980::errors::perp_binding());
        let v0 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::mark_price<T1>(arg2, arg6, arg7);
        if (arg1.mark_band_bps > 0) {
            let v1 = 0xeb7082ab6da440bec5e4b818ab47395c18dfce0c250f8b32785d662dbdbaf980::oracle::fresh_price<T0, T1>(arg4, arg5, arg7);
            let v2 = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::to_balance(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::mul(v0, 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::from_u64(1000000000)), 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::one());
            let (v3, v4) = if (v2 > v1) {
                (v1, v2)
            } else {
                (v2, v1)
            };
            assert!(((v4 - v3) as u128) * 10000 <= (v3 as u128) * (arg1.mark_band_bps as u128), 0xeb7082ab6da440bec5e4b818ab47395c18dfce0c250f8b32785d662dbdbaf980::errors::perp_mark_divergence());
        };
        let v5 = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::from_balance(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::collateral_balance<T1>(arg3), (arg1.collateral_scalar as u256));
        let v6 = v5;
        if (0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::exists_position<T1>(arg2, arg1.account_num)) {
            let v7 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::position<T1>(arg2, arg1.account_num);
            let (v8, v9) = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::cum_funding_rates(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::market_state<T1>(arg2));
            v6 = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::add(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::add(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::add(v5, 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::collateral(v7)), 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::unrealized_pnl(v7, v0)), 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::calculate_position_funding_internal(v7, v8, v9));
        };
        let v10 = if (0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::is_neg(v6)) {
            0
        } else {
            0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::to_balance(v6, (arg1.collateral_scalar as u256))
        };
        let v11 = 0x2::clock::timestamp_ms(arg7);
        let (v12, v13) = 0xeb7082ab6da440bec5e4b818ab47395c18dfce0c250f8b32785d662dbdbaf980::vault::apply_custody_mark<T1>(arg0, 0x2::object::id<PerpAccount<T0, T1>>(arg1), v10, v11);
        0xeb7082ab6da440bec5e4b818ab47395c18dfce0c250f8b32785d662dbdbaf980::events::emit_equity_mark(0xeb7082ab6da440bec5e4b818ab47395c18dfce0c250f8b32785d662dbdbaf980::vault::id<T1>(arg0), 2, 0x2::object::id<PerpAccount<T0, T1>>(arg1), v12, v13, v11);
    }

    public fun new_account<T0, T1>(arg0: &mut 0xeb7082ab6da440bec5e4b818ab47395c18dfce0c250f8b32785d662dbdbaf980::vault::Vault<T1>, arg1: &0xeb7082ab6da440bec5e4b818ab47395c18dfce0c250f8b32785d662dbdbaf980::vault::VaultAdminCap<T1>, arg2: &0xeb7082ab6da440bec5e4b818ab47395c18dfce0c250f8b32785d662dbdbaf980::config::LotusConfig, arg3: u64, arg4: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg5: 0x2::object::ID, arg6: u8, arg7: u64, arg8: 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::authority::ACCOUNT, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : PerpAccount<T0, T1> {
        0xeb7082ab6da440bec5e4b818ab47395c18dfce0c250f8b32785d662dbdbaf980::config::assert_governance_active(arg2, arg3);
        0xeb7082ab6da440bec5e4b818ab47395c18dfce0c250f8b32785d662dbdbaf980::vault::assert_admin<T1>(arg0, arg1);
        0xeb7082ab6da440bec5e4b818ab47395c18dfce0c250f8b32785d662dbdbaf980::dex_adapter::assert_dex_allowed<T1>(arg0, arg2, 0xeb7082ab6da440bec5e4b818ab47395c18dfce0c250f8b32785d662dbdbaf980::config::dex_aftermath_perp());
        let v0 = PerpAccount<T0, T1>{
            id                : 0x2::object::new(arg10),
            config_id         : 0xeb7082ab6da440bec5e4b818ab47395c18dfce0c250f8b32785d662dbdbaf980::config::id(arg2),
            vault_id          : 0xeb7082ab6da440bec5e4b818ab47395c18dfce0c250f8b32785d662dbdbaf980::vault::id<T1>(arg0),
            af_account_id     : 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>>(arg4),
            account_num       : 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::account_id<T1>(arg4),
            clearing_house_id : arg5,
            collateral_scalar : 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::decimal_scalar_from_decimals((arg6 as u64)),
            mark_band_bps     : arg7,
            admin_cap         : arg8,
        };
        0xeb7082ab6da440bec5e4b818ab47395c18dfce0c250f8b32785d662dbdbaf980::vault::register_custody<T1>(arg0, 0x2::object::id<PerpAccount<T0, T1>>(&v0), 0x2::clock::timestamp_ms(arg9), 60000);
        v0
    }

    public fun share_account<T0, T1>(arg0: PerpAccount<T0, T1>) {
        0x2::transfer::share_object<PerpAccount<T0, T1>>(arg0);
    }

    // decompiled from Move bytecode v7
}

