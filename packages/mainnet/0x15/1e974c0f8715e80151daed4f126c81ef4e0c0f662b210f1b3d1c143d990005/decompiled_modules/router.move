module 0xa22caf9b32b759b0bb21a895929c3c07276eed39b0e7e7623058f6014b23e428::router {
    public fun borrow<T0, T1>(arg0: &0xa22caf9b32b759b0bb21a895929c3c07276eed39b0e7e7623058f6014b23e428::config::GlobalConfig, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &0xa22caf9b32b759b0bb21a895929c3c07276eed39b0e7e7623058f6014b23e428::market::Market, arg3: &0xa22caf9b32b759b0bb21a895929c3c07276eed39b0e7e7623058f6014b23e428::position::PositionCap, arg4: u64, arg5: u64, arg6: &mut 0x3::sui_system::SuiSystemState, arg7: &0x2::clock::Clock, arg8: &0xa22caf9b32b759b0bb21a895929c3c07276eed39b0e7e7623058f6014b23e428::versioned::Versioned, arg9: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xa22caf9b32b759b0bb21a895929c3c07276eed39b0e7e7623058f6014b23e428::versioned::check_version(arg8);
        assert!(arg5 > 0, 0xa22caf9b32b759b0bb21a895929c3c07276eed39b0e7e7623058f6014b23e428::errors::err_amount_must_be_positive());
        0xa22caf9b32b759b0bb21a895929c3c07276eed39b0e7e7623058f6014b23e428::config::check_borrow_permission(arg0);
        0xa22caf9b32b759b0bb21a895929c3c07276eed39b0e7e7623058f6014b23e428::market::check_borrow_permission(arg2);
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        assert!(v0 == 0xa22caf9b32b759b0bb21a895929c3c07276eed39b0e7e7623058f6014b23e428::market::base_token(arg2) || v0 == 0xa22caf9b32b759b0bb21a895929c3c07276eed39b0e7e7623058f6014b23e428::market::quote_token(arg2), 0xa22caf9b32b759b0bb21a895929c3c07276eed39b0e7e7623058f6014b23e428::errors::err_invalid_borrow_type());
        let v1 = 0xa22caf9b32b759b0bb21a895929c3c07276eed39b0e7e7623058f6014b23e428::market::borrow_position<T0>(arg2, 0xa22caf9b32b759b0bb21a895929c3c07276eed39b0e7e7623058f6014b23e428::position::position_id(arg3));
        let v2 = if (0x1::type_name::with_defining_ids<T1>() == 0x1::type_name::with_defining_ids<0x2::sui::SUI>()) {
            let v3 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::borrow_request<T0, 0x2::sui::SUI>(arg1, arg4, 0xa22caf9b32b759b0bb21a895929c3c07276eed39b0e7e7623058f6014b23e428::position::obligation_owner_cap<T0>(v1), arg7, arg5);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::unstake_sui_from_staker<T0>(arg1, arg4, &v3, arg6, arg9);
            let v4 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::fulfill_liquidity_request<T0, 0x2::sui::SUI>(arg1, arg4, v3, arg9);
            cast_as_type<0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<T1>>(v4, arg9)
        } else {
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::borrow<T0, T1>(arg1, arg4, 0xa22caf9b32b759b0bb21a895929c3c07276eed39b0e7e7623058f6014b23e428::position::obligation_owner_cap<T0>(v1), arg7, arg5, arg9)
        };
        let v5 = v2;
        0xa22caf9b32b759b0bb21a895929c3c07276eed39b0e7e7623058f6014b23e428::position::emit_borrow_event<T0, T1>(v1, 0x2::coin::value<T1>(&v5), arg7);
        v5
    }

    public fun calculate_fee(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg0 < arg1, 0xa22caf9b32b759b0bb21a895929c3c07276eed39b0e7e7623058f6014b23e428::errors::err_invalid_fee_rate());
        0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u64::mul_div_ceil(arg2, arg0, arg1)
    }

    fun cast_as_type<T0: store, T1: store>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) : T1 {
        let v0 = 0x2::object::new(arg1);
        0x2::dynamic_field::add<bool, T0>(&mut v0, true, arg0);
        0x2::object::delete(v0);
        0x2::dynamic_field::remove<bool, T1>(&mut v0, true)
    }

    public fun claim_rewards<T0, T1>(arg0: &0xa22caf9b32b759b0bb21a895929c3c07276eed39b0e7e7623058f6014b23e428::config::GlobalConfig, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &mut 0xa22caf9b32b759b0bb21a895929c3c07276eed39b0e7e7623058f6014b23e428::market::Market, arg3: &0xa22caf9b32b759b0bb21a895929c3c07276eed39b0e7e7623058f6014b23e428::position::PositionCap, arg4: u64, arg5: u64, arg6: bool, arg7: &0x2::clock::Clock, arg8: &0xa22caf9b32b759b0bb21a895929c3c07276eed39b0e7e7623058f6014b23e428::versioned::Versioned, arg9: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xa22caf9b32b759b0bb21a895929c3c07276eed39b0e7e7623058f6014b23e428::versioned::check_version(arg8);
        0xa22caf9b32b759b0bb21a895929c3c07276eed39b0e7e7623058f6014b23e428::config::check_claim_reward_permission(arg0);
        0xa22caf9b32b759b0bb21a895929c3c07276eed39b0e7e7623058f6014b23e428::market::check_claim_reward_permission(arg2);
        let v0 = 0xa22caf9b32b759b0bb21a895929c3c07276eed39b0e7e7623058f6014b23e428::market::borrow_mut_position<T0>(arg2, 0xa22caf9b32b759b0bb21a895929c3c07276eed39b0e7e7623058f6014b23e428::position::position_id(arg3));
        let v1 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::claim_rewards<T0, T1>(arg1, 0xa22caf9b32b759b0bb21a895929c3c07276eed39b0e7e7623058f6014b23e428::position::obligation_owner_cap<T0>(v0), arg7, arg4, arg5, arg6, arg9);
        0xa22caf9b32b759b0bb21a895929c3c07276eed39b0e7e7623058f6014b23e428::position::emit_claim_reward_event<T0, T1>(v0, 0x2::coin::value<T1>(&v1), arg7);
        v1
    }

    public fun close_position<T0>(arg0: &0xa22caf9b32b759b0bb21a895929c3c07276eed39b0e7e7623058f6014b23e428::config::GlobalConfig, arg1: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &mut 0xa22caf9b32b759b0bb21a895929c3c07276eed39b0e7e7623058f6014b23e428::market::Market, arg3: 0xa22caf9b32b759b0bb21a895929c3c07276eed39b0e7e7623058f6014b23e428::position::PositionCap, arg4: &0x2::clock::Clock, arg5: &0xa22caf9b32b759b0bb21a895929c3c07276eed39b0e7e7623058f6014b23e428::versioned::Versioned) {
        0xa22caf9b32b759b0bb21a895929c3c07276eed39b0e7e7623058f6014b23e428::versioned::check_version(arg5);
        0xa22caf9b32b759b0bb21a895929c3c07276eed39b0e7e7623058f6014b23e428::config::check_close_permission(arg0);
        0xa22caf9b32b759b0bb21a895929c3c07276eed39b0e7e7623058f6014b23e428::market::check_close_permission(arg2);
        let v0 = 0xa22caf9b32b759b0bb21a895929c3c07276eed39b0e7e7623058f6014b23e428::market::remove_position_from_position_holder<T0>(arg2, 0xa22caf9b32b759b0bb21a895929c3c07276eed39b0e7e7623058f6014b23e428::position::position_id(&arg3));
        assert!(0xa22caf9b32b759b0bb21a895929c3c07276eed39b0e7e7623058f6014b23e428::position::market_id<T0>(&v0) == 0x2::object::id<0xa22caf9b32b759b0bb21a895929c3c07276eed39b0e7e7623058f6014b23e428::market::Market>(arg2), 0xa22caf9b32b759b0bb21a895929c3c07276eed39b0e7e7623058f6014b23e428::errors::err_position_market_mismatch());
        assert!(0xa22caf9b32b759b0bb21a895929c3c07276eed39b0e7e7623058f6014b23e428::position::lending_market_id<T0>(&v0) == 0x2::object::id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>>(arg1), 0xa22caf9b32b759b0bb21a895929c3c07276eed39b0e7e7623058f6014b23e428::errors::err_position_lending_market_mismatch());
        0xa22caf9b32b759b0bb21a895929c3c07276eed39b0e7e7623058f6014b23e428::position::emit_close_position_event<T0>(&v0, arg4);
        let v1 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation<T0>(arg1, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation_id<T0>(0xa22caf9b32b759b0bb21a895929c3c07276eed39b0e7e7623058f6014b23e428::position::obligation_owner_cap<T0>(&v0)));
        assert!(0x1::vector::is_empty<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::Deposit>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::deposits<T0>(v1)), 0xa22caf9b32b759b0bb21a895929c3c07276eed39b0e7e7623058f6014b23e428::errors::err_position_balance_not_zero());
        assert!(0x1::vector::is_empty<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::Borrow>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::borrows<T0>(v1)), 0xa22caf9b32b759b0bb21a895929c3c07276eed39b0e7e7623058f6014b23e428::errors::err_position_borrows_not_zero());
        0xa22caf9b32b759b0bb21a895929c3c07276eed39b0e7e7623058f6014b23e428::position::destroy_position<T0>(v0, arg0);
        0xa22caf9b32b759b0bb21a895929c3c07276eed39b0e7e7623058f6014b23e428::position::destroy_position_cap(arg3);
    }

    public fun deposit<T0, T1>(arg0: &0xa22caf9b32b759b0bb21a895929c3c07276eed39b0e7e7623058f6014b23e428::config::GlobalConfig, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &mut 0xa22caf9b32b759b0bb21a895929c3c07276eed39b0e7e7623058f6014b23e428::market::Market, arg3: &0xa22caf9b32b759b0bb21a895929c3c07276eed39b0e7e7623058f6014b23e428::position::PositionCap, arg4: 0x2::coin::Coin<T1>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &0xa22caf9b32b759b0bb21a895929c3c07276eed39b0e7e7623058f6014b23e428::versioned::Versioned, arg8: &mut 0x2::tx_context::TxContext) {
        0xa22caf9b32b759b0bb21a895929c3c07276eed39b0e7e7623058f6014b23e428::versioned::check_version(arg7);
        0xa22caf9b32b759b0bb21a895929c3c07276eed39b0e7e7623058f6014b23e428::config::check_deposit_permission(arg0);
        0xa22caf9b32b759b0bb21a895929c3c07276eed39b0e7e7623058f6014b23e428::market::check_deposit_permission(arg2);
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        assert!(v0 == 0xa22caf9b32b759b0bb21a895929c3c07276eed39b0e7e7623058f6014b23e428::market::base_token(arg2) || v0 == 0xa22caf9b32b759b0bb21a895929c3c07276eed39b0e7e7623058f6014b23e428::market::quote_token(arg2), 0xa22caf9b32b759b0bb21a895929c3c07276eed39b0e7e7623058f6014b23e428::errors::err_invalid_deposit_type());
        let v1 = 0xa22caf9b32b759b0bb21a895929c3c07276eed39b0e7e7623058f6014b23e428::market::borrow_mut_position<T0>(arg2, 0xa22caf9b32b759b0bb21a895929c3c07276eed39b0e7e7623058f6014b23e428::position::position_id(arg3));
        let v2 = 0x2::coin::into_balance<T1>(arg4);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_ctokens_into_obligation<T0, T1>(arg1, arg5, 0xa22caf9b32b759b0bb21a895929c3c07276eed39b0e7e7623058f6014b23e428::position::obligation_owner_cap<T0>(v1), arg6, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_liquidity_and_mint_ctokens<T0, T1>(arg1, arg5, arg6, 0x2::coin::from_balance<T1>(v2, arg8), arg8), arg8);
        0xa22caf9b32b759b0bb21a895929c3c07276eed39b0e7e7623058f6014b23e428::position::emit_deposit_event<T0, T1>(v1, 0x2::balance::value<T1>(&v2), arg6);
        0xa22caf9b32b759b0bb21a895929c3c07276eed39b0e7e7623058f6014b23e428::market::join_fee<T1>(arg2, 0x2::balance::split<T1>(&mut v2, calculate_fee(0xa22caf9b32b759b0bb21a895929c3c07276eed39b0e7e7623058f6014b23e428::market::open_fee_rate(arg2), 1000000, 0x2::coin::value<T1>(&arg4))), 0xa22caf9b32b759b0bb21a895929c3c07276eed39b0e7e7623058f6014b23e428::position::is_long<T0>(v1));
    }

    public fun open_position<T0, T1>(arg0: &0xa22caf9b32b759b0bb21a895929c3c07276eed39b0e7e7623058f6014b23e428::config::GlobalConfig, arg1: &mut 0xa22caf9b32b759b0bb21a895929c3c07276eed39b0e7e7623058f6014b23e428::market::Market, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0xa22caf9b32b759b0bb21a895929c3c07276eed39b0e7e7623058f6014b23e428::versioned::Versioned, arg6: &mut 0x2::tx_context::TxContext) : 0xa22caf9b32b759b0bb21a895929c3c07276eed39b0e7e7623058f6014b23e428::position::PositionCap {
        0xa22caf9b32b759b0bb21a895929c3c07276eed39b0e7e7623058f6014b23e428::versioned::check_version(arg5);
        0xa22caf9b32b759b0bb21a895929c3c07276eed39b0e7e7623058f6014b23e428::config::check_open_permission(arg0);
        0xa22caf9b32b759b0bb21a895929c3c07276eed39b0e7e7623058f6014b23e428::market::check_open_permission(arg1);
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        let v1 = 0xa22caf9b32b759b0bb21a895929c3c07276eed39b0e7e7623058f6014b23e428::market::base_token(arg1);
        let v2 = 0xa22caf9b32b759b0bb21a895929c3c07276eed39b0e7e7623058f6014b23e428::market::quote_token(arg1);
        assert!(v0 == v1 || v0 == v2, 0xa22caf9b32b759b0bb21a895929c3c07276eed39b0e7e7623058f6014b23e428::errors::err_invalid_deposit_type());
        let (v3, v4, v5) = if (v0 == v1) {
            (true, v1, v2)
        } else {
            (false, v2, v1)
        };
        let v6 = 0xa22caf9b32b759b0bb21a895929c3c07276eed39b0e7e7623058f6014b23e428::position::create_position<T0>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::create_obligation<T0>(arg2, arg6), v3, 0x2::object::id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>>(arg2), 0x2::object::id<0xa22caf9b32b759b0bb21a895929c3c07276eed39b0e7e7623058f6014b23e428::market::Market>(arg1), arg4, arg6);
        0xa22caf9b32b759b0bb21a895929c3c07276eed39b0e7e7623058f6014b23e428::position::emit_open_position_event<T0>(&v6, arg3, v4, v5, arg4);
        0xa22caf9b32b759b0bb21a895929c3c07276eed39b0e7e7623058f6014b23e428::market::add_position_into_position_holder<T0>(arg1, v6);
        0xa22caf9b32b759b0bb21a895929c3c07276eed39b0e7e7623058f6014b23e428::position::new_position_cap(0x2::object::id<0xa22caf9b32b759b0bb21a895929c3c07276eed39b0e7e7623058f6014b23e428::position::Position<T0>>(&v6), arg6)
    }

    public fun repay<T0, T1>(arg0: &0xa22caf9b32b759b0bb21a895929c3c07276eed39b0e7e7623058f6014b23e428::config::GlobalConfig, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &mut 0xa22caf9b32b759b0bb21a895929c3c07276eed39b0e7e7623058f6014b23e428::market::Market, arg3: &0xa22caf9b32b759b0bb21a895929c3c07276eed39b0e7e7623058f6014b23e428::position::PositionCap, arg4: &mut 0x2::coin::Coin<T1>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &0xa22caf9b32b759b0bb21a895929c3c07276eed39b0e7e7623058f6014b23e428::versioned::Versioned, arg8: &mut 0x2::tx_context::TxContext) {
        0xa22caf9b32b759b0bb21a895929c3c07276eed39b0e7e7623058f6014b23e428::versioned::check_version(arg7);
        0xa22caf9b32b759b0bb21a895929c3c07276eed39b0e7e7623058f6014b23e428::config::check_repay_permission(arg0);
        0xa22caf9b32b759b0bb21a895929c3c07276eed39b0e7e7623058f6014b23e428::market::check_repay_permission(arg2);
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        assert!(v0 == 0xa22caf9b32b759b0bb21a895929c3c07276eed39b0e7e7623058f6014b23e428::market::base_token(arg2) || v0 == 0xa22caf9b32b759b0bb21a895929c3c07276eed39b0e7e7623058f6014b23e428::market::quote_token(arg2), 0xa22caf9b32b759b0bb21a895929c3c07276eed39b0e7e7623058f6014b23e428::errors::err_invalid_repay_type());
        let v1 = 0xa22caf9b32b759b0bb21a895929c3c07276eed39b0e7e7623058f6014b23e428::market::borrow_mut_position<T0>(arg2, 0xa22caf9b32b759b0bb21a895929c3c07276eed39b0e7e7623058f6014b23e428::position::position_id(arg3));
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::repay<T0, T1>(arg1, arg5, 0xa22caf9b32b759b0bb21a895929c3c07276eed39b0e7e7623058f6014b23e428::position::obligation_id<T0>(v1), arg6, arg4, arg8);
        0xa22caf9b32b759b0bb21a895929c3c07276eed39b0e7e7623058f6014b23e428::position::emit_repay_event<T0, T1>(v1, 0x2::coin::value<T1>(arg4) - 0x2::coin::value<T1>(arg4), arg6);
    }

    public fun withdraw<T0, T1>(arg0: &0xa22caf9b32b759b0bb21a895929c3c07276eed39b0e7e7623058f6014b23e428::config::GlobalConfig, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &mut 0xa22caf9b32b759b0bb21a895929c3c07276eed39b0e7e7623058f6014b23e428::market::Market, arg3: &0xa22caf9b32b759b0bb21a895929c3c07276eed39b0e7e7623058f6014b23e428::position::PositionCap, arg4: 0x1::option::Option<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, T1>>, arg5: u64, arg6: u64, arg7: &mut 0x3::sui_system::SuiSystemState, arg8: &0x2::clock::Clock, arg9: &0xa22caf9b32b759b0bb21a895929c3c07276eed39b0e7e7623058f6014b23e428::versioned::Versioned, arg10: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xa22caf9b32b759b0bb21a895929c3c07276eed39b0e7e7623058f6014b23e428::versioned::check_version(arg9);
        0xa22caf9b32b759b0bb21a895929c3c07276eed39b0e7e7623058f6014b23e428::config::check_withdraw_permission(arg0);
        0xa22caf9b32b759b0bb21a895929c3c07276eed39b0e7e7623058f6014b23e428::market::check_withdraw_permission(arg2);
        assert!(arg5 > 0, 0xa22caf9b32b759b0bb21a895929c3c07276eed39b0e7e7623058f6014b23e428::errors::err_amount_must_be_positive());
        let v0 = 0xa22caf9b32b759b0bb21a895929c3c07276eed39b0e7e7623058f6014b23e428::market::borrow_mut_position<T0>(arg2, 0xa22caf9b32b759b0bb21a895929c3c07276eed39b0e7e7623058f6014b23e428::position::position_id(arg3));
        let v1 = if (0x1::type_name::with_defining_ids<T1>() == 0x1::type_name::with_defining_ids<0x2::sui::SUI>()) {
            0x1::option::destroy_none<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, T1>>(arg4);
            let v2 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity_request<T0, 0x2::sui::SUI>(arg1, arg6, arg8, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::withdraw_ctokens<T0, 0x2::sui::SUI>(arg1, arg6, 0xa22caf9b32b759b0bb21a895929c3c07276eed39b0e7e7623058f6014b23e428::position::obligation_owner_cap<T0>(v0), arg8, arg5, arg10), 0x1::option::none<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, 0x2::sui::SUI>>(), arg10);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::unstake_sui_from_staker<T0>(arg1, arg6, &v2, arg7, arg10);
            let v3 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::fulfill_liquidity_request<T0, 0x2::sui::SUI>(arg1, arg6, v2, arg10);
            cast_as_type<0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<T1>>(v3, arg10)
        } else {
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity<T0, T1>(arg1, arg6, arg8, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::withdraw_ctokens<T0, T1>(arg1, arg6, 0xa22caf9b32b759b0bb21a895929c3c07276eed39b0e7e7623058f6014b23e428::position::obligation_owner_cap<T0>(v0), arg8, arg5, arg10), arg4, arg10)
        };
        let v4 = v1;
        let v5 = 0x2::coin::into_balance<T1>(v4);
        0xa22caf9b32b759b0bb21a895929c3c07276eed39b0e7e7623058f6014b23e428::position::emit_withdraw_event<T0, T1>(v0, 0x2::balance::value<T1>(&v5), arg8);
        0xa22caf9b32b759b0bb21a895929c3c07276eed39b0e7e7623058f6014b23e428::market::join_fee<T1>(arg2, 0x2::balance::split<T1>(&mut v5, calculate_fee(0xa22caf9b32b759b0bb21a895929c3c07276eed39b0e7e7623058f6014b23e428::market::close_fee_rate(arg2), 1000000, 0x2::coin::value<T1>(&v4))), 0xa22caf9b32b759b0bb21a895929c3c07276eed39b0e7e7623058f6014b23e428::position::is_long<T0>(v0));
        0x2::coin::from_balance<T1>(v5, arg10)
    }

    // decompiled from Move bytecode v6
}

