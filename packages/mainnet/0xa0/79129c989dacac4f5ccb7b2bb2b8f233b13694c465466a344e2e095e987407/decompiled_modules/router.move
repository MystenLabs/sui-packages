module 0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::router {
    public fun borrow<T0, T1>(arg0: &mut 0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::context::MarginTradingContext, arg1: &0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::config::GlobalConfig, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: &0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::market::Market, arg4: &0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::position::PositionCap, arg5: u64, arg6: u64, arg7: &mut 0x3::sui_system::SuiSystemState, arg8: &0x2::clock::Clock, arg9: &0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::versioned::Versioned, arg10: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::versioned::check_version(arg9);
        assert!(arg6 > 0, 0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::errors::err_insufficient_collateral());
        0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::config::check_borrow_permission(arg1);
        0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::market::check_borrow_permission(arg3);
        let v0 = 0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::market::borrow_position<T0>(arg3, 0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::position::position_id(arg4));
        let v1 = if (0x1::type_name::with_defining_ids<T1>() == 0x1::type_name::with_defining_ids<0x2::sui::SUI>()) {
            let v2 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::borrow_request<T0, 0x2::sui::SUI>(arg2, arg5, 0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::position::obligation_owner_cap<T0>(v0), arg8, arg6);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::unstake_sui_from_staker<T0>(arg2, arg5, &v2, arg7, arg10);
            let v3 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::fulfill_liquidity_request<T0, 0x2::sui::SUI>(arg2, arg5, v2, arg10);
            cast_as_type<0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<T1>>(v3, arg10)
        } else {
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::borrow<T0, T1>(arg2, arg5, 0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::position::obligation_owner_cap<T0>(v0), arg8, arg6, arg10)
        };
        let v4 = v1;
        0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::position::emit_borrow_event<T0, T1>(arg0, v0, 0x2::coin::value<T1>(&v4), arg8);
        0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::context::mark_operation_executed(arg0);
        v4
    }

    public fun calculate_fee(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg0 < arg1, 0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::errors::err_invalid_fee_rate());
        (((arg2 as u128) * (arg0 as u128) / (arg1 as u128)) as u64)
    }

    fun cast_as_type<T0: store, T1: store>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) : T1 {
        let v0 = 0x2::object::new(arg1);
        0x2::dynamic_field::add<bool, T0>(&mut v0, true, arg0);
        0x2::object::delete(v0);
        0x2::dynamic_field::remove<bool, T1>(&mut v0, true)
    }

    public fun claim_rewards<T0, T1>(arg0: &mut 0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::context::MarginTradingContext, arg1: &0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::config::GlobalConfig, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: &mut 0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::market::Market, arg4: &0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::position::PositionCap, arg5: u64, arg6: u64, arg7: bool, arg8: &0x2::clock::Clock, arg9: &0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::versioned::Versioned, arg10: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::versioned::check_version(arg9);
        0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::config::check_claim_reward_permission(arg1);
        0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::market::check_claim_reward_permission(arg3);
        let v0 = 0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::market::borrow_mut_position<T0>(arg3, 0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::position::position_id(arg4));
        let v1 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::claim_rewards<T0, T1>(arg2, 0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::position::obligation_owner_cap<T0>(v0), arg8, arg5, arg6, arg7, arg10);
        0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::position::emit_claim_reward_event<T0, T1>(arg0, v0, 0x2::coin::value<T1>(&v1), arg8);
        0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::context::mark_operation_executed(arg0);
        v1
    }

    public fun close_position<T0>(arg0: &mut 0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::context::MarginTradingContext, arg1: &0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::config::GlobalConfig, arg2: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: &mut 0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::market::Market, arg4: 0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::position::PositionCap, arg5: &0x2::clock::Clock, arg6: &0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::versioned::Versioned) {
        0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::versioned::check_version(arg6);
        0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::config::check_close_permission(arg1);
        0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::market::check_close_permission(arg3);
        let v0 = 0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::market::remove_position_from_position_holder<T0>(arg3, 0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::position::position_id(&arg4));
        0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::position::emit_close_position_event<T0>(arg0, &v0, arg5);
        let v1 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation<T0>(arg2, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation_id<T0>(0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::position::obligation_owner_cap<T0>(&v0)));
        assert!(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::le(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::allowed_borrow_value_usd<T0>(v1), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(1)), 0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::errors::err_position_balance_not_zero());
        assert!(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::le(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::deposited_value_usd<T0>(v1), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(1)), 0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::errors::err_position_balance_not_zero());
        0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::position::destroy_position<T0>(v0, arg1);
        0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::position::destroy_position_cap(arg4);
        0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::context::mark_operation_executed(arg0);
    }

    public fun confirm(arg0: 0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::context::MarginTradingContext) {
        0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::context::emit_margin_trading_confirm_event(&arg0);
        0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::context::destroy_margin_trading_context(arg0);
    }

    public fun create_margin_trading_context<T0>(arg0: &0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::market::Market, arg1: &0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::position::PositionCap, arg2: 0x1::string::String, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::context::MarginTradingContext {
        let v0 = 0x1::string::as_bytes(&arg2);
        let v1 = b"open_position";
        let v2 = if (v0 == &v1) {
            true
        } else {
            let v3 = b"close_position";
            if (v0 == &v3) {
                true
            } else {
                let v4 = b"increase_size";
                if (v0 == &v4) {
                    true
                } else {
                    let v5 = b"decrease_size";
                    if (v0 == &v5) {
                        true
                    } else {
                        let v6 = b"increase_leverage";
                        if (v0 == &v6) {
                            true
                        } else {
                            let v7 = b"decrease_leverage";
                            if (v0 == &v7) {
                                true
                            } else {
                                let v8 = b"top_up_collateral";
                                if (v0 == &v8) {
                                    true
                                } else {
                                    let v9 = b"withdraw_collateral";
                                    if (v0 == &v9) {
                                        true
                                    } else {
                                        let v10 = b"repay_debt";
                                        if (v0 == &v10) {
                                            true
                                        } else {
                                            let v11 = b"claim_reward";
                                            v0 == &v11
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        };
        assert!(v2, 0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::errors::err_invalid_action());
        0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::context::new_margin_trading_context(0x2::object::id<0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::market::Market>(arg0), 0x2::object::id<0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::position::PositionCap>(arg1), 0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::position::position_id(arg1), arg2, 0x1::type_name::with_defining_ids<T0>(), arg3, arg4)
    }

    public fun deposit<T0, T1>(arg0: &mut 0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::context::MarginTradingContext, arg1: &0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::config::GlobalConfig, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: &mut 0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::market::Market, arg4: &0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::position::PositionCap, arg5: 0x2::coin::Coin<T1>, arg6: u64, arg7: &0x2::clock::Clock, arg8: &0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::versioned::Versioned, arg9: &mut 0x2::tx_context::TxContext) {
        0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::versioned::check_version(arg8);
        0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::config::check_deposit_permission(arg1);
        0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::market::check_deposit_permission(arg3);
        let v0 = 0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::market::borrow_mut_position<T0>(arg3, 0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::position::position_id(arg4));
        let v1 = 0x2::coin::into_balance<T1>(arg5);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_ctokens_into_obligation<T0, T1>(arg2, arg6, 0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::position::obligation_owner_cap<T0>(v0), arg7, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_liquidity_and_mint_ctokens<T0, T1>(arg2, arg6, arg7, 0x2::coin::from_balance<T1>(v1, arg9), arg9), arg9);
        0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::position::emit_deposit_event<T0, T1>(arg0, v0, 0x2::balance::value<T1>(&v1), arg7);
        0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::market::join_fee<T1>(arg3, 0x2::balance::split<T1>(&mut v1, calculate_fee(0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::market::open_fee_rate(arg3), 1000000, 0x2::coin::value<T1>(&arg5))), 0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::position::is_long<T0>(v0));
        0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::context::mark_operation_executed(arg0);
    }

    public fun open_position<T0, T1, T2>(arg0: &0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::config::GlobalConfig, arg1: &mut 0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::market::Market, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::versioned::Versioned, arg7: &mut 0x2::tx_context::TxContext) : (0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::position::PositionCap, 0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::context::MarginTradingContext) {
        0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::versioned::check_version(arg6);
        0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::config::check_open_permission(arg0);
        0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::market::check_open_permission(arg1);
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        let v1 = 0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::market::base_token(arg1);
        let v2 = 0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::market::quote_token(arg1);
        assert!(v0 == v1 || v0 == v2, 0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::errors::err_invalid_deposit_type());
        let (v3, v4, v5) = if (v0 == v1) {
            (true, v1, v2)
        } else {
            (false, v2, v1)
        };
        let v6 = 0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::position::create_position<T0>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::create_obligation<T0>(arg2, arg7), v3, 0x2::object::id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>>(arg2), 0x2::object::id<0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::market::Market>(arg1), arg5, arg7);
        let v7 = 0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::position::new_position_cap(0x2::object::id<0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::position::Position<T0>>(&v6), arg7);
        let v8 = create_margin_trading_context<T2>(arg1, &v7, 0x1::string::utf8(b"open_position"), arg3, arg7);
        0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::position::emit_open_position_event<T0>(&v8, &v6, arg4, v4, v5, arg5);
        0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::market::add_position_into_position_holder<T0>(arg1, v6);
        0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::context::mark_operation_executed(&mut v8);
        (v7, v8)
    }

    public fun repay<T0, T1>(arg0: &mut 0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::context::MarginTradingContext, arg1: &0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::config::GlobalConfig, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: &mut 0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::market::Market, arg4: &0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::position::PositionCap, arg5: &mut 0x2::coin::Coin<T1>, arg6: u64, arg7: &0x2::clock::Clock, arg8: &0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::versioned::Versioned, arg9: &mut 0x2::tx_context::TxContext) {
        0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::versioned::check_version(arg8);
        0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::config::check_repay_permission(arg1);
        0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::market::check_repay_permission(arg3);
        let v0 = 0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::market::borrow_mut_position<T0>(arg3, 0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::position::position_id(arg4));
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::repay<T0, T1>(arg2, arg6, 0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::position::obligation_id<T0>(v0), arg7, arg5, arg9);
        0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::position::emit_repay_event<T0, T1>(arg0, v0, 0x2::coin::value<T1>(arg5) - 0x2::coin::value<T1>(arg5), arg7);
        0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::context::mark_operation_executed(arg0);
    }

    public fun withdraw<T0, T1>(arg0: &mut 0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::context::MarginTradingContext, arg1: &0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::config::GlobalConfig, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: &mut 0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::market::Market, arg4: &0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::position::PositionCap, arg5: 0x1::option::Option<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, T1>>, arg6: u64, arg7: u64, arg8: &mut 0x3::sui_system::SuiSystemState, arg9: &0x2::clock::Clock, arg10: &0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::versioned::Versioned, arg11: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::versioned::check_version(arg10);
        0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::config::check_withdraw_permission(arg1);
        0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::market::check_withdraw_permission(arg3);
        assert!(arg6 > 0, 0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::errors::err_insufficient_collateral());
        let v0 = 0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::market::borrow_mut_position<T0>(arg3, 0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::position::position_id(arg4));
        let v1 = if (0x1::type_name::with_defining_ids<T1>() == 0x1::type_name::with_defining_ids<0x2::sui::SUI>()) {
            0x1::option::destroy_none<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, T1>>(arg5);
            let v2 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity_request<T0, 0x2::sui::SUI>(arg2, arg7, arg9, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::withdraw_ctokens<T0, 0x2::sui::SUI>(arg2, arg7, 0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::position::obligation_owner_cap<T0>(v0), arg9, arg6, arg11), 0x1::option::none<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, 0x2::sui::SUI>>(), arg11);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::unstake_sui_from_staker<T0>(arg2, arg7, &v2, arg8, arg11);
            let v3 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::fulfill_liquidity_request<T0, 0x2::sui::SUI>(arg2, arg7, v2, arg11);
            cast_as_type<0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<T1>>(v3, arg11)
        } else {
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity<T0, T1>(arg2, arg7, arg9, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::withdraw_ctokens<T0, T1>(arg2, arg7, 0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::position::obligation_owner_cap<T0>(v0), arg9, arg6, arg11), arg5, arg11)
        };
        let v4 = v1;
        let v5 = 0x2::coin::into_balance<T1>(v4);
        0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::position::emit_withdraw_event<T0, T1>(arg0, v0, 0x2::balance::value<T1>(&v5), arg9);
        0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::market::join_fee<T1>(arg3, 0x2::balance::split<T1>(&mut v5, calculate_fee(0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::market::close_fee_rate(arg3), 1000000, 0x2::coin::value<T1>(&v4))), 0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::position::is_long<T0>(v0));
        0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::context::mark_operation_executed(arg0);
        0x2::coin::from_balance<T1>(v5, arg11)
    }

    // decompiled from Move bytecode v6
}

