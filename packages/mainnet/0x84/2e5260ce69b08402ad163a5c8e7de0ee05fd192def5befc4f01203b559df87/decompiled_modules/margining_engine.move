module 0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::margining_engine {
    public(friend) fun apply_maths(arg0: &mut 0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::data_store::InternalDataStore, arg1: 0x1::string::String, arg2: address, arg3: u64, arg4: u64, arg5: u64, arg6: bool, arg7: bool, arg8: bool, arg9: u8, arg10: 0x1::option::Option<0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::signed_number::Number>, arg11: 0x1::option::Option<bool>) : (u64, u64, 0x1::string::String, 0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::account::Position, vector<0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::account::DepositedAsset>, u64, u64) {
        let v0 = 0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::data_store::get_immutable_perpetual_table_from_ids(arg0);
        let v1 = 0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::data_store::get_immutable_assets_table_from_ids(arg0);
        let v2 = 0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::data_store::get_immutable_perpetual_from_ids(arg0, arg1);
        let v3 = 0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::data_store::get_immutable_account_from_ids(arg0, arg2);
        let v4 = if (arg7) {
            arg1
        } else {
            0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::constants::empty_string()
        };
        let v5 = 0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::account::get_positions_vector(v3, v4);
        let v6 = 0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::account::get_assets_vector(v3, v4);
        let v7 = 0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::account::get_positions_vector(v3, 0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::constants::empty_string());
        let v8 = 0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::account::get_assets_vector(v3, 0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::constants::empty_string());
        let v9 = v6;
        let v10 = if (arg7) {
            &mut v8
        } else {
            &mut v6
        };
        let (v11, v12) = 0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::account::get_mutable_position_for_perpetual(&mut v5, arg1, arg7);
        if (0x1::vector::length<0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::account::Position>(&v5) < v12 + 1) {
            0x1::vector::push_back<0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::account::Position>(&mut v5, *v11);
        };
        let (_, v14, v15, v16, v17, v18, _, v20) = 0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::account::get_position_values(v11);
        assert!(!arg7 || arg5 > 0, 0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::errors::invalid_leverage());
        let v21 = if (!arg7) {
            true
        } else if (v14 == 0) {
            true
        } else {
            v17 == arg5
        };
        assert!(v21, 0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::errors::invalid_leverage());
        let (v22, v23, v24, v25) = update_position(v16, v14, v15, arg6, arg4, arg3);
        let (v26, v27) = settle_pnl(v1, v10, v18, v25, arg8, arg7, arg9);
        let (v28, v29) = settle_pending_funding_payment(v1, v10, v20, arg4, v14, v26, v27, arg7, arg9);
        let (v30, v31, v32) = settle_fee(v1, v2, v3, v10, arg4, arg3, arg8, arg9);
        let (v33, v34) = settle_margin(v10, v28, v23, v24, arg5, arg8, arg7, arg9);
        premium_or_debt_settlement(v10, arg10, arg8, arg9);
        0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::account::set_isolated_position_assets(&mut v6, v34);
        0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::account::update_position_values(v11, v23, v24, v34, v33, v22, 0);
        verify_health(v0, v1, &v6, &v5, &v9, &v5, v12, arg9, arg8);
        if (arg7 && arg9 == 0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::constants::action_trade()) {
            verify_health(v0, v1, &v8, &v7, &v8, &v7, v12, 0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::constants::action_isolated_trade(), arg8);
        };
        let v35 = if (arg7) {
            v8
        } else {
            v6
        };
        v6 = v35;
        0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::account::update_account(0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::data_store::get_mutable_account_from_ids(arg0, arg2), &v6, &v5, v12, arg7);
        (v30, v31, v32, *v11, v6, v29, settle_gas_charges(arg0, v10, v3, arg11, arg8, arg9))
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
            let v3 = 0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::utils::base_mul(v2, arg3);
            let v4 = 0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::utils::base_mul(v3, arg5);
            (v3 - v4, v4)
        }
    }

    public fun calculate_pnl(arg0: u64, arg1: u64, arg2: u64, arg3: bool) : 0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::signed_number::Number {
        if (arg3) {
            0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::signed_number::mul_uint(0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::signed_number::sub_uint(0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::signed_number::from(arg1, true), arg2), arg0)
        } else {
            0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::signed_number::negate(0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::signed_number::mul_uint(0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::signed_number::sub_uint(0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::signed_number::from(arg1, true), arg2), arg0))
        }
    }

    public(friend) fun compute_trade_fee(arg0: &0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::account::Account, arg1: &0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::perpetual::Perpetual, arg2: u64, arg3: bool) : u64 {
        let (v0, v1) = 0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::perpetual::get_fees(arg1);
        let (v2, v3, v4) = 0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::account::get_fees(arg0);
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
        0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::utils::base_mul(v5, arg2)
    }

    public fun get_withdrawable_assets(arg0: &0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::data_store::InternalDataStore, arg1: address, arg2: vector<u8>) : u64 {
        let v0 = 0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::data_store::get_immutable_perpetual_table_from_ids(arg0);
        let v1 = 0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::data_store::get_immutable_account_from_ids(arg0, arg1);
        let v2 = 0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::account::get_positions_vector(v1, 0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::constants::empty_string());
        let v3 = 0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::account::get_assets_vector(v1, 0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::constants::empty_string());
        let v4 = 0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::signed_number::sub_uint(0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::account::get_account_value(&v3, &v2, v0, 0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::data_store::get_immutable_assets_table_from_ids(arg0)), 0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::account::get_total_margin_required(&v2, v0, 0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::constants::imr_threshold()));
        let v5 = if (0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::signed_number::gt_uint(v4, 0)) {
            0x1::u64::min((0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::signed_number::value(v4) as u64), (0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::account::get_asset_quantity(&v3, arg2) as u64))
        } else {
            0
        };
        (v5 as u64)
    }

    fun premium_or_debt_settlement(arg0: &mut vector<0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::account::DepositedAsset>, arg1: 0x1::option::Option<0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::signed_number::Number>, arg2: bool, arg3: u8) {
        if (arg3 == 0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::constants::action_liquidate() && !arg2) {
            assert!(0x1::option::is_some<0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::signed_number::Number>(&arg1), 0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::errors::missing_optional_param());
            let v0 = 0x1::option::extract<0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::signed_number::Number>(&mut arg1);
            let v1 = 0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::signed_number::value(v0);
            if (v1 > 0) {
                if (0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::signed_number::sign(v0)) {
                    0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::account::add_margin_to_asset_vector(arg0, v1, 0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::constants::empty_string());
                } else {
                    0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::account::sub_margin_from_asset_vector(arg0, v1, 0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::constants::empty_string());
                };
            };
        };
    }

    fun settle_fee(arg0: &0x2::table::Table<0x1::string::String, 0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::bank::Asset>, arg1: &0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::perpetual::Perpetual, arg2: &0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::account::Account, arg3: &mut vector<0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::account::DepositedAsset>, arg4: u64, arg5: u64, arg6: bool, arg7: u8) : (u64, u64, 0x1::string::String) {
        let v0 = 0;
        let v1 = 0;
        let v2 = 0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::account::get_fee_asset(arg2);
        let v3 = v2;
        if (arg7 == 0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::constants::action_trade()) {
            let v4 = compute_trade_fee(arg2, arg1, 0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::utils::base_mul(arg5, arg4), arg6);
            v0 = v4;
            v1 = v4;
            if (v4 > 0 && !0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::utils::is_empty_string(v2)) {
                v1 = 0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::bank::get_asset_with_provided_usd_value(arg0, v2, v4);
            };
            if (v1 > 0) {
                0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::account::sub_margin_from_asset_vector(arg3, v1, v2);
            };
        };
        if (0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::utils::is_empty_string(v2)) {
            v3 = 0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::constants::usdc_token_symbol();
        };
        (v0, v1, v3)
    }

    fun settle_gas_charges(arg0: &0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::data_store::InternalDataStore, arg1: &mut vector<0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::account::DepositedAsset>, arg2: &0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::account::Account, arg3: 0x1::option::Option<bool>, arg4: bool, arg5: u8) : u64 {
        let v0 = 0;
        if (arg5 == 0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::constants::action_trade() && !arg4) {
            assert!(0x1::option::is_some<bool>(&arg3), 0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::errors::missing_optional_param());
            if (0x1::option::extract<bool>(&mut arg3) && !0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::account::is_institution(arg2)) {
                let v1 = 0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::data_store::get_gas_fee_amount(arg0);
                v0 = v1;
                0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::account::sub_margin_from_asset_vector(arg1, v1, 0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::constants::empty_string());
            };
        };
        v0
    }

    fun settle_margin(arg0: &mut vector<0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::account::DepositedAsset>, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: bool, arg6: bool, arg7: u8) : (u64, u64) {
        let v0 = arg1;
        if (arg6 && (arg7 != 0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::constants::action_liquidate() || !arg5)) {
            let v1 = 0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::utils::base_div(0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::utils::base_mul(arg2, arg3), arg4);
            v0 = v1;
            let v2 = 0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::signed_number::from_subtraction(v1, arg1);
            if (0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::signed_number::gt_uint(v2, 0)) {
                0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::account::sub_margin_from_asset_vector(arg0, 0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::signed_number::value(v2), 0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::constants::empty_string());
            } else if (arg7 != 0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::constants::action_liquidate() || arg5 == false) {
                0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::account::add_margin_to_asset_vector(arg0, 0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::signed_number::value(v2), 0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::constants::empty_string());
            };
        } else {
            let v3 = if (arg6) {
                if (arg5) {
                    if (arg2 == 0) {
                        arg7 == 0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::constants::action_liquidate()
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            };
            if (v3) {
                if (arg1 > 0) {
                    0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::account::add_margin_to_asset_vector(arg0, arg1, 0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::constants::empty_string());
                    v0 = 0;
                };
            } else if (!arg6) {
                arg4 = 0;
            };
        };
        (arg4, v0)
    }

    fun settle_pending_funding_payment(arg0: &0x2::table::Table<0x1::string::String, 0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::bank::Asset>, arg1: &mut vector<0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::account::DepositedAsset>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: bool, arg8: u8) : (u64, u64) {
        if (arg2 == 0 || arg8 != 0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::constants::action_liquidate()) {
            return (arg5, arg6)
        };
        let v0 = (((arg2 as u128) * (arg3 as u128) / (arg4 as u128)) as u64);
        if (arg7) {
            if (arg5 >= v0) {
                arg5 = arg5 - v0;
            } else {
                let v1 = arg6 + v0;
                arg6 = v1 - arg5;
                arg5 = 0;
            };
        } else {
            let v2 = 0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::account::get_total_effective_balance(arg1, arg0);
            if (v2 < v0) {
                let v3 = arg6 + v0;
                arg6 = v3 - v2;
                0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::account::sub_margin_from_asset_vector(arg1, v2, 0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::constants::empty_string());
            } else {
                0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::account::sub_margin_from_asset_vector(arg1, v0, 0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::constants::empty_string());
            };
        };
        (arg5, arg6)
    }

    fun settle_pnl(arg0: &0x2::table::Table<0x1::string::String, 0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::bank::Asset>, arg1: &mut vector<0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::account::DepositedAsset>, arg2: u64, arg3: 0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::signed_number::Number, arg4: bool, arg5: bool, arg6: u8) : (u64, u64) {
        let v0 = 0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::signed_number::value(arg3);
        let v1 = 0;
        let v2 = arg2;
        if (0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::signed_number::gte_uint(arg3, 0) && (arg6 != 0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::constants::action_deleverage() || !arg4)) {
            if (arg5) {
                v2 = arg2 + v0;
            } else {
                0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::account::add_margin_to_asset_vector(arg1, v0, 0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::constants::empty_string());
            };
        } else if (arg5) {
            let (v3, v4) = if (arg2 < v0) {
                (v0 - arg2, 0)
            } else {
                (0, arg2 - v0)
            };
            v2 = v4;
            v1 = v3;
        } else {
            let v5 = 0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::account::get_total_effective_balance(arg1, arg0);
            if (v5 < v0) {
                v1 = v0 - v5;
            };
            let v6 = if (v1 == 0) {
                v0
            } else {
                v5
            };
            0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::account::sub_margin_from_asset_vector(arg1, v6, 0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::constants::empty_string());
        };
        (v2, v1)
    }

    fun update_position(arg0: bool, arg1: u64, arg2: u64, arg3: bool, arg4: u64, arg5: u64) : (bool, u64, u64, 0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::signed_number::Number) {
        let v0 = arg0;
        let v1 = arg2;
        let v2 = 0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::signed_number::new();
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

    public(friend) fun verify_health(arg0: &0x2::table::Table<0x1::string::String, 0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::perpetual::Perpetual>, arg1: &0x2::table::Table<0x1::string::String, 0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::bank::Asset>, arg2: &vector<0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::account::DepositedAsset>, arg3: &vector<0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::account::Position>, arg4: &vector<0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::account::DepositedAsset>, arg5: &vector<0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::account::Position>, arg6: u64, arg7: u8, arg8: bool) {
        let (v0, v1) = if (0x1::vector::length<0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::account::Position>(arg5) == 0) {
            let v2 = 0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::account::create_empty_position(0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::constants::empty_string(), false);
            let v3 = 0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::account::create_empty_position(0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::constants::empty_string(), false);
            (&v3, &v2)
        } else {
            (0x1::vector::borrow<0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::account::Position>(arg3, arg6), 0x1::vector::borrow<0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::account::Position>(arg5, arg6))
        };
        let (_, v5, _, v7, _, _, _, _) = 0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::account::get_position_values(v1);
        let (_, v13, _, v15, _, _, _, _) = 0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::account::get_position_values(v0);
        let v20 = 0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::account::get_account_value(arg2, arg3, arg0, arg1);
        let v21 = 0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::signed_number::sub_uint(v20, 0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::account::get_total_margin_required(arg3, arg0, 0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::constants::imr_threshold()));
        if (0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::signed_number::gte_uint(v21, 0)) {
            return
        };
        if (arg7 == 0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::constants::action_isolated_trade()) {
            if (0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::signed_number::gte(v21, 0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::signed_number::sub_uint(0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::account::get_account_value(arg4, arg5, arg0, arg1), 0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::account::get_total_margin_required(arg5, arg0, 0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::constants::imr_threshold())))) {
                return
            };
        };
        assert!(arg7 == 0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::constants::action_add_margin() || v15 == v7 && v13 < v5, 0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::errors::health_check_failed(2));
        let v22 = if (0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::signed_number::gte_uint(0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::signed_number::sub_uint(v20, 0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::account::get_total_margin_required(arg3, arg0, 0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::constants::mmr_threshold())), 0)) {
            true
        } else if (arg7 == 0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::constants::action_add_margin()) {
            true
        } else {
            (arg7 == 0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::constants::action_liquidate() || arg7 == 0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::constants::action_deleverage()) && arg8
        };
        assert!(v22, 0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::errors::health_check_failed(3));
        let v23 = if (0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::signed_number::gt_uint(v20, 0)) {
            true
        } else if (arg7 == 0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::constants::action_add_margin()) {
            true
        } else {
            (arg7 == 0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::constants::action_liquidate() || arg7 == 0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::constants::action_deleverage()) && arg8
        };
        assert!(v23, 0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::errors::health_check_failed(4));
    }

    // decompiled from Move bytecode v6
}

