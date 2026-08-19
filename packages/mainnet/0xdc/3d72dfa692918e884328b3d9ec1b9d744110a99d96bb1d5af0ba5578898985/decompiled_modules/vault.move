module 0x941b6e22fc8748287026e3068858082a94415f8fae177361a1e6b9e744665c38::vault {
    struct AtomicFlashResult has copy, drop {
        vault_id: 0x2::object::ID,
        manager_id: 0x2::object::ID,
        debt_side: u8,
        flash_raw: u64,
        flash_due_raw: u64,
        profit_raw: u64,
    }

    struct VAULT has drop {
        dummy_field: bool,
    }

    struct LiquidationVault has key {
        id: 0x2::object::UID,
        balances: 0x2::bag::Bag,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
    }

    struct TraderCap has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
    }

    struct BalanceKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct AuthorizedTraderKey has copy, drop, store {
        pos0: address,
    }

    struct Liquidated has copy, drop {
        vault_id: 0x2::object::ID,
        manager_id: 0x2::object::ID,
        margin_pool_id: 0x2::object::ID,
        repay_in: u64,
        base_out: u64,
        quote_out: u64,
        repay_remaining: u64,
        base_debt: bool,
    }

    public fun balance<T0>(arg0: &LiquidationVault) : u64 {
        let v0 = BalanceKey<T0>{dummy_field: false};
        if (0x2::bag::contains<BalanceKey<T0>>(&arg0.balances, v0)) {
            0x2::balance::value<T0>(0x2::bag::borrow<BalanceKey<T0>, 0x2::balance::Balance<T0>>(&arg0.balances, v0))
        } else {
            0
        }
    }

    fun assert_admin(arg0: &LiquidationVault, arg1: &AdminCap) {
        assert!(arg1.vault_id == 0x2::object::id<LiquidationVault>(arg0), 0);
    }

    fun assert_authorized(arg0: &LiquidationVault, arg1: &0x2::tx_context::TxContext) {
        let v0 = AuthorizedTraderKey{pos0: 0x2::tx_context::sender(arg1)};
        assert!(0x2::dynamic_field::exists<AuthorizedTraderKey>(&arg0.id, v0), 3);
    }

    fun assert_trader(arg0: &LiquidationVault, arg1: &TraderCap) {
        assert!(arg1.vault_id == 0x2::object::id<LiquidationVault>(arg0), 0);
    }

    public fun authorize_trader(arg0: &mut LiquidationVault, arg1: &AdminCap, arg2: address) {
        assert_admin(arg0, arg1);
        let v0 = AuthorizedTraderKey{pos0: arg2};
        if (!0x2::dynamic_field::exists<AuthorizedTraderKey>(&arg0.id, v0)) {
            0x2::dynamic_field::add<AuthorizedTraderKey, bool>(&mut arg0.id, v0, true);
        };
    }

    public(friend) fun bounded_repay(arg0: 0x1::option::Option<u64>, arg1: u64) : u64 {
        let v0 = if (0x1::option::is_some<u64>(&arg0)) {
            0x1::option::destroy_some<u64>(arg0)
        } else {
            0x1::option::destroy_none<u64>(arg0);
            arg1
        };
        if (v0 < arg1) {
            v0
        } else {
            arg1
        }
    }

    public fun deauthorize_trader(arg0: &mut LiquidationVault, arg1: &AdminCap, arg2: address) {
        assert_admin(arg0, arg1);
        let v0 = AuthorizedTraderKey{pos0: arg2};
        if (0x2::dynamic_field::exists<AuthorizedTraderKey>(&arg0.id, v0)) {
            0x2::dynamic_field::remove<AuthorizedTraderKey, bool>(&mut arg0.id, v0);
        };
    }

    public fun deposit<T0>(arg0: &mut LiquidationVault, arg1: &AdminCap, arg2: 0x2::coin::Coin<T0>) {
        assert_admin(arg0, arg1);
        deposit_balance<T0>(arg0, 0x2::coin::into_balance<T0>(arg2));
    }

    fun deposit_balance<T0>(arg0: &mut LiquidationVault, arg1: 0x2::balance::Balance<T0>) {
        let v0 = BalanceKey<T0>{dummy_field: false};
        if (0x2::bag::contains<BalanceKey<T0>>(&arg0.balances, v0)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<BalanceKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0), arg1);
        } else {
            0x2::bag::add<BalanceKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0, arg1);
        };
    }

    fun init(arg0: VAULT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = LiquidationVault{
            id       : 0x2::object::new(arg1),
            balances : 0x2::bag::new(arg1),
        };
        let v1 = 0x2::object::id<LiquidationVault>(&v0);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::share_object<LiquidationVault>(v0);
        let v3 = AdminCap{
            id       : 0x2::object::new(arg1),
            vault_id : v1,
        };
        0x2::transfer::public_transfer<AdminCap>(v3, v2);
        let v4 = TraderCap{
            id       : 0x2::object::new(arg1),
            vault_id : v1,
        };
        0x2::transfer::public_transfer<TraderCap>(v4, v2);
    }

    public fun liquidate_base<T0, T1>(arg0: &mut LiquidationVault, arg1: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::MarginManager<T0, T1>, arg2: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>, arg3: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T1>, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg5: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &TraderCap, arg9: 0x1::option::Option<u64>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : bool {
        assert_trader(arg0, arg8);
        liquidate_base_core<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg9, arg10, arg11)
    }

    public fun liquidate_base_authorized<T0, T1>(arg0: &mut LiquidationVault, arg1: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::MarginManager<T0, T1>, arg2: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>, arg3: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T1>, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg5: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: 0x1::option::Option<u64>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : bool {
        assert_authorized(arg0, arg10);
        liquidate_base_core<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10)
    }

    fun liquidate_base_core<T0, T1>(arg0: &mut LiquidationVault, arg1: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::MarginManager<T0, T1>, arg2: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>, arg3: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T1>, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg5: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: 0x1::option::Option<u64>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : bool {
        if (!0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::has_base_debt<T0, T1>(arg1)) {
            return false
        };
        if (!0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::can_liquidate(arg5, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::id<T0, T1>(arg4), 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::risk_ratio<T0, T1>(arg1, arg5, arg6, arg7, arg4, arg2, arg3, arg9))) {
            return false
        };
        let v0 = bounded_repay(arg8, balance<T0>(arg0));
        if (v0 < 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_constants::min_liquidation_repay()) {
            return false
        };
        let v1 = withdraw_balance<T0>(arg0, v0);
        let (v2, v3, v4) = 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::liquidate<T0, T1, T0>(arg1, arg5, arg6, arg7, arg2, arg4, 0x2::coin::from_balance<T0>(v1, arg10), arg9, arg10);
        let v5 = v4;
        let v6 = v3;
        let v7 = v2;
        let v8 = 0x2::object::id<LiquidationVault>(arg0);
        0x2::coin::join<T0>(&mut v7, v5);
        deposit_balance<T0>(arg0, 0x2::coin::into_balance<T0>(v7));
        deposit_balance<T1>(arg0, 0x2::coin::into_balance<T1>(v6));
        let v9 = Liquidated{
            vault_id        : v8,
            manager_id      : 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::id<T0, T1>(arg1),
            margin_pool_id  : 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::id<T0>(arg2),
            repay_in        : v0,
            base_out        : 0x2::coin::value<T0>(&v7),
            quote_out       : 0x2::coin::value<T1>(&v6),
            repay_remaining : 0x2::coin::value<T0>(&v5),
            base_debt       : true,
        };
        0x2::event::emit<Liquidated>(v9);
        true
    }

    public fun liquidate_base_scallop_flash_authorized<T0, T1>(arg0: &mut LiquidationVault, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::MarginManager<T0, T1>, arg4: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>, arg5: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T1>, arg6: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg7: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg8: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg10: u64, arg11: u64, arg12: u64, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        assert_authorized(arg0, arg14);
        let v0 = 0x2::object::id<0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::MarginManager<T0, T1>>(arg3);
        let v1 = balance<T0>(arg0);
        let v2 = balance<T1>(arg0);
        let v3 = 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::risk_ratio<T0, T1>(arg3, arg7, arg8, arg9, arg6, arg4, arg5, arg13);
        assert!(0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::can_liquidate(arg7, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::id<T0, T1>(arg6), v3), 4);
        let (v4, v5) = 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::calculate_debts<T0, T1, T0>(arg3, arg4, arg13);
        assert!(v4 > 0 && v5 == 0, 4);
        let v6 = 0x1::u64::min(quote_flash_repay(v4, v3, 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::target_liquidation_risk_ratio(arg7, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::id<T0, T1>(arg6)), 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::user_liquidation_reward(arg7, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::id<T0, T1>(arg6)), 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::pool_liquidation_reward(arg7, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::id<T0, T1>(arg6))), arg10);
        assert!(v6 >= 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_constants::min_liquidation_repay(), 4);
        let (v7, v8) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::flash_loan::borrow_flash_loan<T0>(arg1, arg2, v6, arg14);
        let v9 = v8;
        let v10 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::flash_loan_loan_amount<T0>(&v9);
        deposit_balance<T0>(arg0, 0x2::coin::into_balance<T0>(v7));
        assert!(liquidate_base_core<T0, T1>(arg0, arg3, arg4, arg5, arg6, arg7, arg8, arg9, 0x1::option::some<u64>(v10), arg13, arg14), 4);
        let v11 = balance<T1>(arg0);
        assert!(v11 > v2, 4);
        assert!(rebalance_quote_to_base_core<T0, T1>(arg0, arg6, v11 - v2, arg11, arg13, arg14), 5);
        let v12 = v10 + 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::flash_loan_fee<T0>(&v9);
        assert!(v12 <= 18446744073709551615 - arg12, 5);
        assert!(v1 <= 18446744073709551615 - v12 - arg12, 5);
        let v13 = balance<T0>(arg0);
        assert!(v13 >= v1 + v12 + arg12, 5);
        let v14 = withdraw_balance<T0>(arg0, v12);
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::flash_loan::repay_flash_loan<T0>(arg1, arg2, 0x2::coin::from_balance<T0>(v14, arg14), v9, arg14);
        let v15 = AtomicFlashResult{
            vault_id      : 0x2::object::id<LiquidationVault>(arg0),
            manager_id    : v0,
            debt_side     : 0,
            flash_raw     : v10,
            flash_due_raw : v12,
            profit_raw    : v13 - v1 - v12,
        };
        0x2::event::emit<AtomicFlashResult>(v15);
    }

    public fun liquidate_quote<T0, T1>(arg0: &mut LiquidationVault, arg1: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::MarginManager<T0, T1>, arg2: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>, arg3: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T1>, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg5: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &TraderCap, arg9: 0x1::option::Option<u64>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : bool {
        assert_trader(arg0, arg8);
        liquidate_quote_core<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg9, arg10, arg11)
    }

    public fun liquidate_quote_authorized<T0, T1>(arg0: &mut LiquidationVault, arg1: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::MarginManager<T0, T1>, arg2: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>, arg3: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T1>, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg5: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: 0x1::option::Option<u64>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : bool {
        assert_authorized(arg0, arg10);
        liquidate_quote_core<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10)
    }

    fun liquidate_quote_core<T0, T1>(arg0: &mut LiquidationVault, arg1: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::MarginManager<T0, T1>, arg2: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>, arg3: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T1>, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg5: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: 0x1::option::Option<u64>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : bool {
        if (0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::has_base_debt<T0, T1>(arg1)) {
            return false
        };
        if (!0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::can_liquidate(arg5, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::id<T0, T1>(arg4), 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::risk_ratio<T0, T1>(arg1, arg5, arg6, arg7, arg4, arg2, arg3, arg9))) {
            return false
        };
        let v0 = bounded_repay(arg8, balance<T1>(arg0));
        if (v0 < 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_constants::min_liquidation_repay()) {
            return false
        };
        let v1 = withdraw_balance<T1>(arg0, v0);
        let (v2, v3, v4) = 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::liquidate<T0, T1, T1>(arg1, arg5, arg6, arg7, arg3, arg4, 0x2::coin::from_balance<T1>(v1, arg10), arg9, arg10);
        let v5 = v4;
        let v6 = v3;
        let v7 = v2;
        let v8 = 0x2::object::id<LiquidationVault>(arg0);
        0x2::coin::join<T1>(&mut v6, v5);
        deposit_balance<T0>(arg0, 0x2::coin::into_balance<T0>(v7));
        deposit_balance<T1>(arg0, 0x2::coin::into_balance<T1>(v6));
        let v9 = Liquidated{
            vault_id        : v8,
            manager_id      : 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::id<T0, T1>(arg1),
            margin_pool_id  : 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::id<T1>(arg3),
            repay_in        : v0,
            base_out        : 0x2::coin::value<T0>(&v7),
            quote_out       : 0x2::coin::value<T1>(&v6),
            repay_remaining : 0x2::coin::value<T1>(&v5),
            base_debt       : false,
        };
        0x2::event::emit<Liquidated>(v9);
        true
    }

    public fun liquidate_quote_scallop_flash_authorized<T0, T1>(arg0: &mut LiquidationVault, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::MarginManager<T0, T1>, arg4: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>, arg5: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T1>, arg6: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg7: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg8: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg10: u64, arg11: u64, arg12: u64, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        assert_authorized(arg0, arg14);
        let v0 = 0x2::object::id<0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::MarginManager<T0, T1>>(arg3);
        let v1 = balance<T1>(arg0);
        let v2 = balance<T0>(arg0);
        let v3 = 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::risk_ratio<T0, T1>(arg3, arg7, arg8, arg9, arg6, arg4, arg5, arg13);
        assert!(0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::can_liquidate(arg7, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::id<T0, T1>(arg6), v3), 4);
        let (v4, v5) = 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::calculate_debts<T0, T1, T1>(arg3, arg5, arg13);
        assert!(v4 == 0 && v5 > 0, 4);
        let v6 = 0x1::u64::min(quote_flash_repay(v5, v3, 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::target_liquidation_risk_ratio(arg7, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::id<T0, T1>(arg6)), 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::user_liquidation_reward(arg7, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::id<T0, T1>(arg6)), 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::pool_liquidation_reward(arg7, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::id<T0, T1>(arg6))), arg10);
        assert!(v6 >= 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_constants::min_liquidation_repay(), 4);
        let (v7, v8) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::flash_loan::borrow_flash_loan<T1>(arg1, arg2, v6, arg14);
        let v9 = v8;
        let v10 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::flash_loan_loan_amount<T1>(&v9);
        deposit_balance<T1>(arg0, 0x2::coin::into_balance<T1>(v7));
        assert!(liquidate_quote_core<T0, T1>(arg0, arg3, arg4, arg5, arg6, arg7, arg8, arg9, 0x1::option::some<u64>(v10), arg13, arg14), 4);
        let v11 = balance<T0>(arg0);
        assert!(v11 > v2, 4);
        assert!(rebalance_base_to_quote_core<T0, T1>(arg0, arg6, v11 - v2, arg11, arg13, arg14), 5);
        let v12 = v10 + 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::flash_loan_fee<T1>(&v9);
        assert!(v12 <= 18446744073709551615 - arg12, 5);
        assert!(v1 <= 18446744073709551615 - v12 - arg12, 5);
        let v13 = balance<T1>(arg0);
        assert!(v13 >= v1 + v12 + arg12, 5);
        let v14 = withdraw_balance<T1>(arg0, v12);
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::flash_loan::repay_flash_loan<T1>(arg1, arg2, 0x2::coin::from_balance<T1>(v14, arg14), v9, arg14);
        let v15 = AtomicFlashResult{
            vault_id      : 0x2::object::id<LiquidationVault>(arg0),
            manager_id    : v0,
            debt_side     : 1,
            flash_raw     : v10,
            flash_due_raw : v12,
            profit_raw    : v13 - v1 - v12,
        };
        0x2::event::emit<AtomicFlashResult>(v15);
    }

    public fun quote_flash_repay(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : u64 {
        if (arg0 == 0) {
            return 0
        };
        let v0 = (1000000000 as u128);
        let v1 = (arg0 as u128);
        let v2 = v0 + (arg3 as u128) + (arg4 as u128);
        let v3 = (arg2 as u128);
        assert!(v3 > v2, 4);
        let v4 = v1 * (arg1 as u128) / v0;
        let v5 = v1 * v3 / v0;
        if (v5 <= v4) {
            return 0
        };
        let v6 = (0x1::u128::min(0x1::u128::min((v5 - v4) * v0 / (v3 - v2), v1) * v2 / v0, v4) * v0 / v2 * (v0 + (arg4 as u128)) + v0 - 1) / v0;
        assert!(v6 <= 18446744073709551615, 4);
        (v6 as u64)
    }

    public fun rebalance_base_to_quote<T0, T1>(arg0: &mut LiquidationVault, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: &TraderCap, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : bool {
        assert_trader(arg0, arg2);
        rebalance_base_to_quote_core<T0, T1>(arg0, arg1, arg3, arg4, arg5, arg6)
    }

    public fun rebalance_base_to_quote_authorized<T0, T1>(arg0: &mut LiquidationVault, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : bool {
        assert_authorized(arg0, arg5);
        rebalance_base_to_quote_core<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    fun rebalance_base_to_quote_core<T0, T1>(arg0: &mut LiquidationVault, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : bool {
        assert!(arg3 <= 10000, 2);
        let v0 = balance<T0>(arg0);
        let v1 = if (arg2 < v0) {
            arg2
        } else {
            v0
        };
        if (v1 == 0) {
            return false
        };
        let (_, v3, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quote_quantity_out_input_fee<T0, T1>(arg1, v1, arg4);
        if (v3 == 0) {
            return false
        };
        let v5 = withdraw_balance<T0>(arg0, v1);
        let (v6, v7, v8) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_base_for_quote<T0, T1>(arg1, 0x2::coin::from_balance<T0>(v5, arg5), 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg5), (((v3 as u128) * ((10000 - arg3) as u128) / (10000 as u128)) as u64), arg4, arg5);
        deposit_balance<T0>(arg0, 0x2::coin::into_balance<T0>(v6));
        deposit_balance<T1>(arg0, 0x2::coin::into_balance<T1>(v7));
        deposit_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg0, 0x2::coin::into_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v8));
        true
    }

    public fun rebalance_quote_to_base<T0, T1>(arg0: &mut LiquidationVault, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: &TraderCap, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : bool {
        assert_trader(arg0, arg2);
        rebalance_quote_to_base_core<T0, T1>(arg0, arg1, arg3, arg4, arg5, arg6)
    }

    public fun rebalance_quote_to_base_authorized<T0, T1>(arg0: &mut LiquidationVault, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : bool {
        assert_authorized(arg0, arg5);
        rebalance_quote_to_base_core<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    fun rebalance_quote_to_base_core<T0, T1>(arg0: &mut LiquidationVault, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : bool {
        assert!(arg3 <= 10000, 2);
        let v0 = balance<T1>(arg0);
        let v1 = if (arg2 < v0) {
            arg2
        } else {
            v0
        };
        if (v1 == 0) {
            return false
        };
        let (v2, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_base_quantity_out_input_fee<T0, T1>(arg1, v1, arg4);
        if (v2 == 0) {
            return false
        };
        let v5 = withdraw_balance<T1>(arg0, v1);
        let (v6, v7, v8) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quote_for_base<T0, T1>(arg1, 0x2::coin::from_balance<T1>(v5, arg5), 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg5), (((v2 as u128) * ((10000 - arg3) as u128) / (10000 as u128)) as u64), arg4, arg5);
        deposit_balance<T0>(arg0, 0x2::coin::into_balance<T0>(v6));
        deposit_balance<T1>(arg0, 0x2::coin::into_balance<T1>(v7));
        deposit_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg0, 0x2::coin::into_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v8));
        true
    }

    public fun withdraw<T0>(arg0: &mut LiquidationVault, arg1: &AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_admin(arg0, arg1);
        0x2::coin::from_balance<T0>(withdraw_balance<T0>(arg0, arg2), arg3)
    }

    fun withdraw_balance<T0>(arg0: &mut LiquidationVault, arg1: u64) : 0x2::balance::Balance<T0> {
        let v0 = BalanceKey<T0>{dummy_field: false};
        assert!(0x2::bag::contains<BalanceKey<T0>>(&arg0.balances, v0), 1);
        let v1 = 0x2::bag::borrow_mut<BalanceKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0);
        assert!(0x2::balance::value<T0>(v1) >= arg1, 1);
        0x2::balance::split<T0>(v1, arg1)
    }

    // decompiled from Move bytecode v7
}

