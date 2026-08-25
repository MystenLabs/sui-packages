module 0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::aftermath_perp_adapter {
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

    public fun allocate<T0, T1>(arg0: &0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::vault::Vault<T1>, arg1: &PerpAccount<T0, T1>, arg2: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg3: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg4: &0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::vault::VaultAdminCap<T1>, arg5: &0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::config::LotusConfig, arg6: u64, arg7: u64) {
        0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::config::assert_active(arg5, arg6);
        0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::vault::assert_admin<T1>(arg0, arg4);
        assert_account<T0, T1>(arg1, arg0, arg3);
        assert!(arg1.clearing_house_id == 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>>(arg2), 0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::errors::perp_binding());
        0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::allocate_collateral<T1, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(arg2, &arg1.admin_cap, arg3, arg7);
    }

    fun assert_account<T0, T1>(arg0: &PerpAccount<T0, T1>, arg1: &0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::vault::Vault<T1>, arg2: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>) {
        assert!(arg0.vault_id == 0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::vault::id<T1>(arg1), 0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::errors::perp_binding());
        assert!(arg0.af_account_id == 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>>(arg2), 0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::errors::perp_binding());
    }

    fun assert_venue_empty<T0, T1>(arg0: &PerpAccount<T0, T1>, arg1: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg2: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>) {
        assert!(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::collateral_balance<T1>(arg2) == 0, 0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::errors::custody_not_empty());
        if (0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::exists_position<T1>(arg1, arg0.account_num)) {
            let v0 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::position<T1>(arg1, arg0.account_num);
            assert!(0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::collateral(v0) == 0, 0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::errors::custody_not_empty());
            assert!(0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::abs_net_base(v0) == 0, 0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::errors::custody_not_empty());
        };
    }

    public fun clearing_house_id<T0, T1>(arg0: &PerpAccount<T0, T1>) : 0x2::object::ID {
        arg0.clearing_house_id
    }

    public fun deallocate<T0, T1>(arg0: &0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::vault::Vault<T1>, arg1: &PerpAccount<T0, T1>, arg2: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg3: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg4: &0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::vault::VaultAdminCap<T1>, arg5: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg6: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg7: u64, arg8: &0x2::clock::Clock) : u64 {
        0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::vault::assert_admin<T1>(arg0, arg4);
        assert_account<T0, T1>(arg1, arg0, arg3);
        assert!(arg1.clearing_house_id == 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>>(arg2), 0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::errors::perp_binding());
        0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::deallocate_collateral<T1, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(arg2, &arg1.admin_cap, arg3, arg5, arg6, arg7, arg8)
    }

    public fun defund<T0, T1>(arg0: &mut 0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::vault::Vault<T1>, arg1: &PerpAccount<T0, T1>, arg2: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg3: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg4: &0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::vault::VaultAdminCap<T1>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::vault::assert_admin<T1>(arg0, arg4);
        assert_account<T0, T1>(arg1, arg0, arg2);
        0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::vault::custody_sub<T1>(arg0, 0x2::object::id<PerpAccount<T0, T1>>(arg1), arg5);
        0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::vault::strategy_put_quote<T1>(arg0, 0x2::coin::into_balance<T1>(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::withdraw_collateral<T1>(arg2, &arg1.admin_cap, arg3, arg5, arg6)));
        0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::vault::strategy_settle_principal<T1>(arg0, arg5, arg5);
        0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::events::emit_adapter_flow(0x2::object::id<PerpAccount<T0, T1>>(arg1), arg1.vault_id, arg5, 2);
    }

    public fun fund<T0, T1>(arg0: &mut 0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::vault::Vault<T1>, arg1: &PerpAccount<T0, T1>, arg2: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg3: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg4: &0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::vault::VaultAdminCap<T1>, arg5: &0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::config::LotusConfig, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::config::assert_active(arg5, arg6);
        0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::vault::assert_admin<T1>(arg0, arg4);
        assert_account<T0, T1>(arg1, arg0, arg2);
        0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::vault::custody_add<T1>(arg0, 0x2::object::id<PerpAccount<T0, T1>>(arg1), arg7);
        0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::deposit_collateral<T1, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>(arg2, &arg1.admin_cap, arg3, 0x2::coin::from_balance<T1>(0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::vault::strategy_take_quote<T1>(arg0, arg7), arg8));
        0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::events::emit_adapter_flow(0x2::object::id<PerpAccount<T0, T1>>(arg1), arg1.vault_id, arg7, 1);
    }

    public fun mark_account<T0, T1>(arg0: &mut 0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::vault::Vault<T1>, arg1: &PerpAccount<T0, T1>, arg2: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg3: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg4: &0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::oracle::PriceOracle<T0, T1>, arg5: &0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::config::LotusConfig, arg6: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg7: &0x2::clock::Clock) {
        assert_account<T0, T1>(arg1, arg0, arg3);
        assert!(arg1.clearing_house_id == 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>>(arg2), 0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::errors::perp_binding());
        let v0 = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::from_balance(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::collateral_balance<T1>(arg3), (arg1.collateral_scalar as u256));
        let v1 = v0;
        if (0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::exists_position<T1>(arg2, arg1.account_num)) {
            let v2 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::mark_price<T1>(arg2, arg6, arg7);
            if (arg1.mark_band_bps > 0) {
                assert!(within_band(0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::oracle::fresh_price<T0, T1>(arg4, arg5, arg7), venue_mark_to_canonical<T0, T1>(arg4, v2), arg1.mark_band_bps), 0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::errors::perp_mark_divergence());
            };
            let v3 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::position<T1>(arg2, arg1.account_num);
            let (v4, v5) = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::cum_funding_rates(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::market_state<T1>(arg2));
            v1 = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::add(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::add(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::add(v0, 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::collateral(v3)), 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::unrealized_pnl(v3, v2)), 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::calculate_position_funding_internal(v3, v4, v5));
        };
        let v6 = if (0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::is_neg(v1)) {
            0
        } else {
            0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::to_balance(v1, (arg1.collateral_scalar as u256))
        };
        let v7 = 0x2::clock::timestamp_ms(arg7);
        let (v8, v9) = 0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::vault::apply_custody_mark<T1>(arg0, 0x2::object::id<PerpAccount<T0, T1>>(arg1), v6, v7);
        0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::events::emit_equity_mark(0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::vault::id<T1>(arg0), 2, 0x2::object::id<PerpAccount<T0, T1>>(arg1), v8, v9, v7);
    }

    public fun mark_empty_account<T0, T1>(arg0: &mut 0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::vault::Vault<T1>, arg1: &PerpAccount<T0, T1>, arg2: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg3: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg4: &0x2::clock::Clock) {
        assert_account<T0, T1>(arg1, arg0, arg3);
        assert!(arg1.clearing_house_id == 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>>(arg2), 0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::errors::perp_binding());
        assert_venue_empty<T0, T1>(arg1, arg2, arg3);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let (v1, v2) = 0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::vault::apply_custody_mark<T1>(arg0, 0x2::object::id<PerpAccount<T0, T1>>(arg1), 0, v0);
        0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::events::emit_equity_mark(0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::vault::id<T1>(arg0), 2, 0x2::object::id<PerpAccount<T0, T1>>(arg1), v1, v2, v0);
    }

    public fun new_account<T0, T1>(arg0: &mut 0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::vault::Vault<T1>, arg1: &0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::vault::VaultAdminCap<T1>, arg2: &0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::config::LotusConfig, arg3: u64, arg4: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg5: 0x2::object::ID, arg6: u8, arg7: u64, arg8: 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::authority::ACCOUNT, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : PerpAccount<T0, T1> {
        0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::config::assert_governance_active(arg2, arg3);
        0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::vault::assert_admin<T1>(arg0, arg1);
        0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::dex_adapter::assert_dex_allowed<T1>(arg0, arg2, 0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::config::dex_aftermath_perp());
        let v0 = PerpAccount<T0, T1>{
            id                : 0x2::object::new(arg10),
            config_id         : 0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::config::id(arg2),
            vault_id          : 0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::vault::id<T1>(arg0),
            af_account_id     : 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>>(arg4),
            account_num       : 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::account_id<T1>(arg4),
            clearing_house_id : arg5,
            collateral_scalar : 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::decimal_scalar_from_decimals((arg6 as u64)),
            mark_band_bps     : arg7,
            admin_cap         : arg8,
        };
        0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::vault::register_custody<T1>(arg0, 0x2::object::id<PerpAccount<T0, T1>>(&v0), 0x2::clock::timestamp_ms(arg9), 60000);
        v0
    }

    public fun retire_account<T0, T1>(arg0: &mut 0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::vault::Vault<T1>, arg1: &PerpAccount<T0, T1>, arg2: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg3: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg4: &0x2::clock::Clock) {
        assert_account<T0, T1>(arg1, arg0, arg3);
        assert!(arg1.clearing_house_id == 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>>(arg2), 0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::errors::perp_binding());
        assert_venue_empty<T0, T1>(arg1, arg2, arg3);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::vault::retire_custody<T1>(arg0, 0x2::object::id<PerpAccount<T0, T1>>(arg1), v0);
        0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::events::emit_custody_retired(0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::vault::id<T1>(arg0), 0x2::object::id<PerpAccount<T0, T1>>(arg1), false, v0);
    }

    public fun share_account<T0, T1>(arg0: PerpAccount<T0, T1>) {
        0x2::transfer::share_object<PerpAccount<T0, T1>>(arg0);
    }

    fun venue_mark_to_canonical<T0, T1>(arg0: &0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::oracle::PriceOracle<T0, T1>, arg1: u256) : u64 {
        assert!(!0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::is_neg(arg1), 0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::errors::perp_bad_mark());
        let v0 = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::one();
        assert!(v0 > 0, 0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::errors::perp_bad_mark());
        let v1 = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::abs(arg1) * 1000000000 / v0;
        assert!(v1 <= 18446744073709551615, 0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::errors::perp_bad_mark());
        0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::oracle::normalize_human<T0, T1>(arg0, (v1 as u128), 9)
    }

    public fun within_band(arg0: u64, arg1: u64, arg2: u64) : bool {
        let (v0, v1) = if (arg0 > arg1) {
            (arg1, arg0)
        } else {
            (arg0, arg1)
        };
        if (v0 == 0) {
            return false
        };
        ((v1 - v0) as u128) * 10000 <= (v0 as u128) * (arg2 as u128)
    }

    // decompiled from Move bytecode v7
}

