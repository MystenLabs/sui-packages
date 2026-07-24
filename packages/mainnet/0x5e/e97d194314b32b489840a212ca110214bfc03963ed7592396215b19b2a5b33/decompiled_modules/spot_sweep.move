module 0xe3cb28dd9612ad102c71ba32fce2e347410e3c995f184ced83f4038cba24b6c7::spot_sweep {
    struct SweepExecuted<phantom T0, phantom T1> has copy, drop {
        balance_manager_id: 0x2::object::ID,
        venue: u8,
        is_buy_base: bool,
        input_amount: u64,
        quoted_output: u64,
        actual_output: u64,
        fee_amount_input: u64,
        fee_bps_e4: u64,
        reference_price_raw: u64,
        execution_price_raw: u64,
        reference_slippage_bps_e4: u64,
        quote_shortfall_bps_e4: u64,
    }

    public fun bluefin_buy_base<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: u64, arg4: u64, arg5: u64, arg6: u128, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        validate_amount(arg3, arg4, arg5, 2000000);
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::calculate_swap_results<T0, T1>(arg2, false, true, arg3, arg6);
        assert!(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_specified_remaining(&v0) == 0 && !0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_is_exceed(&v0), 3);
        let (v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T0, T1>(arg7, arg1, arg2, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<T1>(arg0, arg3, arg8)), false, true, arg3, arg4, arg6);
        let v3 = v2;
        let v4 = v1;
        assert!(0x2::balance::value<T1>(&v3) == 0, 1);
        assert!(0x2::balance::value<T0>(&v4) >= arg4, 2);
        emit_sweep<T0, T1>(arg0, 3, true, arg3, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_calculated(&v0), 0x2::balance::value<T0>(&v4), total_input_fee(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_fee_amount(&v0), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_protocol_fee(&v0), arg3), arg5);
        deposit_balance<T0>(arg0, v4, arg8);
        deposit_balance<T1>(arg0, v3, arg8);
    }

    public fun bluefin_sell_base<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: u64, arg4: u64, arg5: u64, arg6: u128, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        validate_amount(arg3, arg4, arg5, 2000000000);
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::calculate_swap_results<T0, T1>(arg2, true, true, arg3, arg6);
        assert!(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_specified_remaining(&v0) == 0 && !0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_is_exceed(&v0), 3);
        let (v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T0, T1>(arg7, arg1, arg2, 0x2::coin::into_balance<T0>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<T0>(arg0, arg3, arg8)), 0x2::balance::zero<T1>(), true, true, arg3, arg4, arg6);
        let v3 = v2;
        let v4 = v1;
        assert!(0x2::balance::value<T0>(&v4) == 0, 1);
        assert!(0x2::balance::value<T1>(&v3) >= arg4, 2);
        emit_sweep<T0, T1>(arg0, 3, false, arg3, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_calculated(&v0), 0x2::balance::value<T1>(&v3), total_input_fee(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_fee_amount(&v0), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_protocol_fee(&v0), arg3), arg5);
        deposit_balance<T0>(arg0, v4, arg8);
        deposit_balance<T1>(arg0, v3, arg8);
    }

    public fun cetus_buy_base<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: u64, arg4: u64, arg5: u64, arg6: u128, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        validate_amount(arg3, arg4, arg5, 2000000);
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T1, T0>(arg2, true, true, arg3);
        assert!(!0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_is_exceed(&v0) && 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_in(&v0) == arg3, 3);
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T0>(arg1, arg2, true, true, arg3, arg6, arg7);
        let v4 = v3;
        let v5 = v2;
        let v6 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T0>(&v4);
        assert!(v6 == arg3, 1);
        assert!(0x2::balance::value<T0>(&v5) >= arg4, 2);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T0>(arg1, arg2, 0x2::coin::into_balance<T1>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<T1>(arg0, v6, arg8)), 0x2::balance::zero<T0>(), v4);
        emit_sweep<T0, T1>(arg0, 2, true, arg3, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v0), 0x2::balance::value<T0>(&v5), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_fee_amount(&v0), arg5);
        deposit_balance<T1>(arg0, v1, arg8);
        deposit_balance<T0>(arg0, v5, arg8);
    }

    public fun cetus_sell_base<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: u64, arg4: u64, arg5: u64, arg6: u128, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        validate_amount(arg3, arg4, arg5, 2000000000);
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T1, T0>(arg2, false, true, arg3);
        assert!(!0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_is_exceed(&v0) && 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_in(&v0) == arg3, 3);
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T0>(arg1, arg2, false, true, arg3, arg6, arg7);
        let v4 = v3;
        let v5 = v1;
        let v6 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T0>(&v4);
        assert!(v6 == arg3, 1);
        assert!(0x2::balance::value<T1>(&v5) >= arg4, 2);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T0>(arg1, arg2, 0x2::balance::zero<T1>(), 0x2::coin::into_balance<T0>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<T0>(arg0, v6, arg8)), v4);
        emit_sweep<T0, T1>(arg0, 2, false, arg3, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v0), 0x2::balance::value<T1>(&v5), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_fee_amount(&v0), arg5);
        deposit_balance<T1>(arg0, v5, arg8);
        deposit_balance<T0>(arg0, v2, arg8);
    }

    fun deposit_balance<T0>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg1: 0x2::balance::Balance<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg1) == 0) {
            0x2::balance::destroy_zero<T0>(arg1);
        } else {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<T0>(arg0, 0x2::coin::from_balance<T0>(arg1, arg2), arg2);
        };
    }

    fun emit_sweep<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg1: u8, arg2: bool, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64) {
        let (v0, v1, v2, v3) = execution_metrics(arg2, arg3, arg4, arg5, arg6, arg7);
        let v4 = SweepExecuted<T0, T1>{
            balance_manager_id        : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::id(arg0),
            venue                     : arg1,
            is_buy_base               : arg2,
            input_amount              : arg3,
            quoted_output             : arg4,
            actual_output             : arg5,
            fee_amount_input          : arg6,
            fee_bps_e4                : v3,
            reference_price_raw       : arg7,
            execution_price_raw       : v0,
            reference_slippage_bps_e4 : v1,
            quote_shortfall_bps_e4    : v2,
        };
        0x2::event::emit<SweepExecuted<T0, T1>>(v4);
    }

    public(friend) fun execution_metrics(arg0: bool, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : (u64, u64, u64, u64) {
        let v0 = if (arg1 > 0) {
            if (arg2 > 0) {
                if (arg3 > 0) {
                    if (arg4 <= arg1) {
                        arg5 > 0
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 0);
        let v1 = if (arg0) {
            ratio_scaled(arg1, arg3, 1000000000, true)
        } else {
            ratio_scaled(arg3, arg1, 1000000000, false)
        };
        let v2 = if (arg0) {
            if (v1 > arg5) {
                v1 - arg5
            } else {
                0
            }
        } else if (v1 < arg5) {
            arg5 - v1
        } else {
            0
        };
        let v3 = if (arg2 > arg3) {
            arg2 - arg3
        } else {
            0
        };
        (v1, ratio_scaled(v2, arg5, 100000000, true), ratio_scaled(v3, arg2, 100000000, true), ratio_scaled(arg4, arg1, 100000000, true))
    }

    public fun momentum_buy_base<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: u64, arg4: u64, arg5: u64, arg6: u128, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        validate_amount(arg3, arg4, arg5, 2000000);
        let v0 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::compute_swap_result<T0, T1>(arg1, false, true, arg6, arg3);
        assert!(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::get_state_amount_specified(&v0) == 0, 3);
        let (v1, v2, v3) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg1, false, true, arg3, arg6, arg7, arg2, arg8);
        let v4 = v3;
        let v5 = v1;
        let (v6, v7) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v4);
        assert!(v6 == 0 && v7 == arg3, 1);
        assert!(0x2::balance::value<T0>(&v5) >= arg4, 2);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg1, v4, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<T1>(arg0, v7, arg8)), arg2, arg8);
        emit_sweep<T0, T1>(arg0, 1, true, arg3, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::get_state_amount_calculated(&v0), 0x2::balance::value<T0>(&v5), total_input_fee(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::get_state_fee_amount(&v0), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::get_state_protocol_fee(&v0), arg3), arg5);
        deposit_balance<T0>(arg0, v5, arg8);
        deposit_balance<T1>(arg0, v2, arg8);
    }

    public fun momentum_sell_base<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: u64, arg4: u64, arg5: u64, arg6: u128, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        validate_amount(arg3, arg4, arg5, 2000000000);
        let v0 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::compute_swap_result<T0, T1>(arg1, true, true, arg6, arg3);
        assert!(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::get_state_amount_specified(&v0) == 0, 3);
        let (v1, v2, v3) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg1, true, true, arg3, arg6, arg7, arg2, arg8);
        let v4 = v3;
        let v5 = v2;
        let (v6, v7) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v4);
        assert!(v6 == arg3 && v7 == 0, 1);
        assert!(0x2::balance::value<T1>(&v5) >= arg4, 2);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg1, v4, 0x2::coin::into_balance<T0>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<T0>(arg0, v6, arg8)), 0x2::balance::zero<T1>(), arg2, arg8);
        emit_sweep<T0, T1>(arg0, 1, false, arg3, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::get_state_amount_calculated(&v0), 0x2::balance::value<T1>(&v5), total_input_fee(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::get_state_fee_amount(&v0), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::get_state_protocol_fee(&v0), arg3), arg5);
        deposit_balance<T0>(arg0, v1, arg8);
        deposit_balance<T1>(arg0, v5, arg8);
    }

    fun ratio_scaled(arg0: u64, arg1: u64, arg2: u128, arg3: bool) : u64 {
        assert!(arg1 > 0, 0);
        let v0 = (arg0 as u128) * arg2;
        let v1 = if (arg3 && v0 > 0) {
            (v0 + (arg1 as u128) - 1) / (arg1 as u128)
        } else {
            v0 / (arg1 as u128)
        };
        assert!(v1 <= 18446744073709551615, 0);
        (v1 as u64)
    }

    public(friend) fun total_input_fee(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg0 <= arg2 && arg1 <= arg2 - arg0, 0);
        arg0 + arg1
    }

    public(friend) fun validate_amount(arg0: u64, arg1: u64, arg2: u64, arg3: u64) {
        let v0 = if (arg0 > 0) {
            if (arg0 <= arg3) {
                if (arg1 > 0) {
                    if (arg2 > 0) {
                        arg2 <= 10000000
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 0);
    }

    // decompiled from Move bytecode v7
}

