module 0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::margining_engine {
    struct Check has copy, drop {
        pnl: 0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::signed_number::Number,
        bad_debt_orig: u64,
        bad_debt_final: u64,
        margin_remaining_in_position_final: u64,
        margin_remaining_in_position_orig: u64,
    }

    public fun calculate_effective_leverage(arg0: bool, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : u64 {
        abort 0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::errors::deprecated_function()
    }

    public(friend) fun apply_maths(arg0: &mut 0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::data_store::InternalDataStore, arg1: 0x1::string::String, arg2: address, arg3: u64, arg4: u64, arg5: u64, arg6: bool, arg7: bool, arg8: bool, arg9: u8, arg10: 0x1::option::Option<0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::signed_number::Number>, arg11: 0x1::option::Option<bool>) : (u64, u64, 0x1::string::String, 0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::account::Position, vector<0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::account::DepositedAsset>, u64, u64) {
        let (v0, v1, v2, v3, v4, v5, v6, v7, v8) = apply_maths_internal(0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::data_store::get_immutable_perpetual_table_from_ids(arg0), 0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::data_store::get_immutable_assets_table_from_ids(arg0), 0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::data_store::get_immutable_perpetual_from_ids(arg0, arg1), 0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::data_store::get_immutable_account_from_ids(arg0, arg2), arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, 0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::data_store::get_gas_fee_amount(arg0));
        let v9 = v6;
        let v10 = v3;
        0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::account::update_account(0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::data_store::get_mutable_account_from_ids(arg0, arg2), &v9, &v10, v4, arg7);
        (v0, v1, v2, v5, v9, v7, v8)
    }

    public(friend) fun apply_maths_internal(arg0: &0x2::table::Table<0x1::string::String, 0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::perpetual::Perpetual>, arg1: &0x2::table::Table<0x1::string::String, 0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::bank::Asset>, arg2: &0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::perpetual::Perpetual, arg3: &0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::account::Account, arg4: u64, arg5: u64, arg6: u64, arg7: bool, arg8: bool, arg9: bool, arg10: u8, arg11: 0x1::option::Option<0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::signed_number::Number>, arg12: 0x1::option::Option<bool>, arg13: u64) : (u64, u64, 0x1::string::String, vector<0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::account::Position>, u64, 0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::account::Position, vector<0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::account::DepositedAsset>, u64, u64) {
        let v0 = 0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::perpetual::get_symbol(arg2);
        let v1 = if (arg8) {
            v0
        } else {
            0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::constants::empty_string()
        };
        let v2 = 0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::account::get_positions_vector(arg3, v1);
        let v3 = 0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::account::get_assets_vector(arg3, v1);
        let v4 = 0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::account::get_positions_vector(arg3, 0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::constants::empty_string());
        let v5 = 0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::account::get_assets_vector(arg3, 0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::constants::empty_string());
        let v6 = v3;
        let v7 = if (arg8) {
            &mut v5
        } else {
            &mut v3
        };
        let (v8, v9) = 0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::account::get_mutable_position_for_perpetual(&mut v2, v0, arg8);
        if (0x1::vector::length<0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::account::Position>(&v2) < v9 + 1) {
            0x1::vector::push_back<0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::account::Position>(&mut v2, *v8);
        };
        let (_, v11, v12, v13, v14, v15, _, v17) = 0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::account::get_position_values(v8);
        assert!(!arg8 || arg6 > 0, 0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::errors::invalid_leverage());
        let v18 = if (!arg8) {
            true
        } else if (v11 == 0) {
            true
        } else {
            v14 == arg6
        };
        assert!(v18, 0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::errors::invalid_leverage());
        let (v19, v20, v21, v22) = update_position(v13, v11, v12, arg7, arg5, arg4);
        let (v23, v24, v25) = settle_pnl(arg1, v7, v15, v22, v17, arg9, arg8, arg10);
        let (v26, v27, v28) = settle_liquidatee_pending_funding_payment(arg1, v7, v24, arg5, v11, v23, v25, arg8, arg9, arg10);
        let (v29, v30) = settle_margin(v7, v26, v20, v21, v28, 0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::account::calculate_effective_leverage(v8, 0x1::option::some<u64>(arg6)), arg9, arg8, arg10);
        let (v31, v32, v33) = settle_fee(arg1, arg2, arg3, v7, arg5, arg4, arg9, arg10);
        premium_or_debt_settlement(v7, arg11, arg9, arg10);
        0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::account::set_isolated_position_assets(&mut v3, v29);
        if (!arg8) {
            arg6 = 0;
        };
        0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::account::update_position_values(v8, v20, v21, v29, arg6, v19, v27);
        verify_health(arg0, arg1, &v3, &v2, &v6, &v2, v9, arg10, arg9);
        let v34 = if (arg8) {
            if (arg10 == 0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::constants::action_trade() || arg10 == 0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::constants::action_liquidate()) {
                !0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::utils::is_reducing_trade(v13, v11, arg7, arg5)
            } else {
                false
            }
        } else {
            false
        };
        if (v34) {
            verify_health(arg0, arg1, &v5, &v4, &v5, &v4, v9, 0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::constants::action_isolated_trade(), arg9);
        };
        let v35 = if (arg8) {
            v5
        } else {
            v3
        };
        v3 = v35;
        (v31, v32, v33, v2, v9, *v8, v3, v30, settle_gas_charges(arg13, v7, arg3, arg12, arg9, arg10))
    }

    public fun calculate_liquidation_premium_portions(arg0: bool, arg1: u64, arg2: u64, arg3: u64, arg4: bool, arg5: u64) : (u64, u64) {
        if (arg4) {
            (0, 0)
        } else {
            let v2 = if (arg0) {
                arg2 - arg1
            } else {
                arg1 - arg2
            };
            let v3 = 0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::utils::base_mul(v2, arg3);
            let v4 = 0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::utils::base_mul(v3, arg5);
            (v3 - v4, v4)
        }
    }

    public fun calculate_pnl(arg0: u64, arg1: u64, arg2: u64, arg3: bool) : 0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::signed_number::Number {
        if (arg3) {
            0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::signed_number::mul_uint(0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::signed_number::sub_uint(0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::signed_number::from(arg1, true), arg2), arg0)
        } else {
            0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::signed_number::negate(0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::signed_number::mul_uint(0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::signed_number::sub_uint(0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::signed_number::from(arg1, true), arg2), arg0))
        }
    }

    public(friend) fun compute_trade_fee(arg0: &0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::account::Account, arg1: &0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::perpetual::Perpetual, arg2: u64, arg3: bool) : u64 {
        let (v0, v1) = 0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::perpetual::get_fees(arg1);
        let (v2, v3, v4) = 0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::account::get_fees(arg0);
        let v5 = if (v4) {
            if (arg3) {
                v2
            } else {
                v3
            }
        } else if (arg3) {
            v0
        } else {
            v1
        };
        0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::utils::base_mul(v5, arg2)
    }

    public fun get_withdrawable_assets(arg0: &0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::data_store::InternalDataStore, arg1: address, arg2: vector<u8>) : u64 {
        let v0 = 0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::data_store::get_immutable_perpetual_table_from_ids(arg0);
        let v1 = 0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::data_store::get_immutable_account_from_ids(arg0, arg1);
        let v2 = 0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::account::get_positions_vector(v1, 0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::constants::empty_string());
        let v3 = 0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::account::get_assets_vector(v1, 0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::constants::empty_string());
        let v4 = 0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::signed_number::sub_uint(0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::account::get_account_value(&v3, &v2, v0, 0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::data_store::get_immutable_assets_table_from_ids(arg0)), 0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::account::get_total_margin_required(&v2, v0, 0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::constants::imr_threshold()));
        let v5 = if (0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::signed_number::gt_uint(v4, 0)) {
            0x1::u64::min((0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::signed_number::value(v4) as u64), (0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::account::get_asset_quantity(&v3, arg2) as u64))
        } else {
            0
        };
        (v5 as u64)
    }

    fun premium_or_debt_settlement(arg0: &mut vector<0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::account::DepositedAsset>, arg1: 0x1::option::Option<0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::signed_number::Number>, arg2: bool, arg3: u8) {
        if (arg3 == 0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::constants::action_liquidate() && !arg2) {
            assert!(0x1::option::is_some<0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::signed_number::Number>(&arg1), 0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::errors::missing_optional_param());
            let v0 = 0x1::option::extract<0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::signed_number::Number>(&mut arg1);
            let v1 = 0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::signed_number::value(v0);
            if (v1 > 0) {
                if (0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::signed_number::sign(v0)) {
                    0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::account::add_margin_to_asset_vector(arg0, v1, 0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::constants::empty_string());
                } else {
                    0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::account::sub_margin_from_asset_vector(arg0, v1, 0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::constants::empty_string());
                };
            };
        };
    }

    fun settle_fee(arg0: &0x2::table::Table<0x1::string::String, 0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::bank::Asset>, arg1: &0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::perpetual::Perpetual, arg2: &0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::account::Account, arg3: &mut vector<0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::account::DepositedAsset>, arg4: u64, arg5: u64, arg6: bool, arg7: u8) : (u64, u64, 0x1::string::String) {
        let v0 = 0;
        let v1 = 0;
        let v2 = 0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::account::get_fee_asset(arg2);
        let v3 = v2;
        if (arg7 == 0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::constants::action_trade()) {
            let v4 = compute_trade_fee(arg2, arg1, 0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::utils::base_mul(arg5, arg4), arg6);
            v0 = v4;
            v1 = v4;
            if (v4 > 0 && !0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::utils::is_empty_string(v2)) {
                v1 = 0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::bank::get_asset_with_provided_usd_value(arg0, v2, v4);
            };
            if (v1 > 0) {
                0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::account::sub_margin_from_asset_vector(arg3, v1, v2);
            };
        };
        if (0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::utils::is_empty_string(v2)) {
            v3 = 0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::constants::usdc_token_symbol();
        };
        (v0, v1, v3)
    }

    fun settle_gas_charges(arg0: u64, arg1: &mut vector<0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::account::DepositedAsset>, arg2: &0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::account::Account, arg3: 0x1::option::Option<bool>, arg4: bool, arg5: u8) : u64 {
        let v0 = 0;
        if (arg5 == 0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::constants::action_trade() && !arg4) {
            assert!(0x1::option::is_some<bool>(&arg3), 0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::errors::missing_optional_param());
            if (0x1::option::extract<bool>(&mut arg3) && !0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::account::is_institution(arg2)) {
                v0 = arg0;
                0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::account::sub_margin_from_asset_vector(arg1, arg0, 0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::constants::empty_string());
            };
        };
        v0
    }

    fun settle_liquidatee_pending_funding_payment(arg0: &0x2::table::Table<0x1::string::String, 0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::bank::Asset>, arg1: &mut vector<0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::account::DepositedAsset>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: bool, arg8: bool, arg9: u8) : (u64, u64, u64) {
        let v0 = if (!arg8) {
            true
        } else if (arg2 == 0) {
            true
        } else {
            arg9 != 0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::constants::action_liquidate()
        };
        if (v0) {
            return (arg5, arg2, arg6)
        };
        let v1 = 0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::utils::mul_div_uint(arg2, arg3, arg4);
        if (arg7) {
            if (arg5 >= v1) {
                arg5 = arg5 - v1;
            } else {
                let v2 = arg6 + v1;
                arg6 = v2 - arg5;
                arg5 = 0;
            };
        } else {
            let v3 = 0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::account::get_total_effective_balance(arg1, arg0);
            if (v3 < v1) {
                let v4 = arg6 + v1;
                arg6 = v4 - v3;
                0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::account::sub_margin_from_asset_vector(arg1, v3, 0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::constants::empty_string());
            } else {
                0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::account::sub_margin_from_asset_vector(arg1, v1, 0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::constants::empty_string());
            };
        };
        (arg5, arg2 - v1, arg6)
    }

    fun settle_margin(arg0: &mut vector<0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::account::DepositedAsset>, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: bool, arg7: bool, arg8: u8) : (u64, u64) {
        let v0 = arg1;
        if (arg7) {
            let v1 = 0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::utils::mul_div_uint(arg2, arg3, arg5);
            v0 = v1;
            let v2 = 0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::signed_number::from_subtraction(v1, arg1);
            if (0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::signed_number::gt_uint(v2, 0)) {
                if (arg8 != 0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::constants::action_liquidate() || !arg6) {
                    0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::account::sub_margin_from_asset_vector(arg0, 0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::signed_number::value(v2), 0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::constants::empty_string());
                } else {
                    arg4 = arg4 + 0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::signed_number::value(v2);
                };
            } else {
                0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::account::add_margin_to_asset_vector(arg0, 0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::signed_number::value(v2), 0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::constants::empty_string());
            };
        };
        (v0, arg4)
    }

    fun settle_pnl(arg0: &0x2::table::Table<0x1::string::String, 0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::bank::Asset>, arg1: &mut vector<0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::account::DepositedAsset>, arg2: u64, arg3: 0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::signed_number::Number, arg4: u64, arg5: bool, arg6: bool, arg7: u8) : (u64, u64, u64) {
        let v0 = 0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::signed_number::value(arg3);
        let v1 = arg4;
        let v2 = 0;
        let v3 = arg2;
        if (0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::signed_number::gte_uint(arg3, 0)) {
            let (v4, v5) = if (arg4 > 0) {
                if (v0 >= arg4) {
                    (v0 - arg4, 0)
                } else {
                    (0, arg4 - v0)
                }
            } else {
                (v0, arg4)
            };
            v1 = v5;
            if (arg7 != 0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::constants::action_deleverage() || !arg5) {
                if (arg6) {
                    v3 = arg2 + v4;
                } else {
                    0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::account::add_margin_to_asset_vector(arg1, v4, 0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::constants::empty_string());
                };
            };
        } else if (arg6) {
            let (v6, v7) = if (arg2 < v0) {
                (v0 - arg2, 0)
            } else {
                (0, arg2 - v0)
            };
            v3 = v7;
            v2 = v6;
        } else {
            let v8 = 0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::account::get_total_effective_balance(arg1, arg0);
            if (v8 < v0) {
                v2 = v0 - v8;
            };
            let v9 = if (v2 == 0) {
                v0
            } else {
                v8
            };
            0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::account::sub_margin_from_asset_vector(arg1, v9, 0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::constants::empty_string());
        };
        (v3, v1, v2)
    }

    fun update_position(arg0: bool, arg1: u64, arg2: u64, arg3: bool, arg4: u64, arg5: u64) : (bool, u64, u64, 0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::signed_number::Number) {
        let v0 = arg0;
        let v1 = arg2;
        let v2 = 0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::signed_number::new();
        let v3 = if (arg0 == arg3) {
            let v4 = arg1 + arg4;
            v1 = ((((arg2 as u128) * (arg1 as u128) + (arg5 as u128) * (arg4 as u128)) / (v4 as u128)) as u64);
            v4
        } else if (arg1 >= arg4) {
            v2 = calculate_pnl(arg4, arg5, arg2, arg0);
            arg1 - arg4
        } else {
            v2 = calculate_pnl(arg1, arg5, arg2, arg0);
            v1 = arg5;
            v0 = arg3;
            arg4 - arg1
        };
        (v0, v3, v1, v2)
    }

    public(friend) fun verify_health(arg0: &0x2::table::Table<0x1::string::String, 0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::perpetual::Perpetual>, arg1: &0x2::table::Table<0x1::string::String, 0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::bank::Asset>, arg2: &vector<0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::account::DepositedAsset>, arg3: &vector<0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::account::Position>, arg4: &vector<0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::account::DepositedAsset>, arg5: &vector<0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::account::Position>, arg6: u64, arg7: u8, arg8: bool) {
        let (v0, v1) = if (0x1::vector::length<0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::account::Position>(arg5) == 0) {
            let v2 = 0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::account::create_empty_position(0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::constants::empty_string(), false);
            let v3 = 0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::account::create_empty_position(0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::constants::empty_string(), false);
            (&v3, &v2)
        } else {
            (0x1::vector::borrow<0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::account::Position>(arg3, arg6), 0x1::vector::borrow<0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::account::Position>(arg5, arg6))
        };
        let (_, v5, _, v7, _, _, _, _) = 0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::account::get_position_values(v1);
        let (_, v13, _, v15, _, _, _, _) = 0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::account::get_position_values(v0);
        let v20 = 0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::account::get_account_value(arg2, arg3, arg0, arg1);
        let v21 = 0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::signed_number::sub_uint(v20, 0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::account::get_total_margin_required(arg3, arg0, 0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::constants::mmr_threshold()));
        let v22 = 0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::signed_number::sub_uint(0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::account::get_account_value(arg4, arg5, arg0, arg1), 0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::account::get_total_margin_required(arg5, arg0, 0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::constants::mmr_threshold()));
        if (0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::signed_number::gte_uint(0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::signed_number::sub_uint(v20, 0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::account::get_total_margin_required(arg3, arg0, 0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::constants::imr_threshold())), 0) || 0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::signed_number::gt(v21, v22)) {
            return
        };
        assert!(arg7 == 0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::constants::action_add_margin() || v15 == v7 && v13 < v5, 0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::errors::health_check_failed(2));
        let v23 = if (arg8 && (arg7 == 0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::constants::action_liquidate() || arg7 == 0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::constants::action_deleverage())) {
            true
        } else if (0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::signed_number::gt_uint(v21, 0)) {
            true
        } else {
            0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::signed_number::gt(v21, v22)
        };
        assert!(v23, 0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::errors::health_check_failed(5));
        let v24 = if (0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::signed_number::gte_uint(v21, 0)) {
            true
        } else if (arg7 == 0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::constants::action_add_margin()) {
            true
        } else {
            (arg7 == 0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::constants::action_liquidate() || arg7 == 0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::constants::action_deleverage()) && arg8
        };
        assert!(v24, 0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::errors::health_check_failed(3));
        let v25 = if (0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::signed_number::gte_uint(v20, 0)) {
            true
        } else if (arg7 == 0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::constants::action_add_margin()) {
            true
        } else {
            (arg7 == 0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::constants::action_liquidate() || arg7 == 0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::constants::action_deleverage()) && arg8
        };
        assert!(v25, 0xe4de143a363d775c1fa70288bd77fd6bc86cd0e9db1b24cb4b1e94316ba759fb::errors::health_check_failed(4));
    }

    // decompiled from Move bytecode v6
}

