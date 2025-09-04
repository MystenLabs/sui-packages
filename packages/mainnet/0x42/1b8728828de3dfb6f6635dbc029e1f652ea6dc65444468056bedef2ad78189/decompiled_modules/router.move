module 0x421b8728828de3dfb6f6635dbc029e1f652ea6dc65444468056bedef2ad78189::router {
    public fun borrow_not_sui<T0, T1>(arg0: &0x421b8728828de3dfb6f6635dbc029e1f652ea6dc65444468056bedef2ad78189::config::GlobalConfig, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &0x421b8728828de3dfb6f6635dbc029e1f652ea6dc65444468056bedef2ad78189::market::Market, arg3: &0x421b8728828de3dfb6f6635dbc029e1f652ea6dc65444468056bedef2ad78189::position::PositionCap, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x421b8728828de3dfb6f6635dbc029e1f652ea6dc65444468056bedef2ad78189::config::assert_package_version(arg0);
        let v0 = 0x421b8728828de3dfb6f6635dbc029e1f652ea6dc65444468056bedef2ad78189::market::borrow_position<T0>(arg2, 0x421b8728828de3dfb6f6635dbc029e1f652ea6dc65444468056bedef2ad78189::position::position_id(arg3));
        0x421b8728828de3dfb6f6635dbc029e1f652ea6dc65444468056bedef2ad78189::position::emit_borrow_event<T0, T1>(v0, arg5, arg6);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::borrow<T0, T1>(arg1, arg4, 0x421b8728828de3dfb6f6635dbc029e1f652ea6dc65444468056bedef2ad78189::position::obligation_owner_cap<T0>(v0), arg6, arg5, arg7)
    }

    public fun borrow_sui<T0>(arg0: &0x421b8728828de3dfb6f6635dbc029e1f652ea6dc65444468056bedef2ad78189::config::GlobalConfig, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &0x421b8728828de3dfb6f6635dbc029e1f652ea6dc65444468056bedef2ad78189::market::Market, arg3: &0x421b8728828de3dfb6f6635dbc029e1f652ea6dc65444468056bedef2ad78189::position::PositionCap, arg4: u64, arg5: u64, arg6: &mut 0x3::sui_system::SuiSystemState, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x421b8728828de3dfb6f6635dbc029e1f652ea6dc65444468056bedef2ad78189::config::assert_package_version(arg0);
        let v0 = 0x421b8728828de3dfb6f6635dbc029e1f652ea6dc65444468056bedef2ad78189::market::borrow_position<T0>(arg2, 0x421b8728828de3dfb6f6635dbc029e1f652ea6dc65444468056bedef2ad78189::position::position_id(arg3));
        let v1 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::borrow_request<T0, 0x2::sui::SUI>(arg1, arg4, 0x421b8728828de3dfb6f6635dbc029e1f652ea6dc65444468056bedef2ad78189::position::obligation_owner_cap<T0>(v0), arg7, arg5);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::unstake_sui_from_staker<T0>(arg1, arg4, &v1, arg6, arg8);
        0x421b8728828de3dfb6f6635dbc029e1f652ea6dc65444468056bedef2ad78189::position::emit_borrow_event<T0, 0x2::sui::SUI>(v0, arg5, arg7);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::fulfill_liquidity_request<T0, 0x2::sui::SUI>(arg1, arg4, v1, arg8)
    }

    public fun calculate_fee(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg0 < arg1, 0x421b8728828de3dfb6f6635dbc029e1f652ea6dc65444468056bedef2ad78189::errors::err_invalid_fee_rate());
        (((arg2 as u128) * (arg0 as u128) / (arg1 as u128)) as u64)
    }

    public fun close_position<T0>(arg0: &0x421b8728828de3dfb6f6635dbc029e1f652ea6dc65444468056bedef2ad78189::config::GlobalConfig, arg1: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &mut 0x421b8728828de3dfb6f6635dbc029e1f652ea6dc65444468056bedef2ad78189::market::Market, arg3: 0x421b8728828de3dfb6f6635dbc029e1f652ea6dc65444468056bedef2ad78189::position::PositionCap, arg4: &0x2::clock::Clock) {
        0x421b8728828de3dfb6f6635dbc029e1f652ea6dc65444468056bedef2ad78189::config::assert_package_version(arg0);
        0x421b8728828de3dfb6f6635dbc029e1f652ea6dc65444468056bedef2ad78189::config::assert_global_close_not_paused(arg0);
        0x421b8728828de3dfb6f6635dbc029e1f652ea6dc65444468056bedef2ad78189::market::assert_close_not_paused(arg2);
        let v0 = 0x421b8728828de3dfb6f6635dbc029e1f652ea6dc65444468056bedef2ad78189::market::remove_position_from_position_holder<T0>(arg2, 0x421b8728828de3dfb6f6635dbc029e1f652ea6dc65444468056bedef2ad78189::position::position_id(&arg3));
        0x421b8728828de3dfb6f6635dbc029e1f652ea6dc65444468056bedef2ad78189::position::emit_close_position_event<T0>(&v0, arg4);
        let v1 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation<T0>(arg1, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation_id<T0>(0x421b8728828de3dfb6f6635dbc029e1f652ea6dc65444468056bedef2ad78189::position::obligation_owner_cap<T0>(&v0)));
        assert!(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::allowed_borrow_value_usd<T0>(v1) == 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(0), 0x421b8728828de3dfb6f6635dbc029e1f652ea6dc65444468056bedef2ad78189::errors::err_position_balance_not_zero());
        assert!(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::deposited_value_usd<T0>(v1) == 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(0), 0x421b8728828de3dfb6f6635dbc029e1f652ea6dc65444468056bedef2ad78189::errors::err_position_balance_not_zero());
        0x421b8728828de3dfb6f6635dbc029e1f652ea6dc65444468056bedef2ad78189::position::destroy_position<T0>(v0, arg0);
        0x421b8728828de3dfb6f6635dbc029e1f652ea6dc65444468056bedef2ad78189::position::destroy_position_cap(arg3);
    }

    public fun deposit<T0, T1>(arg0: &0x421b8728828de3dfb6f6635dbc029e1f652ea6dc65444468056bedef2ad78189::config::GlobalConfig, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &mut 0x421b8728828de3dfb6f6635dbc029e1f652ea6dc65444468056bedef2ad78189::market::Market, arg3: &0x421b8728828de3dfb6f6635dbc029e1f652ea6dc65444468056bedef2ad78189::position::PositionCap, arg4: 0x2::coin::Coin<T1>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x421b8728828de3dfb6f6635dbc029e1f652ea6dc65444468056bedef2ad78189::config::assert_package_version(arg0);
        let v0 = 0x421b8728828de3dfb6f6635dbc029e1f652ea6dc65444468056bedef2ad78189::market::borrow_mut_position<T0>(arg2, 0x421b8728828de3dfb6f6635dbc029e1f652ea6dc65444468056bedef2ad78189::position::position_id(arg3));
        let v1 = 0x2::coin::into_balance<T1>(arg4);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_ctokens_into_obligation<T0, T1>(arg1, arg5, 0x421b8728828de3dfb6f6635dbc029e1f652ea6dc65444468056bedef2ad78189::position::obligation_owner_cap<T0>(v0), arg6, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_liquidity_and_mint_ctokens<T0, T1>(arg1, arg5, arg6, 0x2::coin::from_balance<T1>(v1, arg7), arg7), arg7);
        0x421b8728828de3dfb6f6635dbc029e1f652ea6dc65444468056bedef2ad78189::position::emit_deposit_event<T0, T1>(v0, 0x2::balance::value<T1>(&v1), arg6);
        0x421b8728828de3dfb6f6635dbc029e1f652ea6dc65444468056bedef2ad78189::market::join_fee<T1>(arg2, 0x2::balance::split<T1>(&mut v1, calculate_fee(0x421b8728828de3dfb6f6635dbc029e1f652ea6dc65444468056bedef2ad78189::market::open_fee_rate(arg2), 1000000, 0x2::coin::value<T1>(&arg4))), 0x421b8728828de3dfb6f6635dbc029e1f652ea6dc65444468056bedef2ad78189::position::is_long<T0>(v0));
    }

    public fun open_position<T0, T1>(arg0: &0x421b8728828de3dfb6f6635dbc029e1f652ea6dc65444468056bedef2ad78189::config::GlobalConfig, arg1: &mut 0x421b8728828de3dfb6f6635dbc029e1f652ea6dc65444468056bedef2ad78189::market::Market, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x421b8728828de3dfb6f6635dbc029e1f652ea6dc65444468056bedef2ad78189::position::PositionCap {
        0x421b8728828de3dfb6f6635dbc029e1f652ea6dc65444468056bedef2ad78189::config::assert_package_version(arg0);
        0x421b8728828de3dfb6f6635dbc029e1f652ea6dc65444468056bedef2ad78189::config::assert_global_open_not_paused(arg0);
        0x421b8728828de3dfb6f6635dbc029e1f652ea6dc65444468056bedef2ad78189::market::assert_open_not_paused(arg1);
        0x421b8728828de3dfb6f6635dbc029e1f652ea6dc65444468056bedef2ad78189::market::assert_leverage_valid(arg1, arg4, true);
        let v0 = 0x1::type_name::get<T1>();
        let v1 = 0x421b8728828de3dfb6f6635dbc029e1f652ea6dc65444468056bedef2ad78189::market::base_token(arg1);
        let v2 = 0x421b8728828de3dfb6f6635dbc029e1f652ea6dc65444468056bedef2ad78189::market::quote_token(arg1);
        assert!(v0 == v1 || v0 == v2, 0x421b8728828de3dfb6f6635dbc029e1f652ea6dc65444468056bedef2ad78189::errors::err_invalid_deposit_type());
        let (v3, v4, v5) = if (v0 == v1) {
            (true, v1, v2)
        } else {
            (false, v2, v1)
        };
        let v6 = 0x421b8728828de3dfb6f6635dbc029e1f652ea6dc65444468056bedef2ad78189::position::create_position<T0>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::create_obligation<T0>(arg2, arg6), arg3, v3, 0x2::object::id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>>(arg2), 0x2::object::id<0x421b8728828de3dfb6f6635dbc029e1f652ea6dc65444468056bedef2ad78189::market::Market>(arg1), arg5, arg6);
        0x421b8728828de3dfb6f6635dbc029e1f652ea6dc65444468056bedef2ad78189::position::emit_open_position_event<T0>(&v6, arg4, v4, v5, arg5);
        0x421b8728828de3dfb6f6635dbc029e1f652ea6dc65444468056bedef2ad78189::market::add_position_into_position_holder<T0>(arg1, v6);
        0x421b8728828de3dfb6f6635dbc029e1f652ea6dc65444468056bedef2ad78189::position::new_position_cap(0x2::object::id<0x421b8728828de3dfb6f6635dbc029e1f652ea6dc65444468056bedef2ad78189::position::Position<T0>>(&v6), arg6)
    }

    public fun repay<T0, T1>(arg0: &0x421b8728828de3dfb6f6635dbc029e1f652ea6dc65444468056bedef2ad78189::config::GlobalConfig, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &mut 0x421b8728828de3dfb6f6635dbc029e1f652ea6dc65444468056bedef2ad78189::market::Market, arg3: &0x421b8728828de3dfb6f6635dbc029e1f652ea6dc65444468056bedef2ad78189::position::PositionCap, arg4: &mut 0x2::coin::Coin<T1>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x421b8728828de3dfb6f6635dbc029e1f652ea6dc65444468056bedef2ad78189::config::assert_package_version(arg0);
        let v0 = 0x421b8728828de3dfb6f6635dbc029e1f652ea6dc65444468056bedef2ad78189::market::borrow_mut_position<T0>(arg2, 0x421b8728828de3dfb6f6635dbc029e1f652ea6dc65444468056bedef2ad78189::position::position_id(arg3));
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::repay<T0, T1>(arg1, arg5, 0x421b8728828de3dfb6f6635dbc029e1f652ea6dc65444468056bedef2ad78189::position::obligation_id<T0>(v0), arg6, arg4, arg7);
        0x421b8728828de3dfb6f6635dbc029e1f652ea6dc65444468056bedef2ad78189::position::emit_repay_event<T0, T1>(v0, 0x2::coin::value<T1>(arg4), arg6);
    }

    public fun withdraw_not_sui<T0, T1>(arg0: &0x421b8728828de3dfb6f6635dbc029e1f652ea6dc65444468056bedef2ad78189::config::GlobalConfig, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &mut 0x421b8728828de3dfb6f6635dbc029e1f652ea6dc65444468056bedef2ad78189::market::Market, arg3: &0x421b8728828de3dfb6f6635dbc029e1f652ea6dc65444468056bedef2ad78189::position::PositionCap, arg4: 0x1::option::Option<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, T1>>, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x421b8728828de3dfb6f6635dbc029e1f652ea6dc65444468056bedef2ad78189::config::assert_package_version(arg0);
        assert!(arg5 > 0, 0x421b8728828de3dfb6f6635dbc029e1f652ea6dc65444468056bedef2ad78189::errors::err_insufficient_collateral());
        let v0 = 0x421b8728828de3dfb6f6635dbc029e1f652ea6dc65444468056bedef2ad78189::market::borrow_mut_position<T0>(arg2, 0x421b8728828de3dfb6f6635dbc029e1f652ea6dc65444468056bedef2ad78189::position::position_id(arg3));
        let v1 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity<T0, T1>(arg1, arg6, arg7, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::withdraw_ctokens<T0, T1>(arg1, arg6, 0x421b8728828de3dfb6f6635dbc029e1f652ea6dc65444468056bedef2ad78189::position::obligation_owner_cap<T0>(v0), arg7, arg5, arg8), arg4, arg8);
        let v2 = 0x2::coin::into_balance<T1>(v1);
        0x421b8728828de3dfb6f6635dbc029e1f652ea6dc65444468056bedef2ad78189::position::emit_withdraw_event<T0, T1>(v0, arg5, arg7);
        0x421b8728828de3dfb6f6635dbc029e1f652ea6dc65444468056bedef2ad78189::market::join_fee<T1>(arg2, 0x2::balance::split<T1>(&mut v2, calculate_fee(0x421b8728828de3dfb6f6635dbc029e1f652ea6dc65444468056bedef2ad78189::market::close_fee_rate(arg2), 1000000, 0x2::coin::value<T1>(&v1))), 0x421b8728828de3dfb6f6635dbc029e1f652ea6dc65444468056bedef2ad78189::position::is_long<T0>(v0));
        0x2::coin::from_balance<T1>(v2, arg8)
    }

    public fun withdraw_sui<T0>(arg0: &0x421b8728828de3dfb6f6635dbc029e1f652ea6dc65444468056bedef2ad78189::config::GlobalConfig, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &mut 0x421b8728828de3dfb6f6635dbc029e1f652ea6dc65444468056bedef2ad78189::market::Market, arg3: &0x421b8728828de3dfb6f6635dbc029e1f652ea6dc65444468056bedef2ad78189::position::PositionCap, arg4: 0x1::option::Option<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, 0x2::sui::SUI>>, arg5: u64, arg6: u64, arg7: &mut 0x3::sui_system::SuiSystemState, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x421b8728828de3dfb6f6635dbc029e1f652ea6dc65444468056bedef2ad78189::config::assert_package_version(arg0);
        assert!(arg5 > 0, 0x421b8728828de3dfb6f6635dbc029e1f652ea6dc65444468056bedef2ad78189::errors::err_insufficient_collateral());
        let v0 = 0x421b8728828de3dfb6f6635dbc029e1f652ea6dc65444468056bedef2ad78189::market::borrow_mut_position<T0>(arg2, 0x421b8728828de3dfb6f6635dbc029e1f652ea6dc65444468056bedef2ad78189::position::position_id(arg3));
        let v1 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity_request<T0, 0x2::sui::SUI>(arg1, arg6, arg8, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::withdraw_ctokens<T0, 0x2::sui::SUI>(arg1, arg6, 0x421b8728828de3dfb6f6635dbc029e1f652ea6dc65444468056bedef2ad78189::position::obligation_owner_cap<T0>(v0), arg8, arg5, arg9), arg4, arg9);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::unstake_sui_from_staker<T0>(arg1, arg6, &v1, arg7, arg9);
        let v2 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::fulfill_liquidity_request<T0, 0x2::sui::SUI>(arg1, arg6, v1, arg9);
        let v3 = 0x2::coin::into_balance<0x2::sui::SUI>(v2);
        0x421b8728828de3dfb6f6635dbc029e1f652ea6dc65444468056bedef2ad78189::position::emit_withdraw_event<T0, 0x2::sui::SUI>(v0, arg5, arg8);
        0x421b8728828de3dfb6f6635dbc029e1f652ea6dc65444468056bedef2ad78189::market::join_fee<0x2::sui::SUI>(arg2, 0x2::balance::split<0x2::sui::SUI>(&mut v3, calculate_fee(0x421b8728828de3dfb6f6635dbc029e1f652ea6dc65444468056bedef2ad78189::market::close_fee_rate(arg2), 1000000, 0x2::coin::value<0x2::sui::SUI>(&v2))), 0x421b8728828de3dfb6f6635dbc029e1f652ea6dc65444468056bedef2ad78189::position::is_long<T0>(v0));
        0x2::coin::from_balance<0x2::sui::SUI>(v3, arg9)
    }

    // decompiled from Move bytecode v6
}

