module 0xbc5b3136d2e8e862e941f07886ba69fe84564fbfefc49361dbce9e1ca513e92e::router {
    public fun borrow_not_sui<T0, T1>(arg0: &0xbc5b3136d2e8e862e941f07886ba69fe84564fbfefc49361dbce9e1ca513e92e::context::MarginTradingContext, arg1: &0xbc5b3136d2e8e862e941f07886ba69fe84564fbfefc49361dbce9e1ca513e92e::config::GlobalConfig, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: &0xbc5b3136d2e8e862e941f07886ba69fe84564fbfefc49361dbce9e1ca513e92e::market::Market, arg4: &0xbc5b3136d2e8e862e941f07886ba69fe84564fbfefc49361dbce9e1ca513e92e::position::PositionCap, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &0xbc5b3136d2e8e862e941f07886ba69fe84564fbfefc49361dbce9e1ca513e92e::versioned::Versioned, arg9: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xbc5b3136d2e8e862e941f07886ba69fe84564fbfefc49361dbce9e1ca513e92e::versioned::check_version(arg8);
        0xbc5b3136d2e8e862e941f07886ba69fe84564fbfefc49361dbce9e1ca513e92e::config::check_borrow_permission(arg1);
        0xbc5b3136d2e8e862e941f07886ba69fe84564fbfefc49361dbce9e1ca513e92e::market::check_borrow_permission(arg3);
        let v0 = 0xbc5b3136d2e8e862e941f07886ba69fe84564fbfefc49361dbce9e1ca513e92e::market::borrow_position<T0>(arg3, 0xbc5b3136d2e8e862e941f07886ba69fe84564fbfefc49361dbce9e1ca513e92e::position::position_id(arg4));
        let v1 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::borrow<T0, T1>(arg2, arg5, 0xbc5b3136d2e8e862e941f07886ba69fe84564fbfefc49361dbce9e1ca513e92e::position::obligation_owner_cap<T0>(v0), arg7, arg6, arg9);
        0xbc5b3136d2e8e862e941f07886ba69fe84564fbfefc49361dbce9e1ca513e92e::position::emit_borrow_event<T0, T1>(arg0, v0, 0x2::coin::value<T1>(&v1), arg7);
        v1
    }

    public fun borrow_sui<T0>(arg0: &0xbc5b3136d2e8e862e941f07886ba69fe84564fbfefc49361dbce9e1ca513e92e::context::MarginTradingContext, arg1: &0xbc5b3136d2e8e862e941f07886ba69fe84564fbfefc49361dbce9e1ca513e92e::config::GlobalConfig, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: &0xbc5b3136d2e8e862e941f07886ba69fe84564fbfefc49361dbce9e1ca513e92e::market::Market, arg4: &0xbc5b3136d2e8e862e941f07886ba69fe84564fbfefc49361dbce9e1ca513e92e::position::PositionCap, arg5: u64, arg6: u64, arg7: &mut 0x3::sui_system::SuiSystemState, arg8: &0x2::clock::Clock, arg9: &0xbc5b3136d2e8e862e941f07886ba69fe84564fbfefc49361dbce9e1ca513e92e::versioned::Versioned, arg10: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0xbc5b3136d2e8e862e941f07886ba69fe84564fbfefc49361dbce9e1ca513e92e::versioned::check_version(arg9);
        0xbc5b3136d2e8e862e941f07886ba69fe84564fbfefc49361dbce9e1ca513e92e::config::check_borrow_permission(arg1);
        0xbc5b3136d2e8e862e941f07886ba69fe84564fbfefc49361dbce9e1ca513e92e::market::check_borrow_permission(arg3);
        let v0 = 0xbc5b3136d2e8e862e941f07886ba69fe84564fbfefc49361dbce9e1ca513e92e::market::borrow_position<T0>(arg3, 0xbc5b3136d2e8e862e941f07886ba69fe84564fbfefc49361dbce9e1ca513e92e::position::position_id(arg4));
        let v1 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::borrow_request<T0, 0x2::sui::SUI>(arg2, arg5, 0xbc5b3136d2e8e862e941f07886ba69fe84564fbfefc49361dbce9e1ca513e92e::position::obligation_owner_cap<T0>(v0), arg8, arg6);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::unstake_sui_from_staker<T0>(arg2, arg5, &v1, arg7, arg10);
        let v2 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::fulfill_liquidity_request<T0, 0x2::sui::SUI>(arg2, arg5, v1, arg10);
        0xbc5b3136d2e8e862e941f07886ba69fe84564fbfefc49361dbce9e1ca513e92e::position::emit_borrow_event<T0, 0x2::sui::SUI>(arg0, v0, 0x2::coin::value<0x2::sui::SUI>(&v2), arg8);
        v2
    }

    public fun calculate_fee(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg0 < arg1, 0xbc5b3136d2e8e862e941f07886ba69fe84564fbfefc49361dbce9e1ca513e92e::errors::err_invalid_fee_rate());
        (((arg2 as u128) * (arg0 as u128) / (arg1 as u128)) as u64)
    }

    public fun close_position<T0>(arg0: &0xbc5b3136d2e8e862e941f07886ba69fe84564fbfefc49361dbce9e1ca513e92e::context::MarginTradingContext, arg1: &0xbc5b3136d2e8e862e941f07886ba69fe84564fbfefc49361dbce9e1ca513e92e::config::GlobalConfig, arg2: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: &mut 0xbc5b3136d2e8e862e941f07886ba69fe84564fbfefc49361dbce9e1ca513e92e::market::Market, arg4: 0xbc5b3136d2e8e862e941f07886ba69fe84564fbfefc49361dbce9e1ca513e92e::position::PositionCap, arg5: &0x2::clock::Clock, arg6: &0xbc5b3136d2e8e862e941f07886ba69fe84564fbfefc49361dbce9e1ca513e92e::versioned::Versioned) {
        0xbc5b3136d2e8e862e941f07886ba69fe84564fbfefc49361dbce9e1ca513e92e::versioned::check_version(arg6);
        0xbc5b3136d2e8e862e941f07886ba69fe84564fbfefc49361dbce9e1ca513e92e::config::check_close_permission(arg1);
        0xbc5b3136d2e8e862e941f07886ba69fe84564fbfefc49361dbce9e1ca513e92e::market::check_close_permission(arg3);
        let v0 = 0xbc5b3136d2e8e862e941f07886ba69fe84564fbfefc49361dbce9e1ca513e92e::market::remove_position_from_position_holder<T0>(arg3, 0xbc5b3136d2e8e862e941f07886ba69fe84564fbfefc49361dbce9e1ca513e92e::position::position_id(&arg4));
        0xbc5b3136d2e8e862e941f07886ba69fe84564fbfefc49361dbce9e1ca513e92e::position::emit_close_position_event<T0>(arg0, &v0, arg5);
        let v1 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation<T0>(arg2, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation_id<T0>(0xbc5b3136d2e8e862e941f07886ba69fe84564fbfefc49361dbce9e1ca513e92e::position::obligation_owner_cap<T0>(&v0)));
        assert!(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::le(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::allowed_borrow_value_usd<T0>(v1), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(1)), 0xbc5b3136d2e8e862e941f07886ba69fe84564fbfefc49361dbce9e1ca513e92e::errors::err_position_balance_not_zero());
        assert!(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::le(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::deposited_value_usd<T0>(v1), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(1)), 0xbc5b3136d2e8e862e941f07886ba69fe84564fbfefc49361dbce9e1ca513e92e::errors::err_position_balance_not_zero());
        0xbc5b3136d2e8e862e941f07886ba69fe84564fbfefc49361dbce9e1ca513e92e::position::destroy_position<T0>(v0, arg1);
        0xbc5b3136d2e8e862e941f07886ba69fe84564fbfefc49361dbce9e1ca513e92e::position::destroy_position_cap(arg4);
    }

    public fun confirm(arg0: 0xbc5b3136d2e8e862e941f07886ba69fe84564fbfefc49361dbce9e1ca513e92e::context::MarginTradingContext) {
        0xbc5b3136d2e8e862e941f07886ba69fe84564fbfefc49361dbce9e1ca513e92e::context::emit_margin_trading_confirm_event(&arg0);
        0xbc5b3136d2e8e862e941f07886ba69fe84564fbfefc49361dbce9e1ca513e92e::context::destroy_margin_trading_context(arg0);
    }

    public fun create_margin_trading_context(arg0: 0x1::string::String, arg1: &0xbc5b3136d2e8e862e941f07886ba69fe84564fbfefc49361dbce9e1ca513e92e::market::Market, arg2: &0xbc5b3136d2e8e862e941f07886ba69fe84564fbfefc49361dbce9e1ca513e92e::position::PositionCap, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : 0xbc5b3136d2e8e862e941f07886ba69fe84564fbfefc49361dbce9e1ca513e92e::context::MarginTradingContext {
        let v0 = 0x1::string::as_bytes(&arg3);
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
                                    let v9 = b"repay_debt";
                                    v0 == &v9
                                }
                            }
                        }
                    }
                }
            }
        };
        assert!(v2, 0xbc5b3136d2e8e862e941f07886ba69fe84564fbfefc49361dbce9e1ca513e92e::errors::err_invalid_action());
        0xbc5b3136d2e8e862e941f07886ba69fe84564fbfefc49361dbce9e1ca513e92e::context::new_margin_trading_context(arg0, 0x2::object::id<0xbc5b3136d2e8e862e941f07886ba69fe84564fbfefc49361dbce9e1ca513e92e::market::Market>(arg1), 0x2::object::id<0xbc5b3136d2e8e862e941f07886ba69fe84564fbfefc49361dbce9e1ca513e92e::position::PositionCap>(arg2), 0xbc5b3136d2e8e862e941f07886ba69fe84564fbfefc49361dbce9e1ca513e92e::position::position_id(arg2), arg3, arg4, arg5, arg6)
    }

    public fun deposit<T0, T1>(arg0: &0xbc5b3136d2e8e862e941f07886ba69fe84564fbfefc49361dbce9e1ca513e92e::context::MarginTradingContext, arg1: &0xbc5b3136d2e8e862e941f07886ba69fe84564fbfefc49361dbce9e1ca513e92e::config::GlobalConfig, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: &mut 0xbc5b3136d2e8e862e941f07886ba69fe84564fbfefc49361dbce9e1ca513e92e::market::Market, arg4: &0xbc5b3136d2e8e862e941f07886ba69fe84564fbfefc49361dbce9e1ca513e92e::position::PositionCap, arg5: 0x2::coin::Coin<T1>, arg6: u64, arg7: &0x2::clock::Clock, arg8: &0xbc5b3136d2e8e862e941f07886ba69fe84564fbfefc49361dbce9e1ca513e92e::versioned::Versioned, arg9: &mut 0x2::tx_context::TxContext) {
        0xbc5b3136d2e8e862e941f07886ba69fe84564fbfefc49361dbce9e1ca513e92e::versioned::check_version(arg8);
        0xbc5b3136d2e8e862e941f07886ba69fe84564fbfefc49361dbce9e1ca513e92e::config::check_deposit_permission(arg1);
        0xbc5b3136d2e8e862e941f07886ba69fe84564fbfefc49361dbce9e1ca513e92e::market::check_deposit_permission(arg3);
        let v0 = 0xbc5b3136d2e8e862e941f07886ba69fe84564fbfefc49361dbce9e1ca513e92e::market::borrow_mut_position<T0>(arg3, 0xbc5b3136d2e8e862e941f07886ba69fe84564fbfefc49361dbce9e1ca513e92e::position::position_id(arg4));
        let v1 = 0x2::coin::into_balance<T1>(arg5);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_ctokens_into_obligation<T0, T1>(arg2, arg6, 0xbc5b3136d2e8e862e941f07886ba69fe84564fbfefc49361dbce9e1ca513e92e::position::obligation_owner_cap<T0>(v0), arg7, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_liquidity_and_mint_ctokens<T0, T1>(arg2, arg6, arg7, 0x2::coin::from_balance<T1>(v1, arg9), arg9), arg9);
        0xbc5b3136d2e8e862e941f07886ba69fe84564fbfefc49361dbce9e1ca513e92e::position::emit_deposit_event<T0, T1>(arg0, v0, 0x2::balance::value<T1>(&v1), arg7);
        0xbc5b3136d2e8e862e941f07886ba69fe84564fbfefc49361dbce9e1ca513e92e::market::join_fee<T1>(arg3, 0x2::balance::split<T1>(&mut v1, calculate_fee(0xbc5b3136d2e8e862e941f07886ba69fe84564fbfefc49361dbce9e1ca513e92e::market::open_fee_rate(arg3), 1000000, 0x2::coin::value<T1>(&arg5))), 0xbc5b3136d2e8e862e941f07886ba69fe84564fbfefc49361dbce9e1ca513e92e::position::is_long<T0>(v0));
    }

    public fun open_position<T0, T1>(arg0: &0xbc5b3136d2e8e862e941f07886ba69fe84564fbfefc49361dbce9e1ca513e92e::config::GlobalConfig, arg1: &mut 0xbc5b3136d2e8e862e941f07886ba69fe84564fbfefc49361dbce9e1ca513e92e::market::Market, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: u64, arg4: u64, arg5: 0x1::string::String, arg6: &0x2::clock::Clock, arg7: &0xbc5b3136d2e8e862e941f07886ba69fe84564fbfefc49361dbce9e1ca513e92e::versioned::Versioned, arg8: &mut 0x2::tx_context::TxContext) : (0xbc5b3136d2e8e862e941f07886ba69fe84564fbfefc49361dbce9e1ca513e92e::position::PositionCap, 0xbc5b3136d2e8e862e941f07886ba69fe84564fbfefc49361dbce9e1ca513e92e::context::MarginTradingContext) {
        0xbc5b3136d2e8e862e941f07886ba69fe84564fbfefc49361dbce9e1ca513e92e::versioned::check_version(arg7);
        0xbc5b3136d2e8e862e941f07886ba69fe84564fbfefc49361dbce9e1ca513e92e::config::check_open_permission(arg0);
        0xbc5b3136d2e8e862e941f07886ba69fe84564fbfefc49361dbce9e1ca513e92e::market::check_open_permission(arg1);
        0xbc5b3136d2e8e862e941f07886ba69fe84564fbfefc49361dbce9e1ca513e92e::market::assert_leverage_valid(arg1, arg4, true);
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        let v1 = 0xbc5b3136d2e8e862e941f07886ba69fe84564fbfefc49361dbce9e1ca513e92e::market::base_token(arg1);
        let v2 = 0xbc5b3136d2e8e862e941f07886ba69fe84564fbfefc49361dbce9e1ca513e92e::market::quote_token(arg1);
        assert!(v0 == v1 || v0 == v2, 0xbc5b3136d2e8e862e941f07886ba69fe84564fbfefc49361dbce9e1ca513e92e::errors::err_invalid_deposit_type());
        let (v3, v4, v5) = if (v0 == v1) {
            (true, v1, v2)
        } else {
            (false, v2, v1)
        };
        let v6 = 0xbc5b3136d2e8e862e941f07886ba69fe84564fbfefc49361dbce9e1ca513e92e::position::create_position<T0>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::create_obligation<T0>(arg2, arg8), v3, 0x2::object::id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>>(arg2), 0x2::object::id<0xbc5b3136d2e8e862e941f07886ba69fe84564fbfefc49361dbce9e1ca513e92e::market::Market>(arg1), arg6, arg8);
        let v7 = 0xbc5b3136d2e8e862e941f07886ba69fe84564fbfefc49361dbce9e1ca513e92e::position::new_position_cap(0x2::object::id<0xbc5b3136d2e8e862e941f07886ba69fe84564fbfefc49361dbce9e1ca513e92e::position::Position<T0>>(&v6), arg8);
        let v8 = create_margin_trading_context(arg5, arg1, &v7, 0x1::string::utf8(b"open_position"), 0x1::string::from_ascii(0x1::type_name::into_string(v0)), arg3, arg8);
        0xbc5b3136d2e8e862e941f07886ba69fe84564fbfefc49361dbce9e1ca513e92e::position::emit_open_position_event<T0>(&v8, &v6, arg4, v4, v5, arg6);
        0xbc5b3136d2e8e862e941f07886ba69fe84564fbfefc49361dbce9e1ca513e92e::market::add_position_into_position_holder<T0>(arg1, v6);
        (v7, v8)
    }

    public fun repay<T0, T1>(arg0: &0xbc5b3136d2e8e862e941f07886ba69fe84564fbfefc49361dbce9e1ca513e92e::context::MarginTradingContext, arg1: &0xbc5b3136d2e8e862e941f07886ba69fe84564fbfefc49361dbce9e1ca513e92e::config::GlobalConfig, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: &mut 0xbc5b3136d2e8e862e941f07886ba69fe84564fbfefc49361dbce9e1ca513e92e::market::Market, arg4: &0xbc5b3136d2e8e862e941f07886ba69fe84564fbfefc49361dbce9e1ca513e92e::position::PositionCap, arg5: &mut 0x2::coin::Coin<T1>, arg6: u64, arg7: &0x2::clock::Clock, arg8: &0xbc5b3136d2e8e862e941f07886ba69fe84564fbfefc49361dbce9e1ca513e92e::versioned::Versioned, arg9: &mut 0x2::tx_context::TxContext) {
        0xbc5b3136d2e8e862e941f07886ba69fe84564fbfefc49361dbce9e1ca513e92e::versioned::check_version(arg8);
        0xbc5b3136d2e8e862e941f07886ba69fe84564fbfefc49361dbce9e1ca513e92e::config::check_repay_permission(arg1);
        0xbc5b3136d2e8e862e941f07886ba69fe84564fbfefc49361dbce9e1ca513e92e::market::check_repay_permission(arg3);
        let v0 = 0xbc5b3136d2e8e862e941f07886ba69fe84564fbfefc49361dbce9e1ca513e92e::market::borrow_mut_position<T0>(arg3, 0xbc5b3136d2e8e862e941f07886ba69fe84564fbfefc49361dbce9e1ca513e92e::position::position_id(arg4));
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::repay<T0, T1>(arg2, arg6, 0xbc5b3136d2e8e862e941f07886ba69fe84564fbfefc49361dbce9e1ca513e92e::position::obligation_id<T0>(v0), arg7, arg5, arg9);
        0xbc5b3136d2e8e862e941f07886ba69fe84564fbfefc49361dbce9e1ca513e92e::position::emit_repay_event<T0, T1>(arg0, v0, 0x2::coin::value<T1>(arg5) - 0x2::coin::value<T1>(arg5), arg7);
    }

    public fun withdraw_not_sui<T0, T1>(arg0: &0xbc5b3136d2e8e862e941f07886ba69fe84564fbfefc49361dbce9e1ca513e92e::context::MarginTradingContext, arg1: &0xbc5b3136d2e8e862e941f07886ba69fe84564fbfefc49361dbce9e1ca513e92e::config::GlobalConfig, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: &mut 0xbc5b3136d2e8e862e941f07886ba69fe84564fbfefc49361dbce9e1ca513e92e::market::Market, arg4: &0xbc5b3136d2e8e862e941f07886ba69fe84564fbfefc49361dbce9e1ca513e92e::position::PositionCap, arg5: 0x1::option::Option<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, T1>>, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &0xbc5b3136d2e8e862e941f07886ba69fe84564fbfefc49361dbce9e1ca513e92e::versioned::Versioned, arg10: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xbc5b3136d2e8e862e941f07886ba69fe84564fbfefc49361dbce9e1ca513e92e::versioned::check_version(arg9);
        0xbc5b3136d2e8e862e941f07886ba69fe84564fbfefc49361dbce9e1ca513e92e::config::check_withdraw_permission(arg1);
        0xbc5b3136d2e8e862e941f07886ba69fe84564fbfefc49361dbce9e1ca513e92e::market::check_withdraw_permission(arg3);
        assert!(arg6 > 0, 0xbc5b3136d2e8e862e941f07886ba69fe84564fbfefc49361dbce9e1ca513e92e::errors::err_insufficient_collateral());
        let v0 = 0xbc5b3136d2e8e862e941f07886ba69fe84564fbfefc49361dbce9e1ca513e92e::market::borrow_mut_position<T0>(arg3, 0xbc5b3136d2e8e862e941f07886ba69fe84564fbfefc49361dbce9e1ca513e92e::position::position_id(arg4));
        let v1 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity<T0, T1>(arg2, arg7, arg8, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::withdraw_ctokens<T0, T1>(arg2, arg7, 0xbc5b3136d2e8e862e941f07886ba69fe84564fbfefc49361dbce9e1ca513e92e::position::obligation_owner_cap<T0>(v0), arg8, arg6, arg10), arg5, arg10);
        let v2 = 0x2::coin::into_balance<T1>(v1);
        0xbc5b3136d2e8e862e941f07886ba69fe84564fbfefc49361dbce9e1ca513e92e::position::emit_withdraw_event<T0, T1>(arg0, v0, 0x2::balance::value<T1>(&v2), arg8);
        0xbc5b3136d2e8e862e941f07886ba69fe84564fbfefc49361dbce9e1ca513e92e::market::join_fee<T1>(arg3, 0x2::balance::split<T1>(&mut v2, calculate_fee(0xbc5b3136d2e8e862e941f07886ba69fe84564fbfefc49361dbce9e1ca513e92e::market::close_fee_rate(arg3), 1000000, 0x2::coin::value<T1>(&v1))), 0xbc5b3136d2e8e862e941f07886ba69fe84564fbfefc49361dbce9e1ca513e92e::position::is_long<T0>(v0));
        0x2::coin::from_balance<T1>(v2, arg10)
    }

    public fun withdraw_sui<T0>(arg0: &0xbc5b3136d2e8e862e941f07886ba69fe84564fbfefc49361dbce9e1ca513e92e::context::MarginTradingContext, arg1: &0xbc5b3136d2e8e862e941f07886ba69fe84564fbfefc49361dbce9e1ca513e92e::config::GlobalConfig, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: &mut 0xbc5b3136d2e8e862e941f07886ba69fe84564fbfefc49361dbce9e1ca513e92e::market::Market, arg4: &0xbc5b3136d2e8e862e941f07886ba69fe84564fbfefc49361dbce9e1ca513e92e::position::PositionCap, arg5: 0x1::option::Option<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, 0x2::sui::SUI>>, arg6: u64, arg7: u64, arg8: &mut 0x3::sui_system::SuiSystemState, arg9: &0x2::clock::Clock, arg10: &0xbc5b3136d2e8e862e941f07886ba69fe84564fbfefc49361dbce9e1ca513e92e::versioned::Versioned, arg11: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0xbc5b3136d2e8e862e941f07886ba69fe84564fbfefc49361dbce9e1ca513e92e::versioned::check_version(arg10);
        0xbc5b3136d2e8e862e941f07886ba69fe84564fbfefc49361dbce9e1ca513e92e::config::check_withdraw_permission(arg1);
        0xbc5b3136d2e8e862e941f07886ba69fe84564fbfefc49361dbce9e1ca513e92e::market::check_withdraw_permission(arg3);
        assert!(arg6 > 0, 0xbc5b3136d2e8e862e941f07886ba69fe84564fbfefc49361dbce9e1ca513e92e::errors::err_insufficient_collateral());
        let v0 = 0xbc5b3136d2e8e862e941f07886ba69fe84564fbfefc49361dbce9e1ca513e92e::market::borrow_mut_position<T0>(arg3, 0xbc5b3136d2e8e862e941f07886ba69fe84564fbfefc49361dbce9e1ca513e92e::position::position_id(arg4));
        let v1 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity_request<T0, 0x2::sui::SUI>(arg2, arg7, arg9, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::withdraw_ctokens<T0, 0x2::sui::SUI>(arg2, arg7, 0xbc5b3136d2e8e862e941f07886ba69fe84564fbfefc49361dbce9e1ca513e92e::position::obligation_owner_cap<T0>(v0), arg9, arg6, arg11), arg5, arg11);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::unstake_sui_from_staker<T0>(arg2, arg7, &v1, arg8, arg11);
        let v2 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::fulfill_liquidity_request<T0, 0x2::sui::SUI>(arg2, arg7, v1, arg11);
        let v3 = 0x2::coin::into_balance<0x2::sui::SUI>(v2);
        0xbc5b3136d2e8e862e941f07886ba69fe84564fbfefc49361dbce9e1ca513e92e::position::emit_withdraw_event<T0, 0x2::sui::SUI>(arg0, v0, 0x2::balance::value<0x2::sui::SUI>(&v3), arg9);
        0xbc5b3136d2e8e862e941f07886ba69fe84564fbfefc49361dbce9e1ca513e92e::market::join_fee<0x2::sui::SUI>(arg3, 0x2::balance::split<0x2::sui::SUI>(&mut v3, calculate_fee(0xbc5b3136d2e8e862e941f07886ba69fe84564fbfefc49361dbce9e1ca513e92e::market::close_fee_rate(arg3), 1000000, 0x2::coin::value<0x2::sui::SUI>(&v2))), 0xbc5b3136d2e8e862e941f07886ba69fe84564fbfefc49361dbce9e1ca513e92e::position::is_long<T0>(v0));
        0x2::coin::from_balance<0x2::sui::SUI>(v3, arg11)
    }

    // decompiled from Move bytecode v6
}

