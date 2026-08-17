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

    fun cancel_side<T0, T1>(arg0: &mut 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::Vault<T1>, arg1: &mut 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::MakerKernel<T0, T1>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg4: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof, arg5: u8, arg6: u32, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : u32 {
        let v0 = 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::leg<T0, T1>(arg1, arg5);
        if (!0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::leg_is_resting(&v0)) {
            return arg6
        };
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_order<T0, T1>(arg3, arg2, arg4, 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::leg_order_id(&v0), arg7, arg8);
        0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::record_cleared<T0, T1>(arg1, arg5);
        let v1 = if (arg5 == 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::side_bid()) {
            0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::r_bid_cancelled()
        } else {
            0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::r_ask_cancelled()
        };
        arg6 | v1
    }

    public fun defund<T0, T1>(arg0: &mut 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::Vault<T1>, arg1: &DeepBookBinding<T0, T1>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::VaultAdminCap<T1>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::assert_admin<T1>(arg0, arg3);
        assert!(arg1.vault_id == 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::id<T1>(arg0), 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::errors::maker_binding_mismatch());
        assert!(arg1.balance_manager_id == 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(arg2), 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::errors::maker_binding_mismatch());
        0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::strategy_put_quote<T1>(arg0, 0x2::coin::into_balance<T1>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw_with_cap<T1>(arg2, &arg1.withdraw_cap, arg4, arg5)));
        0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::strategy_settle_principal<T1>(arg0, arg4, arg4);
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
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::mid_price<T0, T1>(arg0, arg4);
        if (v0 == 0) {
            return 0
        };
        let v1 = 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::math::mul(arg3, 64);
        let (v2, v3) = if (arg2) {
            let v4 = if (v0 > v1) {
                v0 - v1
            } else {
                1
            };
            (v4, v0)
        } else {
            (v0, 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::math::add(v0, v1))
        };
        let (v5, v6) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_level2_range<T0, T1>(arg0, v2, v3, arg2, arg4);
        let v7 = v6;
        let v8 = v5;
        let v9 = 0;
        while (v9 < 0x1::vector::length<u64>(&v8)) {
            let v10 = *0x1::vector::borrow<u64>(&v8, v9);
            if (*0x1::vector::borrow<u64>(&v7, v9) > own_quantity_at<T0, T1>(arg0, arg1, v10, arg2)) {
                return v10
            };
            v9 = v9 + 1;
        };
        0
    }

    public fun flatten<T0, T1>(arg0: &mut 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::Vault<T1>, arg1: &mut 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::MakerKernel<T0, T1>, arg2: &DeepBookBinding<T0, T1>, arg3: &0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::VaultAdminCap<T1>, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg5: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::assert_admin<T1>(arg0, arg3);
        assert_binding<T0, T1>(arg2, arg0, arg1, arg4, arg5);
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_trader(arg4, &arg2.trade_cap, arg7);
        let v1 = cancel_side<T0, T1>(arg0, arg1, arg4, arg5, &v0, 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::side_bid(), 0, arg6, arg7);
        let v2 = cancel_side<T0, T1>(arg0, arg1, arg4, arg5, &v0, 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::side_ask(), v1, arg6, arg7);
        0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::emit_cycle<T0, T1>(arg1, v2);
    }

    public fun fund<T0, T1>(arg0: &mut 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::Vault<T1>, arg1: &DeepBookBinding<T0, T1>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::VaultAdminCap<T1>, arg4: &0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::config::LotusConfig, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::config::assert_product_active(arg4, arg5, 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::config::product_trade());
        0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::assert_admin<T1>(arg0, arg3);
        assert!(arg1.vault_id == 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::id<T1>(arg0), 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::errors::maker_binding_mismatch());
        assert!(arg1.balance_manager_id == 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(arg2), 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::errors::maker_binding_mismatch());
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit_with_cap<T1>(arg2, &arg1.deposit_cap, 0x2::coin::from_balance<T1>(0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::strategy_take_quote<T1>(arg0, arg6), arg7), arg7);
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

    public fun order_ioc() : u8 {
        1
    }

    public fun order_post_only() : u8 {
        3
    }

    fun own_quantity_at<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: u64, arg3: bool) : u64 {
        let v0 = 0x2::vec_set::into_keys<u128>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::account_open_orders<T0, T1>(arg0, arg1));
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<u128>(&v0)) {
            let v3 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_order<T0, T1>(arg0, *0x1::vector::borrow<u128>(&v0, v2));
            if (*0x1::vector::borrow<u128>(&v0, v2) >> 127 == 0 == arg3 && 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::price(&v3) == arg2) {
                v1 = 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::math::add(v1, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::quantity(&v3));
            };
            v2 = v2 + 1;
        };
        v1
    }

    fun reconcile_side<T0, T1>(arg0: &mut 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::Vault<T1>, arg1: &mut 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::MakerKernel<T0, T1>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg4: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof, arg5: u8, arg6: u64, arg7: u64, arg8: u64, arg9: bool, arg10: bool, arg11: u64, arg12: u64, arg13: u32, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) : u32 {
        let v0 = arg5 == 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::side_bid();
        let v1 = 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::leg<T0, T1>(arg1, arg5);
        if (!arg10 || arg6 == 0) {
            let v2 = if (arg6 > 0) {
                let (v3, v4, v5) = 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::plan<T0, T1>(arg1, arg5, arg6, arg6, arg8, arg9, 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::leg_is_latched(&v1));
                let _ = v4;
                let _ = v3;
                v5
            } else {
                let _ = 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::mode_none();
                let _ = 0;
                0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::leg_is_latched(&v1)
            };
            0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::set_latched<T0, T1>(arg1, arg5, v2);
            if (v2) {
                let v8 = if (v0) {
                    0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::r_bid_latched()
                } else {
                    0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::r_ask_latched()
                };
                arg13 = arg13 | v8;
            };
            if (arg6 == 0) {
                let v9 = if (v0) {
                    0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::r_bid_retry()
                } else {
                    0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::r_ask_retry()
                };
                arg13 = arg13 | v9;
            };
            return cancel_side<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg13, arg14, arg15)
        };
        let (v10, v11, v12) = 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::plan<T0, T1>(arg1, arg5, arg6, arg7, arg8, arg9, 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::leg_is_latched(&v1));
        0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::set_latched<T0, T1>(arg1, arg5, v12);
        if (v12) {
            let v13 = if (v0) {
                0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::r_bid_latched()
            } else {
                0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::r_ask_latched()
            };
            arg13 = arg13 | v13;
        };
        let v14 = 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::math::mul_div(0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::leg_quote_size<T0, T1>(arg1), 1000000000, v10);
        if (v14 == 0) {
            return cancel_side<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg13, arg14, arg15)
        };
        if (0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::leg_satisfies_target<T0, T1>(arg1, arg5, v10, v14, v11, arg12)) {
            let v15 = if (v0) {
                0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::r_bid_kept()
            } else {
                0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::r_ask_kept()
            };
            let v16 = arg13 | v15;
            arg13 = v16;
            if (v10 == arg6) {
                let v17 = if (v0) {
                    0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::r_bid_at_best()
                } else {
                    0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::r_ask_at_best()
                };
                arg13 = v16 | v17;
            };
            return arg13
        };
        let v18 = cancel_side<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg13, arg14, arg15);
        let v19 = 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::leg_quote_size<T0, T1>(arg1);
        if (0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::commitment_headroom<T0, T1>(arg1) < v19) {
            let v20 = if (v0) {
                0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::r_bid_unfunded()
            } else {
                0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::r_ask_unfunded()
            };
            return v18 | v20
        };
        let v21 = 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::client_order_id(arg11, arg5);
        let v22 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg3, arg2, arg4, v21, 3, 1, v10, v14, v0, false, arg12 + 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::max_age<T0, T1>(arg1), arg14, arg15);
        0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::record_placed<T0, T1>(arg1, arg5, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::order_id(&v22), v21, v10, v14, v11, v19, arg12);
        let v23 = if (v0) {
            0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::r_bid_placed()
        } else {
            0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::r_ask_placed()
        };
        let v24 = v18 | v23;
        arg13 = v24;
        if (v10 == arg6) {
            let v25 = if (v0) {
                0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::r_bid_at_best()
            } else {
                0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::r_ask_at_best()
            };
            arg13 = v24 | v25;
        };
        arg13
    }

    public fun run_cycle<T0, T1>(arg0: &mut 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::Vault<T1>, arg1: &mut 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::MakerKernel<T0, T1>, arg2: &DeepBookBinding<T0, T1>, arg3: &0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::venue::VenueControls<T0, T1>, arg4: &mut 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::strategy::StrategyBook<T1>, arg5: &0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::VaultTradeCap<T1>, arg6: &0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::config::LotusConfig, arg7: u64, arg8: 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::price::PriceReceipt, arg9: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg10: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg11: u64, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : u32 {
        0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::config::assert_product_active(arg6, arg7, 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::config::product_trade());
        0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::assert_active_vault<T1>(arg0, arg6, arg7);
        0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::assert_kernel<T0, T1>(arg1, arg0, arg6);
        0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::venue::assert_controls<T0, T1>(arg3, arg0, arg6);
        0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::strategy::assert_strategy_book<T1>(arg4, arg0);
        assert_binding<T0, T1>(arg2, arg0, arg1, arg9, arg10);
        let v0 = 0x2::clock::timestamp_ms(arg12);
        0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::strategy::assert_provider_active<T1>(arg4, arg0, arg5, v0);
        let (v1, _, v3, v4, _, _) = 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::price::consume(arg8);
        assert!(v1 == 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::id<T1>(arg0), 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::errors::price_receipt_mismatch());
        assert!(v3 == 0x2::object::id<0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::VaultTradeCap<T1>>(arg5), 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::errors::price_receipt_mismatch());
        0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::consume_sequence<T0, T1>(arg1, v4);
        let (v7, v8, v9, v10) = 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::unpack_inputs(v4, arg11);
        let (v11, v12, v13) = external_bbo<T0, T1>(arg10, arg9, 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::tick_size<T0, T1>(arg1), arg12);
        let v14 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_trader(arg9, &arg2.trade_cap, arg13);
        let v15 = if (!0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::is_paused<T0, T1>(arg1)) {
            if (!0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::venue::is_frozen<T0, T1>(arg3)) {
                v13
            } else {
                false
            }
        } else {
            false
        };
        let v16 = reconcile_side<T0, T1>(arg0, arg1, arg9, arg10, &v14, 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::side_bid(), v11, v12, v7, v9, v15, v4, v0, 0, arg12, arg13);
        let v17 = reconcile_side<T0, T1>(arg0, arg1, arg9, arg10, &v14, 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::side_ask(), v12, v11, v8, v10, v15, v4, v0, v16, arg12, arg13);
        0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::emit_cycle<T0, T1>(arg1, v17);
        v17
    }

    public fun share_binding<T0, T1>(arg0: DeepBookBinding<T0, T1>) {
        0x2::transfer::share_object<DeepBookBinding<T0, T1>>(arg0);
    }

    public fun take_ioc<T0, T1>(arg0: &mut 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::Vault<T1>, arg1: &0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::MakerKernel<T0, T1>, arg2: &DeepBookBinding<T0, T1>, arg3: &mut 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::strategy::StrategyBook<T1>, arg4: &0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::VaultTradeCap<T1>, arg5: &0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::config::LotusConfig, arg6: u64, arg7: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg8: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg9: u64, arg10: u64, arg11: u64, arg12: bool, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::config::assert_product_active(arg5, arg6, 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::config::product_trade());
        0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::assert_active_vault<T1>(arg0, arg5, arg6);
        0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::strategy::assert_strategy_book<T1>(arg3, arg0);
        assert_binding<T0, T1>(arg2, arg0, arg1, arg7, arg8);
        let v0 = 0x2::clock::timestamp_ms(arg13);
        0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::strategy::assert_provider_active<T1>(arg3, arg0, arg4, v0);
        0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::strategy::charge_notional<T1>(arg3, 0x2::object::id<0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::VaultTradeCap<T1>>(arg4), 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker::kernel_venue<T0, T1>(arg1), 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::math::mul_div(arg11, arg10, 1000000000), v0);
        let v1 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_trader(arg7, &arg2.trade_cap, arg14);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg8, arg7, &v1, arg9, 1, 1, arg10, arg11, arg12, false, v0 + 1000, arg13, arg14);
    }

    // decompiled from Move bytecode v7
}

