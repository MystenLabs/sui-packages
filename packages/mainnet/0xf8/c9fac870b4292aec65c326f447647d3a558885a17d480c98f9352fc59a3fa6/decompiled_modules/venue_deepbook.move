module 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::venue_deepbook {
    struct DeepBookBinding<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        config_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
        kernel_id: 0x2::object::ID,
        balance_manager_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        deposit_cap: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::DepositCap,
        withdraw_cap: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::WithdrawCap,
        trade_cap: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap,
    }

    fun assert_binding<T0, T1>(arg0: &DeepBookBinding<T0, T1>, arg1: &0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::Vault<T1>, arg2: &0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::MakerKernel<T0, T1>, arg3: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg4: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>) {
        assert!(arg0.vault_id == 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::id<T1>(arg1), 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::errors::maker_binding_mismatch());
        assert!(arg0.kernel_id == 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::kernel_id<T0, T1>(arg2), 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::errors::maker_binding_mismatch());
        assert!(arg0.balance_manager_id == 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(arg3), 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::errors::maker_binding_mismatch());
        assert!(arg0.pool_id == 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg4), 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::errors::maker_binding_mismatch());
    }

    public fun binding_balance_manager_id<T0, T1>(arg0: &DeepBookBinding<T0, T1>) : 0x2::object::ID {
        arg0.balance_manager_id
    }

    public fun binding_kernel_id<T0, T1>(arg0: &DeepBookBinding<T0, T1>) : 0x2::object::ID {
        arg0.kernel_id
    }

    public fun binding_pool_id<T0, T1>(arg0: &DeepBookBinding<T0, T1>) : 0x2::object::ID {
        arg0.pool_id
    }

    fun cancel_side<T0, T1>(arg0: &mut 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::Vault<T1>, arg1: &mut 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::MakerKernel<T0, T1>, arg2: &mut 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::venue::VenueControls<T0, T1>, arg3: u8, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg5: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg6: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof, arg7: u8, arg8: u32, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : u32 {
        let v0 = 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::leg<T0, T1>(arg1, arg7);
        if (!0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::leg_is_resting(&v0)) {
            return arg8
        };
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_order<T0, T1>(arg5, arg4, arg6, 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::leg_order_id(&v0), arg9, arg10);
        0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::venue::close_position<T0, T1>(arg2, arg3, 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::record_cleared<T0, T1>(arg1, arg7));
        let v1 = if (arg7 == 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::side_bid()) {
            0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::r_bid_cancelled()
        } else {
            0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::r_ask_cancelled()
        };
        arg8 | v1
    }

    public fun close_out<T0, T1>(arg0: &mut 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::Vault<T1>, arg1: &0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::MakerKernel<T0, T1>, arg2: &DeepBookBinding<T0, T1>, arg3: &0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::VaultAdminCap<T1>, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg5: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::assert_admin<T1>(arg0, arg3);
        assert!(arg2.vault_id == 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::id<T1>(arg0), 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::errors::maker_binding_mismatch());
        assert!(arg2.kernel_id == 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::kernel_id<T0, T1>(arg1), 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::errors::maker_binding_mismatch());
        assert!(arg2.balance_manager_id == 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(arg4), 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::errors::maker_binding_mismatch());
        assert!(arg2.pool_id == 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg5), 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::errors::maker_binding_mismatch());
        let v0 = 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::leg<T0, T1>(arg1, 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::side_bid());
        let v1 = 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::leg<T0, T1>(arg1, 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::side_ask());
        assert!(!0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::leg_is_resting(&v0), 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::errors::maker_not_flat());
        assert!(!0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::leg_is_resting(&v1), 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::errors::maker_not_flat());
        let v2 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::account_open_orders<T0, T1>(arg5, arg4);
        assert!(0x2::vec_set::is_empty<u128>(&v2), 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::errors::maker_not_flat());
        assert!(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg4) == 0, 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::errors::maker_not_flat());
        let v3 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg4);
        if (v3 > 0) {
            0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::strategy_put_quote<T1>(arg0, 0x2::coin::into_balance<T1>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw_with_cap<T1>(arg4, &arg2.withdraw_cap, v3, arg7)));
        };
        0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::strategy_settle_principal<T1>(arg0, arg6, v3);
        0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::events::emit_mf(0x2::object::id<DeepBookBinding<T0, T1>>(arg2), v3, 4);
    }

    public fun defund<T0, T1>(arg0: &mut 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::Vault<T1>, arg1: &DeepBookBinding<T0, T1>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::VaultAdminCap<T1>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::assert_admin<T1>(arg0, arg3);
        assert!(arg1.vault_id == 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::id<T1>(arg0), 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::errors::maker_binding_mismatch());
        assert!(arg1.balance_manager_id == 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(arg2), 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::errors::maker_binding_mismatch());
        0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::strategy_put_quote<T1>(arg0, 0x2::coin::into_balance<T1>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw_with_cap<T1>(arg2, &arg1.withdraw_cap, arg4, arg5)));
        0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::strategy_settle_principal<T1>(arg0, arg4, arg4);
        0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::events::emit_mf(0x2::object::id<DeepBookBinding<T0, T1>>(arg1), arg4, 2);
    }

    public fun defund_base<T0, T1>(arg0: &mut 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::Vault<T1>, arg1: &DeepBookBinding<T0, T1>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::VaultAdminCap<T1>, arg4: &0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::price::PriceReceipt, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::assert_admin<T1>(arg0, arg3);
        assert!(arg1.vault_id == 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::id<T1>(arg0), 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::errors::maker_binding_mismatch());
        assert!(arg1.balance_manager_id == 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(arg2), 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::errors::maker_binding_mismatch());
        assert!(0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::price::receipt_vault_id(arg4) == 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::id<T1>(arg0), 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::errors::price_receipt_mismatch());
        assert!(0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::price::receipt_scale(arg4) == 1000000000, 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::errors::maker_scale_mismatch());
        let v0 = 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::price::quote_value_down(arg5, 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::price::receipt_price(arg4), 1000000000);
        0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::strategy_put_aux<T1, T0>(arg0, 0x2::coin::into_balance<T0>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw_with_cap<T0>(arg2, &arg1.withdraw_cap, arg5, arg6)));
        0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::strategy_settle_principal<T1>(arg0, v0, v0);
        0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::events::emit_mf(0x2::object::id<DeepBookBinding<T0, T1>>(arg1), v0, 3);
    }

    public fun external_bbo<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: u64, arg3: &0x2::clock::Clock) : (u64, u64, bool) {
        let v0 = external_best<T0, T1>(arg0, arg1, true, arg2, arg3);
        let v1 = external_best<T0, T1>(arg0, arg1, false, arg2, arg3);
        let v2 = if (v0 > 0) {
            if (v1 > 0) {
                v1 > v0
            } else {
                false
            }
        } else {
            false
        };
        (v0, v1, v2)
    }

    public fun external_best<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: bool, arg3: u64, arg4: &0x2::clock::Clock) : u64 {
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_query::iter_orders<T0, T1>(arg0, 0x1::option::none<u128>(), 0x1::option::none<u128>(), 0x1::option::some<u64>(0x2::clock::timestamp_ms(arg4)), 64, arg2);
        let v1 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_query::orders(&v0);
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order>(v1)) {
            let v3 = 0x1::vector::borrow<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order>(v1, v2);
            if (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::balance_manager_id(v3) != 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(arg1)) {
                return 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::price(v3)
            };
            v2 = v2 + 1;
        };
        0
    }

    public fun flatten<T0, T1>(arg0: &mut 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::Vault<T1>, arg1: &mut 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::MakerKernel<T0, T1>, arg2: &DeepBookBinding<T0, T1>, arg3: &0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::VaultAdminCap<T1>, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg5: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::assert_admin<T1>(arg0, arg3);
        assert_binding<T0, T1>(arg2, arg0, arg1, arg4, arg5);
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_trader(arg4, &arg2.trade_cap, arg7);
        let v1 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::account_open_orders<T0, T1>(arg5, arg4);
        let v2 = flatten_leg<T0, T1>(arg1, arg4, arg5, &v0, &v1, 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::side_bid(), 0, arg6, arg7);
        let v3 = flatten_leg<T0, T1>(arg1, arg4, arg5, &v0, &v1, 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::side_ask(), v2, arg6, arg7);
        0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::emit_cycle<T0, T1>(arg1, v3);
    }

    public fun flatten2<T0, T1>(arg0: &mut 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::Vault<T1>, arg1: &mut 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::MakerKernel<T0, T1>, arg2: &DeepBookBinding<T0, T1>, arg3: &mut 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::venue::VenueControls<T0, T1>, arg4: &0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::VaultAdminCap<T1>, arg5: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg6: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::assert_admin<T1>(arg0, arg4);
        assert_binding<T0, T1>(arg2, arg0, arg1, arg5, arg6);
        let v0 = 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::kernel_venue<T0, T1>(arg1);
        let v1 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_trader(arg5, &arg2.trade_cap, arg8);
        let v2 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::account_open_orders<T0, T1>(arg6, arg5);
        let v3 = sweep_untracked<T0, T1>(arg1, arg5, arg6, &v1, &v2, 0, arg7, arg8);
        let v4 = note_fill<T0, T1>(arg1, arg3, v0, &v2, 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::side_bid(), v3);
        let v5 = note_fill<T0, T1>(arg1, arg3, v0, &v2, 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::side_ask(), v4);
        let v6 = cancel_side<T0, T1>(arg0, arg1, arg3, v0, arg5, arg6, &v1, 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::side_bid(), v5, arg7, arg8);
        let v7 = cancel_side<T0, T1>(arg0, arg1, arg3, v0, arg5, arg6, &v1, 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::side_ask(), v6, arg7, arg8);
        0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::emit_cycle<T0, T1>(arg1, v7);
    }

    fun flatten_leg<T0, T1>(arg0: &mut 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::MakerKernel<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof, arg4: &0x2::vec_set::VecSet<u128>, arg5: u8, arg6: u32, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : u32 {
        let v0 = 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::leg<T0, T1>(arg0, arg5);
        if (!0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::leg_is_resting(&v0)) {
            return arg6
        };
        let v1 = 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::leg_order_id(&v0);
        if (0x2::vec_set::contains<u128>(arg4, &v1)) {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_order<T0, T1>(arg2, arg1, arg3, 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::leg_order_id(&v0), arg7, arg8);
            let v2 = if (arg5 == 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::side_bid()) {
                0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::r_bid_cancelled()
            } else {
                0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::r_ask_cancelled()
            };
            arg6 = arg6 | v2;
        } else {
            let v3 = if (arg5 == 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::side_bid()) {
                0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::r_bid_filled()
            } else {
                0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::r_ask_filled()
            };
            arg6 = arg6 | v3;
        };
        0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::record_cleared<T0, T1>(arg0, arg5);
        arg6
    }

    public fun fund<T0, T1>(arg0: &mut 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::Vault<T1>, arg1: &DeepBookBinding<T0, T1>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::VaultAdminCap<T1>, arg4: &0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::config::LotusConfig, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::config::assert_product_active(arg4, arg5, 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::config::product_trade());
        0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::assert_admin<T1>(arg0, arg3);
        assert!(arg1.vault_id == 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::id<T1>(arg0), 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::errors::maker_binding_mismatch());
        assert!(arg1.balance_manager_id == 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(arg2), 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::errors::maker_binding_mismatch());
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit_with_cap<T1>(arg2, &arg1.deposit_cap, 0x2::coin::from_balance<T1>(0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::strategy_take_quote<T1>(arg0, arg6), arg7), arg7);
        0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::events::emit_mf(0x2::object::id<DeepBookBinding<T0, T1>>(arg1), arg6, 1);
    }

    fun grid_floor(arg0: u64, arg1: u64) : u64 {
        assert!(arg1 > 0, 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::errors::maker_bad_size());
        arg0 - arg0 % arg1
    }

    fun min_nonzero(arg0: u64, arg1: u64) : u64 {
        if (arg0 == 0) {
            arg1
        } else if (arg1 == 0) {
            arg0
        } else if (arg0 < arg1) {
            arg0
        } else {
            arg1
        }
    }

    public fun new_binding<T0, T1>(arg0: &0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::Vault<T1>, arg1: &0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::VaultAdminCap<T1>, arg2: &0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::config::LotusConfig, arg3: u64, arg4: &0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::MakerKernel<T0, T1>, arg5: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg6: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg7: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::DepositCap, arg8: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::WithdrawCap, arg9: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap, arg10: &mut 0x2::tx_context::TxContext) : DeepBookBinding<T0, T1> {
        0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::config::assert_governance_active(arg2, arg3);
        0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::assert_admin<T1>(arg0, arg1);
        0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::assert_kernel<T0, T1>(arg4, arg0, arg2);
        assert!(0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::kernel_venue<T0, T1>(arg4) == 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::venue::venue_deepbook(), 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::errors::maker_binding_mismatch());
        DeepBookBinding<T0, T1>{
            id                 : 0x2::object::new(arg10),
            config_id          : 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::config::id(arg2),
            vault_id           : 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::id<T1>(arg0),
            kernel_id          : 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::kernel_id<T0, T1>(arg4),
            balance_manager_id : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(arg5),
            pool_id            : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg6),
            deposit_cap        : arg7,
            withdraw_cap       : arg8,
            trade_cap          : arg9,
        }
    }

    fun note_fill<T0, T1>(arg0: &mut 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::MakerKernel<T0, T1>, arg1: &mut 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::venue::VenueControls<T0, T1>, arg2: u8, arg3: &0x2::vec_set::VecSet<u128>, arg4: u8, arg5: u32) : u32 {
        let v0 = 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::leg<T0, T1>(arg0, arg4);
        if (!0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::leg_is_resting(&v0)) {
            return arg5
        };
        let v1 = 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::leg_order_id(&v0);
        if (0x2::vec_set::contains<u128>(arg3, &v1)) {
            return arg5
        };
        0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::venue::close_position<T0, T1>(arg1, arg2, 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::record_cleared<T0, T1>(arg0, arg4));
        let v2 = if (arg4 == 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::side_bid()) {
            0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::r_bid_filled()
        } else {
            0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::r_ask_filled()
        };
        arg5 | v2
    }

    public fun order_ioc() : u8 {
        1
    }

    public fun order_post_only() : u8 {
        3
    }

    fun reconcile_side<T0, T1>(arg0: &mut 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::Vault<T1>, arg1: &mut 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::MakerKernel<T0, T1>, arg2: &mut 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::venue::VenueControls<T0, T1>, arg3: &mut 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::strategy::StrategyBook<T1>, arg4: &0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::config::LotusConfig, arg5: 0x2::object::ID, arg6: u8, arg7: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg8: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg9: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof, arg10: u8, arg11: u64, arg12: u64, arg13: u64, arg14: bool, arg15: bool, arg16: bool, arg17: u64, arg18: u64, arg19: u64, arg20: u64, arg21: u64, arg22: u32, arg23: &0x2::clock::Clock, arg24: &mut 0x2::tx_context::TxContext) : u32 {
        let v0 = arg10 == 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::side_bid();
        let v1 = 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::leg<T0, T1>(arg1, arg10);
        let v2 = if (!arg15) {
            true
        } else if (arg16) {
            true
        } else {
            arg11 == 0
        };
        if (v2) {
            let v3 = if (arg11 > 0 && arg12 > 0) {
                let (v4, v5, v6) = 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::plan<T0, T1>(arg1, arg10, arg11, arg12, arg13, arg14, 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::leg_is_latched(&v1));
                let _ = v5;
                let _ = v4;
                v6
            } else {
                let _ = 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::mode_none();
                let _ = 0;
                0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::leg_is_latched(&v1)
            };
            0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::set_latched<T0, T1>(arg1, arg10, v3);
            if (v3) {
                let v9 = if (v0) {
                    0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::r_bid_latched()
                } else {
                    0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::r_ask_latched()
                };
                arg22 = arg22 | v9;
            };
            if (arg16) {
                let v10 = if (v0) {
                    0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::r_bid_suppressed()
                } else {
                    0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::r_ask_suppressed()
                };
                arg22 = arg22 | v10;
            };
            let v11 = if (arg15) {
                if (!arg16) {
                    arg11 == 0
                } else {
                    false
                }
            } else {
                false
            };
            if (v11) {
                let v12 = if (v0) {
                    0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::r_bid_retry()
                } else {
                    0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::r_ask_retry()
                };
                arg22 = arg22 | v12;
            };
            return cancel_side<T0, T1>(arg0, arg1, arg2, arg6, arg7, arg8, arg9, arg10, arg22, arg23, arg24)
        };
        let (v13, v14, v15) = 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::plan<T0, T1>(arg1, arg10, arg11, arg12, arg13, arg14, 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::leg_is_latched(&v1));
        0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::set_latched<T0, T1>(arg1, arg10, v15);
        if (v15) {
            let v16 = if (v0) {
                0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::r_bid_latched()
            } else {
                0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::r_ask_latched()
            };
            arg22 = arg22 | v16;
        };
        if (v13 == 0) {
            let v17 = if (v0) {
                0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::r_bid_retry()
            } else {
                0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::r_ask_retry()
            };
            return cancel_side<T0, T1>(arg0, arg1, arg2, arg6, arg7, arg8, arg9, arg10, arg22 | v17, arg23, arg24)
        };
        let v18 = grid_floor(0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::math::mul_div(0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::math::mul_div(0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::leg_quote_size<T0, T1>(arg1), arg17, 100), 1000000000, v13), arg18);
        if (v18 < arg19) {
            let v19 = if (v0) {
                0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::r_bid_dust()
            } else {
                0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::r_ask_dust()
            };
            return cancel_side<T0, T1>(arg0, arg1, arg2, arg6, arg7, arg8, arg9, arg10, arg22 | v19, arg23, arg24)
        };
        if (0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::leg_satisfies_target<T0, T1>(arg1, arg10, v13, v18, v14, arg21)) {
            let v20 = if (v0) {
                0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::r_bid_kept()
            } else {
                0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::r_ask_kept()
            };
            let v21 = arg22 | v20;
            arg22 = v21;
            if (v13 == arg11) {
                let v22 = if (v0) {
                    0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::r_bid_at_best()
                } else {
                    0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::r_ask_at_best()
                };
                arg22 = v21 | v22;
            };
            return arg22
        };
        let v23 = cancel_side<T0, T1>(arg0, arg1, arg2, arg6, arg7, arg8, arg9, arg10, arg22, arg23, arg24);
        let v24 = 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::math::mul_div(v18, v13, 1000000000);
        if (0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::commitment_headroom<T0, T1>(arg1) < v24) {
            let v25 = if (v0) {
                0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::r_bid_unfunded()
            } else {
                0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::r_ask_unfunded()
            };
            return v23 | v25
        };
        0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::strategy::charge_notional<T1>(arg3, arg5, arg6, v24, arg21);
        let (_, _) = 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::venue::open_position<T0, T1>(arg2, arg4, arg6, v24);
        let v28 = 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::client_order_id(arg20, arg10);
        let v29 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg8, arg7, arg9, v28, 3, 1, v13, v18, v0, false, arg21 + 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::max_age<T0, T1>(arg1), arg23, arg24);
        assert!(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::order_inserted(&v29) && 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::executed_quantity(&v29) == 0, 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::errors::maker_post_only_crossed());
        0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::record_placed<T0, T1>(arg1, arg10, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::order_id(&v29), v28, v13, v18, v14, v24, arg21);
        let v30 = if (v0) {
            0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::r_bid_placed()
        } else {
            0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::r_ask_placed()
        };
        let v31 = v23 | v30;
        arg22 = v31;
        if (v13 == arg11) {
            let v32 = if (v0) {
                0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::r_bid_at_best()
            } else {
                0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::r_ask_at_best()
            };
            arg22 = v31 | v32;
        };
        arg22
    }

    public fun run_cycle<T0, T1>(arg0: &mut 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::Vault<T1>, arg1: &mut 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::MakerKernel<T0, T1>, arg2: &DeepBookBinding<T0, T1>, arg3: &0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::venue::VenueControls<T0, T1>, arg4: &mut 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::strategy::StrategyBook<T1>, arg5: &0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::VaultTradeCap<T1>, arg6: &0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::config::LotusConfig, arg7: u64, arg8: 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::price::PriceReceipt, arg9: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg10: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg11: u64, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : u32 {
        abort 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::errors::deprecated_entry()
    }

    public fun run_cycle2<T0, T1>(arg0: &mut 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::Vault<T1>, arg1: &mut 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::MakerKernel<T0, T1>, arg2: &DeepBookBinding<T0, T1>, arg3: &mut 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::venue::VenueControls<T0, T1>, arg4: &mut 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::strategy::StrategyBook<T1>, arg5: &0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::VaultTradeCap<T1>, arg6: &0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::config::LotusConfig, arg7: u64, arg8: 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::price::PriceReceipt, arg9: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg10: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg11: u64, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : u32 {
        0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::config::assert_product_active(arg6, arg7, 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::config::product_trade());
        0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::assert_active_vault<T1>(arg0, arg6, arg7);
        0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::assert_kernel<T0, T1>(arg1, arg0, arg6);
        0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::venue::assert_controls<T0, T1>(arg3, arg0, arg6);
        0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::strategy::assert_strategy_book<T1>(arg4, arg0);
        assert_binding<T0, T1>(arg2, arg0, arg1, arg9, arg10);
        let v0 = 0x2::clock::timestamp_ms(arg12);
        0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::strategy::assert_provider_active<T1>(arg4, arg0, arg5, v0);
        let v1 = 0x2::object::id<0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::VaultTradeCap<T1>>(arg5);
        let (v2, _, v4, v5, _, _) = 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::price::consume(arg8);
        assert!(v2 == 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::id<T1>(arg0), 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::errors::price_receipt_mismatch());
        assert!(v4 == v1, 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::errors::price_receipt_mismatch());
        0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::consume_sequence<T0, T1>(arg1, v5);
        let (v8, v9, v10, v11, v12, v13, v14, v15) = 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::unpack_inputs2(v5, arg11);
        let v16 = 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::kernel_venue<T0, T1>(arg1);
        let (v17, v18, v19) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<T0, T1>(arg10);
        let v20 = 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::tick_size<T0, T1>(arg1);
        assert!(v17 > 0 && v20 % v17 == 0, 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::errors::maker_tick_mismatch());
        let v21 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_trader(arg9, &arg2.trade_cap, arg13);
        let v22 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::account_open_orders<T0, T1>(arg10, arg9);
        let v23 = sweep_untracked<T0, T1>(arg1, arg9, arg10, &v21, &v22, 0, arg12, arg13);
        let v24 = note_fill<T0, T1>(arg1, arg3, v16, &v22, 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::side_bid(), v23);
        let v25 = note_fill<T0, T1>(arg1, arg3, v16, &v22, 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::side_ask(), v24);
        let (v26, v27, v28) = external_bbo<T0, T1>(arg10, arg9, v20, arg12);
        let v29 = if (!0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::is_paused<T0, T1>(arg1)) {
            if (!0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::venue::is_frozen<T0, T1>(arg3)) {
                if (0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::venue::venue_enabled<T0, T1>(arg3, v16)) {
                    v28
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        let v30 = 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::leg<T0, T1>(arg1, 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::side_ask());
        let v31 = if (0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::leg_is_resting(&v30)) {
            min_nonzero(v27, 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::leg_price(&v30))
        } else {
            v27
        };
        let v32 = reconcile_side<T0, T1>(arg0, arg1, arg3, arg4, arg6, v1, v16, arg9, arg10, &v21, 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::side_bid(), v26, v31, v8, v10, v29, v12, v14, v18, v19, v5, v0, v25, arg12, arg13);
        let v33 = 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::leg<T0, T1>(arg1, 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::side_bid());
        let v34 = if (0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::leg_is_resting(&v33)) {
            let v35 = 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::leg_price(&v33);
            if (v35 > v26) {
                v35
            } else {
                v26
            }
        } else {
            v26
        };
        let v36 = reconcile_side<T0, T1>(arg0, arg1, arg3, arg4, arg6, v1, v16, arg9, arg10, &v21, 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::side_ask(), v27, v34, v9, v11, v29, v13, v15, v18, v19, v5, v0, v32, arg12, arg13);
        0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::emit_cycle<T0, T1>(arg1, v36);
        v36
    }

    public fun share_binding<T0, T1>(arg0: DeepBookBinding<T0, T1>) {
        0x2::transfer::share_object<DeepBookBinding<T0, T1>>(arg0);
    }

    fun sweep_untracked<T0, T1>(arg0: &0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::MakerKernel<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof, arg4: &0x2::vec_set::VecSet<u128>, arg5: u32, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) : u32 {
        let v0 = 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::leg<T0, T1>(arg0, 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::side_bid());
        let v1 = 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::leg<T0, T1>(arg0, 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::side_ask());
        let v2 = 0x2::vec_set::keys<u128>(arg4);
        let v3 = 0;
        while (v3 < 0x1::vector::length<u128>(v2)) {
            let v4 = *0x1::vector::borrow<u128>(v2, v3);
            if (v4 != 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::leg_order_id(&v0) && v4 != 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::leg_order_id(&v1)) {
                0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_order<T0, T1>(arg2, arg1, arg3, v4, arg6, arg7);
                arg5 = arg5 | 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::r_untracked_cancelled();
            };
            v3 = v3 + 1;
        };
        arg5
    }

    public fun take_ioc<T0, T1>(arg0: &mut 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::Vault<T1>, arg1: &0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::MakerKernel<T0, T1>, arg2: &DeepBookBinding<T0, T1>, arg3: &mut 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::strategy::StrategyBook<T1>, arg4: &0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::VaultTradeCap<T1>, arg5: &0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::config::LotusConfig, arg6: u64, arg7: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg8: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg9: u64, arg10: u64, arg11: u64, arg12: bool, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        abort 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::errors::deprecated_entry()
    }

    public fun take_ioc2<T0, T1>(arg0: &mut 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::Vault<T1>, arg1: &0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::MakerKernel<T0, T1>, arg2: &DeepBookBinding<T0, T1>, arg3: &mut 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::venue::VenueControls<T0, T1>, arg4: &mut 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::strategy::StrategyBook<T1>, arg5: &0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::VaultTradeCap<T1>, arg6: &0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::config::LotusConfig, arg7: u64, arg8: &0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::price::PriceReceipt, arg9: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg10: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg11: u64, arg12: u64, arg13: u64, arg14: bool, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) {
        0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::config::assert_product_active(arg6, arg7, 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::config::product_trade());
        0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::assert_active_vault<T1>(arg0, arg6, arg7);
        0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::venue::assert_controls<T0, T1>(arg3, arg0, arg6);
        0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::strategy::assert_strategy_book<T1>(arg4, arg0);
        assert_binding<T0, T1>(arg2, arg0, arg1, arg9, arg10);
        let v0 = 0x2::clock::timestamp_ms(arg15);
        0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::strategy::assert_provider_active<T1>(arg4, arg0, arg5, v0);
        assert!(0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::price::receipt_vault_id(arg8) == 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::id<T1>(arg0), 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::errors::price_receipt_mismatch());
        assert!(0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::price::receipt_cap_id(arg8) == 0x2::object::id<0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::VaultTradeCap<T1>>(arg5), 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::errors::price_receipt_mismatch());
        assert!(0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::price::receipt_scale(arg8) == 1000000000, 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::errors::maker_scale_mismatch());
        let v1 = 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::kernel_venue<T0, T1>(arg1);
        let (v2, v3, v4) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<T0, T1>(arg10);
        let v5 = if (arg14) {
            0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::side_bid()
        } else {
            0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::side_ask()
        };
        let v6 = 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::align_price(arg12, v2, v5);
        let v7 = grid_floor(arg13, v3);
        assert!(v7 >= v4, 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::errors::maker_bad_size());
        let v8 = 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::math::mul_div(v7, v6, 1000000000);
        let (_, v10) = 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::venue::open_position<T0, T1>(arg3, arg6, v1, v8);
        let v11 = 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::price::receipt_price(arg8);
        if (arg14) {
            assert!(v6 <= 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::math::add(v11, 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::math::bps(v11, 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::math::min(0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::strategy::charge_notional<T1>(arg4, 0x2::object::id<0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::VaultTradeCap<T1>>(arg5), v1, v8, v0), v10))), 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::errors::maker_price_band());
        } else {
            assert!(0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::math::add(v6, 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::math::bps(v11, 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::math::min(0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::strategy::charge_notional<T1>(arg4, 0x2::object::id<0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::VaultTradeCap<T1>>(arg5), v1, v8, v0), v10))) >= v11, 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::errors::maker_price_band());
        };
        let v12 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_trader(arg9, &arg2.trade_cap, arg16);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg10, arg9, &v12, arg11, 1, 1, v6, v7, arg14, false, v0 + 1000, arg15, arg16);
        0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::venue::close_position<T0, T1>(arg3, v1, v8);
    }

    // decompiled from Move bytecode v7
}

