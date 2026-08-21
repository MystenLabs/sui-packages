module 0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::deepbook_adapter {
    struct DeepBookAccount<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        config_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        balance_manager_id: 0x2::object::ID,
        deposit_cap: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::DepositCap,
        withdraw_cap: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::WithdrawCap,
        trade_cap: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap,
    }

    public fun cancel_order<T0, T1>(arg0: &0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::vault::Vault<T1>, arg1: &DeepBookAccount<T0, T1>, arg2: &0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::vault::VaultTradeCap<T1>, arg3: &0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::config::LotusConfig, arg4: u64, arg5: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg6: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg7: u128, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::config::assert_not_paused(arg3, arg4);
        0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::vault::assert_trade_cap<T1>(arg0, arg2);
        assert_account<T0, T1>(arg1, arg0, arg5);
        assert!(arg1.pool_id == 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg6), 0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::errors::pool_not_allowed());
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_trader(arg5, &arg1.trade_cap, arg9);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_order<T0, T1>(arg6, arg5, &v0, arg7, arg8, arg9);
    }

    public fun place_limit_order<T0, T1>(arg0: &mut 0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::vault::Vault<T1>, arg1: &DeepBookAccount<T0, T1>, arg2: &0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::vault::VaultTradeCap<T1>, arg3: &0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::config::LotusConfig, arg4: u64, arg5: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg6: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg7: u64, arg8: u8, arg9: u8, arg10: u64, arg11: u64, arg12: bool, arg13: u64, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) : u128 {
        0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::vault::assert_active_vault<T1>(arg0, arg3, arg4);
        0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::vault::assert_trade_cap<T1>(arg0, arg2);
        assert_account<T0, T1>(arg1, arg0, arg5);
        assert!(arg1.pool_id == 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg6), 0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::errors::pool_not_allowed());
        0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::risk::assert_order_size(arg11, 0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::config::risk_max_order_size(0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::config::risk_config(arg3)));
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_trader(arg5, &arg1.trade_cap, arg15);
        let v1 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg6, arg5, &v0, arg7, arg8, arg9, arg10, arg11, arg12, false, arg13, arg14, arg15);
        0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::vault::invalidate_custody_mark<T1>(arg0, 0x2::object::id<DeepBookAccount<T0, T1>>(arg1));
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::order_id(&v1)
    }

    public fun account_balance_manager_id<T0, T1>(arg0: &DeepBookAccount<T0, T1>) : 0x2::object::ID {
        arg0.balance_manager_id
    }

    public fun account_pool_id<T0, T1>(arg0: &DeepBookAccount<T0, T1>) : 0x2::object::ID {
        arg0.pool_id
    }

    public fun account_vault_id<T0, T1>(arg0: &DeepBookAccount<T0, T1>) : 0x2::object::ID {
        arg0.vault_id
    }

    fun assert_account<T0, T1>(arg0: &DeepBookAccount<T0, T1>, arg1: &0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::vault::Vault<T1>, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager) {
        assert!(arg0.vault_id == 0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::vault::id<T1>(arg1), 0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::errors::vault_mismatch());
        assert!(arg0.balance_manager_id == 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(arg2), 0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::errors::vault_mismatch());
    }

    public fun balances<T0, T1>(arg0: &DeepBookAccount<T0, T1>, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager) : (u64, u64) {
        assert!(arg0.balance_manager_id == 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(arg1), 0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::errors::vault_mismatch());
        (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg1), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg1))
    }

    fun bm_swap_finish<T0, T1>(arg0: &mut 0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::vault::Vault<T1>, arg1: &DeepBookAccount<T0, T1>, arg2: u8, arg3: 0x2::object::ID, arg4: bool, arg5: u64, arg6: u64, arg7: u64) {
        assert!(arg6 >= arg7, 0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::errors::swap_shortfall());
        0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::vault::invalidate_custody_mark<T1>(arg0, 0x2::object::id<DeepBookAccount<T0, T1>>(arg1));
        0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::events::emit_bm_swap(0x2::object::id<DeepBookAccount<T0, T1>>(arg1), arg1.vault_id, arg2, arg3, arg4, arg5, arg6);
    }

    fun bm_swap_guards<T0, T1>(arg0: &0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::vault::Vault<T1>, arg1: &DeepBookAccount<T0, T1>, arg2: &0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::vault::VaultTradeCap<T1>, arg3: &0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::config::LotusConfig, arg4: u64, arg5: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg6: u8, arg7: 0x2::object::ID, arg8: u64) {
        0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::vault::assert_active_vault<T1>(arg0, arg3, arg4);
        0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::vault::assert_trade_cap<T1>(arg0, arg2);
        assert_account<T0, T1>(arg1, arg0, arg5);
        0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::dex_adapter::assert_dex_allowed<T1>(arg0, arg3, arg6);
        0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::dex_adapter::assert_pool_allowed<T1>(arg0, arg7);
        0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::risk::assert_order_size(arg8, 0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::config::risk_max_order_size(0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::config::risk_config(arg3)));
    }

    public fun cancel_all<T0, T1>(arg0: &0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::vault::Vault<T1>, arg1: &DeepBookAccount<T0, T1>, arg2: &0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::vault::VaultAdminCap<T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::vault::assert_admin<T1>(arg0, arg2);
        assert_account<T0, T1>(arg1, arg0, arg3);
        assert!(arg1.pool_id == 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg4), 0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::errors::pool_not_allowed());
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_trader(arg3, &arg1.trade_cap, arg6);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<T0, T1>(arg4, arg3, &v0, arg5, arg6);
    }

    public fun defund<T0, T1>(arg0: &mut 0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::vault::Vault<T1>, arg1: &DeepBookAccount<T0, T1>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::vault::VaultAdminCap<T1>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::vault::assert_admin<T1>(arg0, arg3);
        assert_account<T0, T1>(arg1, arg0, arg2);
        0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::vault::custody_sub<T1>(arg0, 0x2::object::id<DeepBookAccount<T0, T1>>(arg1), arg4);
        0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::vault::strategy_put_quote<T1>(arg0, 0x2::coin::into_balance<T1>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw_with_cap<T1>(arg2, &arg1.withdraw_cap, arg4, arg5)));
        0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::vault::strategy_settle_principal<T1>(arg0, arg4, arg4);
        0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::events::emit_adapter_flow(0x2::object::id<DeepBookAccount<T0, T1>>(arg1), arg1.vault_id, arg4, 2);
    }

    public fun defund_base<T0, T1>(arg0: &mut 0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::vault::Vault<T1>, arg1: &DeepBookAccount<T0, T1>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::vault::VaultAdminCap<T1>, arg4: &0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::oracle::PriceOracle<T0, T1>, arg5: &0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::config::LotusConfig, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::vault::assert_admin<T1>(arg0, arg3);
        assert_account<T0, T1>(arg1, arg0, arg2);
        let v0 = 0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::oracle::quote_value(arg6, 0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::oracle::fresh_price<T0, T1>(arg4, arg5, arg7));
        0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::vault::custody_sub<T1>(arg0, 0x2::object::id<DeepBookAccount<T0, T1>>(arg1), v0);
        0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::vault::strategy_put_aux<T1, T0>(arg0, 0x2::coin::into_balance<T0>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw_with_cap<T0>(arg2, &arg1.withdraw_cap, arg6, arg8)), v0, 0x2::clock::timestamp_ms(arg7));
        0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::vault::strategy_settle_principal<T1>(arg0, v0, v0);
        0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::events::emit_adapter_flow(0x2::object::id<DeepBookAccount<T0, T1>>(arg1), arg1.vault_id, v0, 3);
    }

    public fun fund<T0, T1>(arg0: &mut 0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::vault::Vault<T1>, arg1: &DeepBookAccount<T0, T1>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::vault::VaultAdminCap<T1>, arg4: &0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::config::LotusConfig, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::config::assert_active(arg4, arg5);
        0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::vault::assert_admin<T1>(arg0, arg3);
        assert_account<T0, T1>(arg1, arg0, arg2);
        0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::vault::custody_add<T1>(arg0, 0x2::object::id<DeepBookAccount<T0, T1>>(arg1), arg6);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit_with_cap<T1>(arg2, &arg1.deposit_cap, 0x2::coin::from_balance<T1>(0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::vault::strategy_take_quote<T1>(arg0, arg6), arg7), arg7);
        0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::events::emit_adapter_flow(0x2::object::id<DeepBookAccount<T0, T1>>(arg1), arg1.vault_id, arg6, 1);
    }

    public fun mark_account<T0, T1>(arg0: &mut 0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::vault::Vault<T1>, arg1: &DeepBookAccount<T0, T1>, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg4: &0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::oracle::PriceOracle<T0, T1>, arg5: &0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::config::LotusConfig, arg6: &0x2::clock::Clock) {
        assert!(arg1.vault_id == 0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::vault::id<T1>(arg0), 0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::errors::vault_mismatch());
        assert!(arg1.balance_manager_id == 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(arg2), 0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::errors::vault_mismatch());
        assert!(arg1.pool_id == 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg3), 0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::errors::pool_not_allowed());
        let v0 = 0;
        let v1 = 0;
        let v2 = 0x2::vec_set::into_keys<u128>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::account_open_orders<T0, T1>(arg3, arg2));
        let v3 = 0;
        while (v3 < 0x1::vector::length<u128>(&v2)) {
            let v4 = *0x1::vector::borrow<u128>(&v2, v3);
            let v5 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_order<T0, T1>(arg3, v4);
            if (v4 >> 127 == 0) {
                v0 = v0 + ((((0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::quantity(&v5) - 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::filled_quantity(&v5)) as u128) * (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::price(&v5) as u128) / 1000000000) as u64);
            } else {
                v1 = v1 + 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::quantity(&v5) - 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::filled_quantity(&v5);
            };
            v3 = v3 + 1;
        };
        let v6 = 0x2::clock::timestamp_ms(arg6);
        let (v7, v8) = 0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::vault::apply_custody_mark<T1>(arg0, 0x2::object::id<DeepBookAccount<T0, T1>>(arg1), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg2) + v0 + 0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::oracle::quote_value(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg2) + v1, 0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::oracle::fresh_price<T0, T1>(arg4, arg5, arg6)), v6);
        0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::events::emit_equity_mark(0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::vault::id<T1>(arg0), 2, 0x2::object::id<DeepBookAccount<T0, T1>>(arg1), v7, v8, v6);
    }

    public fun new_account<T0, T1>(arg0: &mut 0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::vault::Vault<T1>, arg1: &0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::vault::VaultAdminCap<T1>, arg2: &0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::config::LotusConfig, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : DeepBookAccount<T0, T1> {
        0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::config::assert_governance(arg2);
        0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::vault::assert_admin<T1>(arg0, arg1);
        0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::dex_adapter::assert_dex_allowed<T1>(arg0, arg2, 0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::config::dex_deepbook());
        0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::dex_adapter::assert_pool_allowed<T1>(arg0, arg3);
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::new(arg5);
        let v1 = DeepBookAccount<T0, T1>{
            id                 : 0x2::object::new(arg5),
            config_id          : 0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::config::id(arg2),
            vault_id           : 0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::vault::id<T1>(arg0),
            pool_id            : arg3,
            balance_manager_id : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(&v0),
            deposit_cap        : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::mint_deposit_cap(&mut v0, arg5),
            withdraw_cap       : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::mint_withdraw_cap(&mut v0, arg5),
            trade_cap          : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::mint_trade_cap(&mut v0, arg5),
        };
        0x2::transfer::public_share_object<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(v0);
        0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::vault::register_custody<T1>(arg0, 0x2::object::id<DeepBookAccount<T0, T1>>(&v1), 0x2::clock::timestamp_ms(arg4));
        v1
    }

    public fun open_orders<T0, T1>(arg0: &DeepBookAccount<T0, T1>, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager) : vector<u128> {
        assert!(arg0.pool_id == 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg1), 0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::errors::pool_not_allowed());
        assert!(arg0.balance_manager_id == 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(arg2), 0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::errors::vault_mismatch());
        0x2::vec_set::into_keys<u128>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::account_open_orders<T0, T1>(arg1, arg2))
    }

    public fun share_account<T0, T1>(arg0: DeepBookAccount<T0, T1>) {
        0x2::transfer::share_object<DeepBookAccount<T0, T1>>(arg0);
    }

    public fun swap_via_manager_bluefin<T0, T1>(arg0: &mut 0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::vault::Vault<T1>, arg1: &DeepBookAccount<T0, T1>, arg2: &0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::vault::VaultTradeCap<T1>, arg3: &0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::config::LotusConfig, arg4: u64, arg5: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg6: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg7: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg8: bool, arg9: u64, arg10: u64, arg11: u128, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        bm_swap_guards<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, 0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::config::dex_bluefin(), 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg7), arg9);
        let (v0, v1) = if (arg8) {
            let (v2, v3) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T0, T1>(arg12, arg6, arg7, 0x2::coin::into_balance<T0>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw_with_cap<T0>(arg5, &arg1.withdraw_cap, arg9, arg13)), 0x2::balance::zero<T1>(), true, true, arg9, arg10, arg11);
            let v4 = v3;
            let v5 = v2;
            let v6 = 0x2::balance::value<T0>(&v5);
            if (v6 > 0) {
                0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit_with_cap<T0>(arg5, &arg1.deposit_cap, 0x2::coin::from_balance<T0>(v5, arg13), arg13);
            } else {
                0x2::balance::destroy_zero<T0>(v5);
            };
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit_with_cap<T1>(arg5, &arg1.deposit_cap, 0x2::coin::from_balance<T1>(v4, arg13), arg13);
            (arg9 - v6, 0x2::balance::value<T1>(&v4))
        } else {
            let (v7, v8) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T0, T1>(arg12, arg6, arg7, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw_with_cap<T1>(arg5, &arg1.withdraw_cap, arg9, arg13)), false, true, arg9, arg10, arg11);
            let v9 = v8;
            let v10 = v7;
            let v11 = 0x2::balance::value<T1>(&v9);
            if (v11 > 0) {
                0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit_with_cap<T1>(arg5, &arg1.deposit_cap, 0x2::coin::from_balance<T1>(v9, arg13), arg13);
            } else {
                0x2::balance::destroy_zero<T1>(v9);
            };
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit_with_cap<T0>(arg5, &arg1.deposit_cap, 0x2::coin::from_balance<T0>(v10, arg13), arg13);
            (arg9 - v11, 0x2::balance::value<T0>(&v10))
        };
        bm_swap_finish<T0, T1>(arg0, arg1, 0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::config::dex_bluefin(), 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg7), arg8, v0, v1, arg10);
        (v0, v1)
    }

    public fun swap_via_manager_cetus<T0, T1>(arg0: &mut 0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::vault::Vault<T1>, arg1: &DeepBookAccount<T0, T1>, arg2: &0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::vault::VaultTradeCap<T1>, arg3: &0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::config::LotusConfig, arg4: u64, arg5: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg6: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg8: bool, arg9: u64, arg10: u64, arg11: u128, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        bm_swap_guards<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, 0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::config::dex_cetus(), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg7), arg9);
        let v0 = if (arg8) {
            let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T0>(arg6, arg7, false, true, arg9, arg11, arg12);
            let v4 = v3;
            let v5 = v1;
            assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T0>(&v4) == arg9, 0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::errors::swap_debt_mismatch());
            0x2::balance::destroy_zero<T0>(v2);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T0>(arg6, arg7, 0x2::balance::zero<T1>(), 0x2::coin::into_balance<T0>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw_with_cap<T0>(arg5, &arg1.withdraw_cap, arg9, arg13)), v4);
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit_with_cap<T1>(arg5, &arg1.deposit_cap, 0x2::coin::from_balance<T1>(v5, arg13), arg13);
            0x2::balance::value<T1>(&v5)
        } else {
            let (v6, v7, v8) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T0>(arg6, arg7, true, true, arg9, arg11, arg12);
            let v9 = v8;
            let v10 = v7;
            assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T0>(&v9) == arg9, 0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::errors::swap_debt_mismatch());
            0x2::balance::destroy_zero<T1>(v6);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T0>(arg6, arg7, 0x2::coin::into_balance<T1>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw_with_cap<T1>(arg5, &arg1.withdraw_cap, arg9, arg13)), 0x2::balance::zero<T0>(), v9);
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit_with_cap<T0>(arg5, &arg1.deposit_cap, 0x2::coin::from_balance<T0>(v10, arg13), arg13);
            0x2::balance::value<T0>(&v10)
        };
        bm_swap_finish<T0, T1>(arg0, arg1, 0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::config::dex_cetus(), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg7), arg8, arg9, v0, arg10);
        (arg9, v0)
    }

    public fun swap_via_manager_momentum<T0, T1>(arg0: &mut 0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::vault::Vault<T1>, arg1: &DeepBookAccount<T0, T1>, arg2: &0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::vault::VaultTradeCap<T1>, arg3: &0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::config::LotusConfig, arg4: u64, arg5: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg6: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg7: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg8: bool, arg9: u64, arg10: u64, arg11: u128, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        bm_swap_guards<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, 0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::config::dex_momentum(), 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>>(arg6), arg9);
        let v0 = if (arg8) {
            let (v1, v2, v3) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg6, true, true, arg9, arg11, arg12, arg7, arg13);
            let v4 = v3;
            let v5 = v2;
            let (v6, v7) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v4);
            assert!(v6 == arg9 && v7 == 0, 0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::errors::swap_debt_mismatch());
            0x2::balance::destroy_zero<T0>(v1);
            0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg6, v4, 0x2::coin::into_balance<T0>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw_with_cap<T0>(arg5, &arg1.withdraw_cap, arg9, arg13)), 0x2::balance::zero<T1>(), arg7, arg13);
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit_with_cap<T1>(arg5, &arg1.deposit_cap, 0x2::coin::from_balance<T1>(v5, arg13), arg13);
            0x2::balance::value<T1>(&v5)
        } else {
            let (v8, v9, v10) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg6, false, true, arg9, arg11, arg12, arg7, arg13);
            let v11 = v10;
            let v12 = v8;
            let (v13, v14) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v11);
            assert!(v14 == arg9 && v13 == 0, 0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::errors::swap_debt_mismatch());
            0x2::balance::destroy_zero<T1>(v9);
            0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg6, v11, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw_with_cap<T1>(arg5, &arg1.withdraw_cap, arg9, arg13)), arg7, arg13);
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit_with_cap<T0>(arg5, &arg1.deposit_cap, 0x2::coin::from_balance<T0>(v12, arg13), arg13);
            0x2::balance::value<T0>(&v12)
        };
        bm_swap_finish<T0, T1>(arg0, arg1, 0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::config::dex_momentum(), 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>>(arg6), arg8, arg9, v0, arg10);
        (arg9, v0)
    }

    // decompiled from Move bytecode v7
}

