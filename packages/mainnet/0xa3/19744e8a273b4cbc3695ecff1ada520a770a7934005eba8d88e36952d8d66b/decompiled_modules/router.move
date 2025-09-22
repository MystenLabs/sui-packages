module 0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::router {
    public fun borrow_not_sui<T0, T1>(arg0: &0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::config::GlobalConfig, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::market::Market, arg3: &0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::position::PositionCap, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::versioned::Versioned, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::versioned::check_version(arg7);
        0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::config::check_borrow_permission(arg0);
        0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::market::check_borrow_permission(arg2);
        let v0 = 0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::market::borrow_position<T0>(arg2, 0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::position::position_id(arg3));
        0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::position::emit_borrow_event<T0, T1>(v0, arg5, arg6);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::borrow<T0, T1>(arg1, arg4, 0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::position::obligation_owner_cap<T0>(v0), arg6, arg5, arg8)
    }

    public fun borrow_sui<T0>(arg0: &0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::config::GlobalConfig, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::market::Market, arg3: &0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::position::PositionCap, arg4: u64, arg5: u64, arg6: &mut 0x3::sui_system::SuiSystemState, arg7: &0x2::clock::Clock, arg8: &0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::versioned::Versioned, arg9: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::versioned::check_version(arg8);
        0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::config::check_borrow_permission(arg0);
        0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::market::check_borrow_permission(arg2);
        let v0 = 0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::market::borrow_position<T0>(arg2, 0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::position::position_id(arg3));
        let v1 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::borrow_request<T0, 0x2::sui::SUI>(arg1, arg4, 0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::position::obligation_owner_cap<T0>(v0), arg7, arg5);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::unstake_sui_from_staker<T0>(arg1, arg4, &v1, arg6, arg9);
        0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::position::emit_borrow_event<T0, 0x2::sui::SUI>(v0, arg5, arg7);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::fulfill_liquidity_request<T0, 0x2::sui::SUI>(arg1, arg4, v1, arg9)
    }

    public fun calculate_fee(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg0 < arg1, 0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::errors::err_invalid_fee_rate());
        (((arg2 as u128) * (arg0 as u128) / (arg1 as u128)) as u64)
    }

    public fun close_position<T0>(arg0: &0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::config::GlobalConfig, arg1: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &mut 0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::market::Market, arg3: 0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::position::PositionCap, arg4: &0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::versioned::Versioned, arg5: &0x2::clock::Clock) {
        0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::versioned::check_version(arg4);
        0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::config::check_close_permission(arg0);
        0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::market::check_close_permission(arg2);
        let v0 = 0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::market::remove_position_from_position_holder<T0>(arg2, 0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::position::position_id(&arg3));
        0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::position::emit_close_position_event<T0>(&v0, arg5);
        let v1 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation<T0>(arg1, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation_id<T0>(0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::position::obligation_owner_cap<T0>(&v0)));
        assert!(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::le(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::allowed_borrow_value_usd<T0>(v1), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(1)), 0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::errors::err_position_balance_not_zero());
        assert!(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::le(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::deposited_value_usd<T0>(v1), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(1)), 0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::errors::err_position_balance_not_zero());
        0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::position::destroy_position<T0>(v0, arg0);
        0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::position::destroy_position_cap(arg3);
    }

    public fun deposit<T0, T1>(arg0: &0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::config::GlobalConfig, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &mut 0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::market::Market, arg3: &0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::position::PositionCap, arg4: 0x2::coin::Coin<T1>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::versioned::Versioned, arg8: &mut 0x2::tx_context::TxContext) {
        0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::versioned::check_version(arg7);
        0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::config::check_deposit_permission(arg0);
        0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::market::check_deposit_permission(arg2);
        let v0 = 0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::market::borrow_mut_position<T0>(arg2, 0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::position::position_id(arg3));
        let v1 = 0x2::coin::into_balance<T1>(arg4);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_ctokens_into_obligation<T0, T1>(arg1, arg5, 0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::position::obligation_owner_cap<T0>(v0), arg6, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_liquidity_and_mint_ctokens<T0, T1>(arg1, arg5, arg6, 0x2::coin::from_balance<T1>(v1, arg8), arg8), arg8);
        0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::position::emit_deposit_event<T0, T1>(v0, 0x2::balance::value<T1>(&v1), arg6);
        0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::market::join_fee<T1>(arg2, 0x2::balance::split<T1>(&mut v1, calculate_fee(0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::market::open_fee_rate(arg2), 1000000, 0x2::coin::value<T1>(&arg4))), 0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::position::is_long<T0>(v0));
    }

    public fun open_position<T0, T1>(arg0: &0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::config::GlobalConfig, arg1: &mut 0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::market::Market, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::versioned::Versioned, arg7: &mut 0x2::tx_context::TxContext) : 0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::position::PositionCap {
        0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::versioned::check_version(arg6);
        0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::config::check_open_permission(arg0);
        0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::market::check_open_permission(arg1);
        0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::market::assert_leverage_valid(arg1, arg4, true);
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        let v1 = 0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::market::base_token(arg1);
        let v2 = 0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::market::quote_token(arg1);
        assert!(v0 == v1 || v0 == v2, 0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::errors::err_invalid_deposit_type());
        let (v3, v4, v5) = if (v0 == v1) {
            (true, v1, v2)
        } else {
            (false, v2, v1)
        };
        let v6 = 0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::position::create_position<T0>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::create_obligation<T0>(arg2, arg7), arg3, v3, 0x2::object::id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>>(arg2), 0x2::object::id<0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::market::Market>(arg1), arg5, arg7);
        0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::position::emit_open_position_event<T0>(&v6, arg4, v4, v5, arg5);
        0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::market::add_position_into_position_holder<T0>(arg1, v6);
        0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::position::new_position_cap(0x2::object::id<0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::position::Position<T0>>(&v6), arg7)
    }

    public fun repay<T0, T1>(arg0: &0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::config::GlobalConfig, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &mut 0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::market::Market, arg3: &0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::position::PositionCap, arg4: &mut 0x2::coin::Coin<T1>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::versioned::Versioned, arg8: &mut 0x2::tx_context::TxContext) {
        0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::versioned::check_version(arg7);
        0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::config::check_repay_permission(arg0);
        0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::market::check_repay_permission(arg2);
        let v0 = 0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::market::borrow_mut_position<T0>(arg2, 0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::position::position_id(arg3));
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::repay<T0, T1>(arg1, arg5, 0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::position::obligation_id<T0>(v0), arg6, arg4, arg8);
        0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::position::emit_repay_event<T0, T1>(v0, 0x2::coin::value<T1>(arg4), arg6);
    }

    public fun withdraw_not_sui<T0, T1>(arg0: &0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::config::GlobalConfig, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &mut 0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::market::Market, arg3: &0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::position::PositionCap, arg4: 0x1::option::Option<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, T1>>, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::versioned::Versioned, arg9: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::versioned::check_version(arg8);
        0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::config::check_withdraw_permission(arg0);
        0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::market::check_withdraw_permission(arg2);
        assert!(arg5 > 0, 0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::errors::err_insufficient_collateral());
        let v0 = 0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::market::borrow_mut_position<T0>(arg2, 0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::position::position_id(arg3));
        let v1 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity<T0, T1>(arg1, arg6, arg7, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::withdraw_ctokens<T0, T1>(arg1, arg6, 0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::position::obligation_owner_cap<T0>(v0), arg7, arg5, arg9), arg4, arg9);
        let v2 = 0x2::coin::into_balance<T1>(v1);
        0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::position::emit_withdraw_event<T0, T1>(v0, arg5, arg7);
        0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::market::join_fee<T1>(arg2, 0x2::balance::split<T1>(&mut v2, calculate_fee(0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::market::close_fee_rate(arg2), 1000000, 0x2::coin::value<T1>(&v1))), 0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::position::is_long<T0>(v0));
        0x2::coin::from_balance<T1>(v2, arg9)
    }

    public fun withdraw_sui<T0>(arg0: &0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::config::GlobalConfig, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &mut 0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::market::Market, arg3: &0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::position::PositionCap, arg4: 0x1::option::Option<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, 0x2::sui::SUI>>, arg5: u64, arg6: u64, arg7: &mut 0x3::sui_system::SuiSystemState, arg8: &0x2::clock::Clock, arg9: &0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::versioned::Versioned, arg10: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::versioned::check_version(arg9);
        0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::config::check_withdraw_permission(arg0);
        0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::market::check_withdraw_permission(arg2);
        assert!(arg5 > 0, 0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::errors::err_insufficient_collateral());
        let v0 = 0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::market::borrow_mut_position<T0>(arg2, 0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::position::position_id(arg3));
        let v1 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity_request<T0, 0x2::sui::SUI>(arg1, arg6, arg8, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::withdraw_ctokens<T0, 0x2::sui::SUI>(arg1, arg6, 0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::position::obligation_owner_cap<T0>(v0), arg8, arg5, arg10), arg4, arg10);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::unstake_sui_from_staker<T0>(arg1, arg6, &v1, arg7, arg10);
        let v2 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::fulfill_liquidity_request<T0, 0x2::sui::SUI>(arg1, arg6, v1, arg10);
        let v3 = 0x2::coin::into_balance<0x2::sui::SUI>(v2);
        0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::position::emit_withdraw_event<T0, 0x2::sui::SUI>(v0, arg5, arg8);
        0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::market::join_fee<0x2::sui::SUI>(arg2, 0x2::balance::split<0x2::sui::SUI>(&mut v3, calculate_fee(0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::market::close_fee_rate(arg2), 1000000, 0x2::coin::value<0x2::sui::SUI>(&v2))), 0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::position::is_long<T0>(v0));
        0x2::coin::from_balance<0x2::sui::SUI>(v3, arg10)
    }

    // decompiled from Move bytecode v6
}

