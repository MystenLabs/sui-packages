module 0xa1265373a081c3529c303a727118205b6a766843fcefa9ffc6d3463b2a7a3117::position {
    struct Position<phantom T0, phantom T1, phantom T2> has store, key {
        id: 0x2::object::UID,
        deposit_token: 0x1::type_name::TypeName,
        init_deposit_token_amount: u64,
        is_long: bool,
        obligation_owner_cap: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>,
        collateral_ctokens_base: 0x2::balance::Balance<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T1>>,
        collateral_ctokens_quote: 0x2::balance::Balance<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T2>>,
        borrowed_amount_base: u64,
        borrowed_amount_quote: u64,
        created_ts: u64,
        owner: address,
        cetus_pool_id: 0x2::object::ID,
        lending_market_id: 0x2::object::ID,
        base_reserve_array_index: u64,
        quote_reserve_array_index: u64,
    }

    struct OpenPositionEvent has copy, drop {
        position_id: 0x2::object::ID,
        market_id: 0x2::object::ID,
        init_collateral: u64,
        suilend_collateral_amount: u64,
        leverage: u64,
        is_long: bool,
        owner: address,
        timestamp: u64,
    }

    struct ClosePositionEvent has copy, drop {
        position_id: 0x2::object::ID,
        market_id: 0x2::object::ID,
        collateral_returned: u64,
        debt_repaid: u64,
        pnl: u64,
        owner: address,
        timestamp: u64,
    }

    struct LiquidateEvent has copy, drop {
        position_id: 0x2::object::ID,
        market_id: 0x2::object::ID,
        liquidator: address,
        owner: address,
        reward_amount: u64,
        timestamp: u64,
    }

    public fun close_long<T0, T1, T2>(arg0: Position<T0, T1, T2>, arg1: &mut 0xa1265373a081c3529c303a727118205b6a766843fcefa9ffc6d3463b2a7a3117::market::Market<T1, T2>, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(arg0.owner == 0x2::tx_context::sender(arg4), 0xa1265373a081c3529c303a727118205b6a766843fcefa9ffc6d3463b2a7a3117::errors::err_not_owner());
        assert!(arg0.is_long, 0xa1265373a081c3529c303a727118205b6a766843fcefa9ffc6d3463b2a7a3117::errors::err_invalid_position_type());
        let v0 = 0x2::object::uid_to_inner(&arg0.id);
        let Position {
            id                        : v1,
            deposit_token             : _,
            init_deposit_token_amount : _,
            is_long                   : _,
            obligation_owner_cap      : v5,
            collateral_ctokens_base   : v6,
            collateral_ctokens_quote  : v7,
            borrowed_amount_base      : _,
            borrowed_amount_quote     : v9,
            created_ts                : _,
            owner                     : v11,
            cetus_pool_id             : _,
            lending_market_id         : _,
            base_reserve_array_index  : v14,
            quote_reserve_array_index : _,
        } = arg0;
        let v16 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity<T0, T1>(arg2, v14, arg3, 0x2::coin::from_balance<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T1>>(v6, arg4), 0x1::option::none<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, T1>>(), arg4);
        0x2::balance::destroy_zero<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T2>>(v7);
        let v17 = ClosePositionEvent{
            position_id         : v0,
            market_id           : 0xa1265373a081c3529c303a727118205b6a766843fcefa9ffc6d3463b2a7a3117::market::get_market_id<T1, T2>(arg1),
            collateral_returned : 0x2::coin::value<T1>(&v16),
            debt_repaid         : v9,
            pnl                 : 0,
            owner               : v11,
            timestamp           : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<ClosePositionEvent>(v17);
        0x2::object::delete(v1);
        0x2::transfer::public_transfer<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>>(v5, v11);
        0xa1265373a081c3529c303a727118205b6a766843fcefa9ffc6d3463b2a7a3117::market::remove_position_info<T1, T2>(arg1, v0);
        v16
    }

    public fun close_short<T0, T1, T2>(arg0: Position<T0, T1, T2>, arg1: &mut 0xa1265373a081c3529c303a727118205b6a766843fcefa9ffc6d3463b2a7a3117::market::Market<T1, T2>, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        assert!(arg0.owner == 0x2::tx_context::sender(arg4), 0xa1265373a081c3529c303a727118205b6a766843fcefa9ffc6d3463b2a7a3117::errors::err_not_owner());
        assert!(!arg0.is_long, 0xa1265373a081c3529c303a727118205b6a766843fcefa9ffc6d3463b2a7a3117::errors::err_invalid_position_type());
        let v0 = 0x2::object::uid_to_inner(&arg0.id);
        let Position {
            id                        : v1,
            deposit_token             : _,
            init_deposit_token_amount : _,
            is_long                   : _,
            obligation_owner_cap      : v5,
            collateral_ctokens_base   : v6,
            collateral_ctokens_quote  : v7,
            borrowed_amount_base      : v8,
            borrowed_amount_quote     : _,
            created_ts                : _,
            owner                     : v11,
            cetus_pool_id             : _,
            lending_market_id         : _,
            base_reserve_array_index  : _,
            quote_reserve_array_index : v15,
        } = arg0;
        let v16 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity<T0, T2>(arg2, v15, arg3, 0x2::coin::from_balance<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T2>>(v7, arg4), 0x1::option::none<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, T2>>(), arg4);
        0x2::balance::destroy_zero<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T1>>(v6);
        let v17 = ClosePositionEvent{
            position_id         : v0,
            market_id           : 0xa1265373a081c3529c303a727118205b6a766843fcefa9ffc6d3463b2a7a3117::market::get_market_id<T1, T2>(arg1),
            collateral_returned : 0x2::coin::value<T2>(&v16),
            debt_repaid         : v8,
            pnl                 : 0,
            owner               : v11,
            timestamp           : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<ClosePositionEvent>(v17);
        0x2::object::delete(v1);
        0x2::transfer::public_transfer<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>>(v5, v11);
        0xa1265373a081c3529c303a727118205b6a766843fcefa9ffc6d3463b2a7a3117::market::remove_position_info<T1, T2>(arg1, v0);
        v16
    }

    public fun get_borrowed_amounts<T0, T1, T2>(arg0: &Position<T0, T1, T2>) : (u64, u64) {
        (arg0.borrowed_amount_base, arg0.borrowed_amount_quote)
    }

    public fun get_init_collateral_amount<T0, T1, T2>(arg0: &Position<T0, T1, T2>) : u64 {
        arg0.init_deposit_token_amount
    }

    public fun get_obligation_owner_cap<T0, T1, T2>(arg0: &Position<T0, T1, T2>) : &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0> {
        &arg0.obligation_owner_cap
    }

    public fun get_position_created_time<T0, T1, T2>(arg0: &Position<T0, T1, T2>) : u64 {
        arg0.created_ts
    }

    public fun get_position_owner<T0, T1, T2>(arg0: &Position<T0, T1, T2>) : address {
        arg0.owner
    }

    public fun is_long_position<T0, T1, T2>(arg0: &Position<T0, T1, T2>) : bool {
        arg0.is_long
    }

    public fun open_long<T0, T1, T2>(arg0: 0x2::coin::Coin<T1>, arg1: u64, arg2: &0xa1265373a081c3529c303a727118205b6a766843fcefa9ffc6d3463b2a7a3117::config::GlobalConfig, arg3: &mut 0xa1265373a081c3529c303a727118205b6a766843fcefa9ffc6d3463b2a7a3117::market::Market<T1, T2>, arg4: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg5: u64, arg6: u64, arg7: 0x2::object::ID, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : Position<T0, T1, T2> {
        0xa1265373a081c3529c303a727118205b6a766843fcefa9ffc6d3463b2a7a3117::config::assert_package_version(arg2);
        0xa1265373a081c3529c303a727118205b6a766843fcefa9ffc6d3463b2a7a3117::config::assert_global_long_not_paused(arg2);
        0xa1265373a081c3529c303a727118205b6a766843fcefa9ffc6d3463b2a7a3117::market::assert_long_not_paused<T1, T2>(arg3);
        assert!(arg1 >= 10000, 0xa1265373a081c3529c303a727118205b6a766843fcefa9ffc6d3463b2a7a3117::errors::err_leverage_too_low());
        0xa1265373a081c3529c303a727118205b6a766843fcefa9ffc6d3463b2a7a3117::market::assert_leverage_valid<T1, T2>(arg3, arg1 / 10000, true);
        let v0 = 0x2::coin::value<T1>(&arg0);
        assert!(v0 > 0, 0xa1265373a081c3529c303a727118205b6a766843fcefa9ffc6d3463b2a7a3117::errors::err_insufficient_collateral());
        let v1 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::create_obligation<T0>(arg4, arg9);
        let v2 = v0 * (arg1 - 10000) / 10000;
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::borrow<T0, T2>(arg4, arg6, &v1, arg8, v2, arg9), 0x2::tx_context::sender(arg9));
        let v3 = 0x2::object::new(arg9);
        let v4 = 0x2::object::uid_to_inner(&v3);
        let v5 = Position<T0, T1, T2>{
            id                        : v3,
            deposit_token             : 0x1::type_name::get<T1>(),
            init_deposit_token_amount : v0,
            is_long                   : true,
            obligation_owner_cap      : v1,
            collateral_ctokens_base   : 0x2::coin::into_balance<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T1>>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_liquidity_and_mint_ctokens<T0, T1>(arg4, arg5, arg8, arg0, arg9)),
            collateral_ctokens_quote  : 0x2::balance::zero<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T2>>(),
            borrowed_amount_base      : 0,
            borrowed_amount_quote     : v2,
            created_ts                : 0x2::clock::timestamp_ms(arg8),
            owner                     : 0x2::tx_context::sender(arg9),
            cetus_pool_id             : arg7,
            lending_market_id         : 0x2::object::id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>>(arg4),
            base_reserve_array_index  : arg5,
            quote_reserve_array_index : arg6,
        };
        0xa1265373a081c3529c303a727118205b6a766843fcefa9ffc6d3463b2a7a3117::market::add_position_info<T1, T2>(arg3, 0xa1265373a081c3529c303a727118205b6a766843fcefa9ffc6d3463b2a7a3117::market::create_position_info(v4, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation_id<T0>(&v5.obligation_owner_cap), v0, true));
        let v6 = OpenPositionEvent{
            position_id               : v4,
            market_id                 : 0xa1265373a081c3529c303a727118205b6a766843fcefa9ffc6d3463b2a7a3117::market::get_market_id<T1, T2>(arg3),
            init_collateral           : v0,
            suilend_collateral_amount : v0,
            leverage                  : arg1,
            is_long                   : true,
            owner                     : 0x2::tx_context::sender(arg9),
            timestamp                 : 0x2::clock::timestamp_ms(arg8),
        };
        0x2::event::emit<OpenPositionEvent>(v6);
        v5
    }

    public fun open_short<T0, T1, T2>(arg0: 0x2::coin::Coin<T2>, arg1: u64, arg2: &0xa1265373a081c3529c303a727118205b6a766843fcefa9ffc6d3463b2a7a3117::config::GlobalConfig, arg3: &mut 0xa1265373a081c3529c303a727118205b6a766843fcefa9ffc6d3463b2a7a3117::market::Market<T1, T2>, arg4: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg5: u64, arg6: u64, arg7: 0x2::object::ID, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : Position<T0, T1, T2> {
        0xa1265373a081c3529c303a727118205b6a766843fcefa9ffc6d3463b2a7a3117::config::assert_package_version(arg2);
        0xa1265373a081c3529c303a727118205b6a766843fcefa9ffc6d3463b2a7a3117::config::assert_global_short_not_paused(arg2);
        0xa1265373a081c3529c303a727118205b6a766843fcefa9ffc6d3463b2a7a3117::market::assert_short_not_paused<T1, T2>(arg3);
        assert!(arg1 >= 10000, 0xa1265373a081c3529c303a727118205b6a766843fcefa9ffc6d3463b2a7a3117::errors::err_leverage_too_low());
        0xa1265373a081c3529c303a727118205b6a766843fcefa9ffc6d3463b2a7a3117::market::assert_leverage_valid<T1, T2>(arg3, arg1 / 10000, false);
        let v0 = 0x2::coin::value<T2>(&arg0);
        assert!(v0 > 0, 0xa1265373a081c3529c303a727118205b6a766843fcefa9ffc6d3463b2a7a3117::errors::err_insufficient_collateral());
        let v1 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::create_obligation<T0>(arg4, arg9);
        let v2 = v0 * (arg1 - 10000) / 10000;
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::borrow<T0, T1>(arg4, arg5, &v1, arg8, v2, arg9), 0x2::tx_context::sender(arg9));
        let v3 = 0x2::object::new(arg9);
        let v4 = 0x2::object::uid_to_inner(&v3);
        let v5 = Position<T0, T1, T2>{
            id                        : v3,
            deposit_token             : 0x1::type_name::get<T2>(),
            init_deposit_token_amount : v0,
            is_long                   : false,
            obligation_owner_cap      : v1,
            collateral_ctokens_base   : 0x2::balance::zero<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T1>>(),
            collateral_ctokens_quote  : 0x2::coin::into_balance<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T2>>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_liquidity_and_mint_ctokens<T0, T2>(arg4, arg6, arg8, arg0, arg9)),
            borrowed_amount_base      : v2,
            borrowed_amount_quote     : 0,
            created_ts                : 0x2::clock::timestamp_ms(arg8),
            owner                     : 0x2::tx_context::sender(arg9),
            cetus_pool_id             : arg7,
            lending_market_id         : 0x2::object::id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>>(arg4),
            base_reserve_array_index  : arg5,
            quote_reserve_array_index : arg6,
        };
        0xa1265373a081c3529c303a727118205b6a766843fcefa9ffc6d3463b2a7a3117::market::add_position_info<T1, T2>(arg3, 0xa1265373a081c3529c303a727118205b6a766843fcefa9ffc6d3463b2a7a3117::market::create_position_info(v4, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation_id<T0>(&v5.obligation_owner_cap), v0, false));
        let v6 = OpenPositionEvent{
            position_id               : v4,
            market_id                 : 0xa1265373a081c3529c303a727118205b6a766843fcefa9ffc6d3463b2a7a3117::market::get_market_id<T1, T2>(arg3),
            init_collateral           : v0,
            suilend_collateral_amount : v0,
            leverage                  : arg1,
            is_long                   : false,
            owner                     : 0x2::tx_context::sender(arg9),
            timestamp                 : 0x2::clock::timestamp_ms(arg8),
        };
        0x2::event::emit<OpenPositionEvent>(v6);
        v5
    }

    // decompiled from Move bytecode v6
}

