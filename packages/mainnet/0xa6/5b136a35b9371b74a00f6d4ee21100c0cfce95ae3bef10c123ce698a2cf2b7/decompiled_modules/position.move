module 0xa65b136a35b9371b74a00f6d4ee21100c0cfce95ae3bef10c123ce698a2cf2b7::position {
    struct Position<phantom T0> has store, key {
        id: 0x2::object::UID,
        init_deposit_amount: u64,
        is_long: bool,
        obligation_owner_cap: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>,
        created_ts: u64,
        owner: address,
        lending_market_id: 0x2::object::ID,
    }

    struct OpenPositionEvent has copy, drop {
        position_id: 0x2::object::ID,
        market_id: 0x2::object::ID,
        obligation_id: 0x2::object::ID,
        leverage: u64,
        is_long: bool,
        collateral_coin_type: 0x1::type_name::TypeName,
        loan_coin_type: 0x1::type_name::TypeName,
        owner: address,
        timestamp: u64,
    }

    struct ClosePositionEvent has copy, drop {
        position_id: 0x2::object::ID,
        market_id: 0x2::object::ID,
        owner: address,
        timestamp: u64,
    }

    struct DepositEvent has copy, drop {
        position_id: 0x2::object::ID,
        owner: address,
        coin_type: 0x1::type_name::TypeName,
        deposit_amount: u64,
        timestamp: u64,
    }

    struct WithdrawEvent has copy, drop {
        position_id: 0x2::object::ID,
        owner: address,
        coin_type: 0x1::type_name::TypeName,
        withdraw_amount: u64,
        timestamp: u64,
    }

    struct BorrowEvent has copy, drop {
        position_id: 0x2::object::ID,
        owner: address,
        coin_type: 0x1::type_name::TypeName,
        borrow_amount: u64,
        timestamp: u64,
    }

    struct RepayEvent has copy, drop {
        position_id: 0x2::object::ID,
        owner: address,
        repay_coin_type: 0x1::type_name::TypeName,
        repay_amount: u64,
        timestamp: u64,
    }

    public fun borrow_not_sui<T0, T1>(arg0: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg1: &Position<T0>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = BorrowEvent{
            position_id   : 0x2::object::id<Position<T0>>(arg1),
            owner         : 0x2::tx_context::sender(arg5),
            coin_type     : 0x1::type_name::get<T1>(),
            borrow_amount : arg3,
            timestamp     : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<BorrowEvent>(v0);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::borrow<T0, T1>(arg0, arg2, &arg1.obligation_owner_cap, arg4, arg3, arg5)
    }

    public fun borrow_sui<T0>(arg0: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg1: &Position<T0>, arg2: u64, arg3: u64, arg4: &mut 0x3::sui_system::SuiSystemState, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::borrow_request<T0, 0x2::sui::SUI>(arg0, arg2, &arg1.obligation_owner_cap, arg5, arg3);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::unstake_sui_from_staker<T0>(arg0, arg2, &v0, arg4, arg6);
        let v1 = BorrowEvent{
            position_id   : 0x2::object::id<Position<T0>>(arg1),
            owner         : 0x2::tx_context::sender(arg6),
            coin_type     : 0x1::type_name::get<0x2::sui::SUI>(),
            borrow_amount : arg3,
            timestamp     : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<BorrowEvent>(v1);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::fulfill_liquidity_request<T0, 0x2::sui::SUI>(arg0, arg2, v0, arg6)
    }

    public fun calculate_fee(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg0 < arg1, 0xa65b136a35b9371b74a00f6d4ee21100c0cfce95ae3bef10c123ce698a2cf2b7::errors::err_invalid_fee_rate());
        (((arg2 as u128) * (arg0 as u128) / (arg1 as u128)) as u64)
    }

    public fun close_Position<T0, T1, T2>(arg0: &0xa65b136a35b9371b74a00f6d4ee21100c0cfce95ae3bef10c123ce698a2cf2b7::config::GlobalConfig, arg1: &mut 0xa65b136a35b9371b74a00f6d4ee21100c0cfce95ae3bef10c123ce698a2cf2b7::market::Market<T1, T2>, arg2: Position<T0>, arg3: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::Obligation<T0>, arg4: &0x2::clock::Clock) {
        0xa65b136a35b9371b74a00f6d4ee21100c0cfce95ae3bef10c123ce698a2cf2b7::config::assert_package_version(arg0);
        0xa65b136a35b9371b74a00f6d4ee21100c0cfce95ae3bef10c123ce698a2cf2b7::config::assert_global_close_not_paused(arg0);
        0xa65b136a35b9371b74a00f6d4ee21100c0cfce95ae3bef10c123ce698a2cf2b7::market::assert_close_not_paused<T1, T2>(arg1);
        assert!(obligation_id<T0>(&arg2) == 0x2::object::id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::Obligation<T0>>(arg3), 0xa65b136a35b9371b74a00f6d4ee21100c0cfce95ae3bef10c123ce698a2cf2b7::errors::err_position_not_found());
        assert!(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::allowed_borrow_value_usd<T0>(arg3) == 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(0), 0xa65b136a35b9371b74a00f6d4ee21100c0cfce95ae3bef10c123ce698a2cf2b7::errors::err_position_balance_not_zero());
        assert!(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::deposited_value_usd<T0>(arg3) == 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(0), 0xa65b136a35b9371b74a00f6d4ee21100c0cfce95ae3bef10c123ce698a2cf2b7::errors::err_position_balance_not_zero());
        let v0 = 0x2::object::id<Position<T0>>(&arg2);
        let Position {
            id                   : v1,
            init_deposit_amount  : _,
            is_long              : _,
            obligation_owner_cap : v4,
            created_ts           : _,
            owner                : v6,
            lending_market_id    : _,
        } = arg2;
        let v8 = ClosePositionEvent{
            position_id : v0,
            market_id   : 0xa65b136a35b9371b74a00f6d4ee21100c0cfce95ae3bef10c123ce698a2cf2b7::market::market_id<T1, T2>(arg1),
            owner       : v6,
            timestamp   : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<ClosePositionEvent>(v8);
        0x2::object::delete(v1);
        0x2::transfer::public_share_object<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>>(v4);
        0xa65b136a35b9371b74a00f6d4ee21100c0cfce95ae3bef10c123ce698a2cf2b7::market::remove_position_info<T1, T2>(arg1, v0);
    }

    public fun deposit<T0, T1, T2, T3>(arg0: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg1: &mut 0xa65b136a35b9371b74a00f6d4ee21100c0cfce95ae3bef10c123ce698a2cf2b7::market::Market<T1, T2>, arg2: &mut Position<T0>, arg3: 0x2::coin::Coin<T3>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<T3>(arg3);
        0xa65b136a35b9371b74a00f6d4ee21100c0cfce95ae3bef10c123ce698a2cf2b7::market::join_fee<T1, T2, T3>(arg1, 0x2::balance::split<T3>(&mut v0, calculate_fee(0xa65b136a35b9371b74a00f6d4ee21100c0cfce95ae3bef10c123ce698a2cf2b7::market::open_fee_rate<T1, T2>(arg1), 1000000, 0x2::coin::value<T3>(&arg3))), is_long<T0>(arg2));
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_ctokens_into_obligation<T0, T3>(arg0, arg4, &arg2.obligation_owner_cap, arg5, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_liquidity_and_mint_ctokens<T0, T3>(arg0, arg4, arg5, 0x2::coin::from_balance<T3>(v0, arg6), arg6), arg6);
        let v1 = DepositEvent{
            position_id    : 0x2::object::id<Position<T0>>(arg2),
            owner          : 0x2::tx_context::sender(arg6),
            coin_type      : 0x1::type_name::get<T3>(),
            deposit_amount : 0x2::balance::value<T3>(&v0),
            timestamp      : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<DepositEvent>(v1);
    }

    public fun get_obligation_owner_cap<T0>(arg0: &Position<T0>) : &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0> {
        &arg0.obligation_owner_cap
    }

    public fun get_position_created_time<T0>(arg0: &Position<T0>) : u64 {
        arg0.created_ts
    }

    public fun init_deposit_amount<T0>(arg0: &Position<T0>) : u64 {
        arg0.init_deposit_amount
    }

    public fun is_long<T0>(arg0: &Position<T0>) : bool {
        arg0.is_long
    }

    public fun obligation_id<T0>(arg0: &Position<T0>) : 0x2::object::ID {
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation_id<T0>(&arg0.obligation_owner_cap)
    }

    public fun open_position<T0, T1, T2, T3>(arg0: &0xa65b136a35b9371b74a00f6d4ee21100c0cfce95ae3bef10c123ce698a2cf2b7::config::GlobalConfig, arg1: &mut 0xa65b136a35b9371b74a00f6d4ee21100c0cfce95ae3bef10c123ce698a2cf2b7::market::Market<T1, T2>, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : Position<T0> {
        0xa65b136a35b9371b74a00f6d4ee21100c0cfce95ae3bef10c123ce698a2cf2b7::config::assert_package_version(arg0);
        0xa65b136a35b9371b74a00f6d4ee21100c0cfce95ae3bef10c123ce698a2cf2b7::config::assert_global_open_not_paused(arg0);
        0xa65b136a35b9371b74a00f6d4ee21100c0cfce95ae3bef10c123ce698a2cf2b7::market::assert_open_not_paused<T1, T2>(arg1);
        0xa65b136a35b9371b74a00f6d4ee21100c0cfce95ae3bef10c123ce698a2cf2b7::market::assert_leverage_valid<T1, T2>(arg1, arg4, true);
        let v0 = 0x1::type_name::get<T3>();
        let v1 = 0x1::type_name::get<T1>();
        let v2 = 0x1::type_name::get<T2>();
        assert!(v0 == v1 || v0 == v2, 0xa65b136a35b9371b74a00f6d4ee21100c0cfce95ae3bef10c123ce698a2cf2b7::errors::err_invalid_deposit_type());
        let (v3, v4, v5) = if (v0 == v1) {
            (true, v1, v2)
        } else {
            (false, v2, v1)
        };
        let v6 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::create_obligation<T0>(arg2, arg6);
        let v7 = Position<T0>{
            id                   : 0x2::object::new(arg6),
            init_deposit_amount  : arg3,
            is_long              : v3,
            obligation_owner_cap : v6,
            created_ts           : 0x2::clock::timestamp_ms(arg5),
            owner                : 0x2::tx_context::sender(arg6),
            lending_market_id    : 0x2::object::id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>>(arg2),
        };
        let v8 = 0x2::object::id<Position<T0>>(&v7);
        0xa65b136a35b9371b74a00f6d4ee21100c0cfce95ae3bef10c123ce698a2cf2b7::market::add_position_info<T1, T2>(arg1, 0xa65b136a35b9371b74a00f6d4ee21100c0cfce95ae3bef10c123ce698a2cf2b7::market::create_position_info(v8, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation_id<T0>(&v7.obligation_owner_cap), v7.init_deposit_amount, v3));
        let v9 = OpenPositionEvent{
            position_id          : v8,
            market_id            : 0xa65b136a35b9371b74a00f6d4ee21100c0cfce95ae3bef10c123ce698a2cf2b7::market::market_id<T1, T2>(arg1),
            obligation_id        : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation_id<T0>(&v6),
            leverage             : arg4,
            is_long              : v3,
            collateral_coin_type : v4,
            loan_coin_type       : v5,
            owner                : 0x2::tx_context::sender(arg6),
            timestamp            : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<OpenPositionEvent>(v9);
        v7
    }

    public fun owner<T0>(arg0: &Position<T0>) : address {
        arg0.owner
    }

    public fun repay<T0, T1>(arg0: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg1: &mut Position<T0>, arg2: &mut 0x2::coin::Coin<T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::repay<T0, T1>(arg0, arg3, obligation_id<T0>(arg1), arg4, arg2, arg5);
        let v0 = RepayEvent{
            position_id     : 0x2::object::id<Position<T0>>(arg1),
            owner           : 0x2::tx_context::sender(arg5),
            repay_coin_type : 0x1::type_name::get<T1>(),
            repay_amount    : 0x2::coin::value<T1>(arg2),
            timestamp       : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<RepayEvent>(v0);
    }

    public fun withdraw_not_sui<T0, T1, T2, T3>(arg0: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg1: &mut 0xa65b136a35b9371b74a00f6d4ee21100c0cfce95ae3bef10c123ce698a2cf2b7::market::Market<T1, T2>, arg2: &Position<T0>, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: 0x1::option::Option<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, T3>>, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T3> {
        assert!(arg5 > 0, 0xa65b136a35b9371b74a00f6d4ee21100c0cfce95ae3bef10c123ce698a2cf2b7::errors::err_insufficient_collateral());
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<T0>(arg0, arg6, arg7, arg3);
        let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity<T0, T3>(arg0, arg6, arg7, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::withdraw_ctokens<T0, T3>(arg0, arg6, &arg2.obligation_owner_cap, arg7, arg5, arg8), arg4, arg8);
        let v1 = 0x2::coin::into_balance<T3>(v0);
        0xa65b136a35b9371b74a00f6d4ee21100c0cfce95ae3bef10c123ce698a2cf2b7::market::join_fee<T1, T2, T3>(arg1, 0x2::balance::split<T3>(&mut v1, calculate_fee(0xa65b136a35b9371b74a00f6d4ee21100c0cfce95ae3bef10c123ce698a2cf2b7::market::close_fee_rate<T1, T2>(arg1), 1000000, 0x2::coin::value<T3>(&v0))), is_long<T0>(arg2));
        let v2 = WithdrawEvent{
            position_id     : 0x2::object::id<Position<T0>>(arg2),
            owner           : 0x2::tx_context::sender(arg8),
            coin_type       : 0x1::type_name::get<T3>(),
            withdraw_amount : arg5,
            timestamp       : 0x2::clock::timestamp_ms(arg7),
        };
        0x2::event::emit<WithdrawEvent>(v2);
        0x2::coin::from_balance<T3>(v1, arg8)
    }

    public fun withdraw_sui<T0, T1, T2>(arg0: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg1: &mut 0xa65b136a35b9371b74a00f6d4ee21100c0cfce95ae3bef10c123ce698a2cf2b7::market::Market<T1, T2>, arg2: &Position<T0>, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: 0x1::option::Option<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, 0x2::sui::SUI>>, arg5: u64, arg6: u64, arg7: &mut 0x3::sui_system::SuiSystemState, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<T0>(arg0, arg6, arg8, arg3);
        let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity_request<T0, 0x2::sui::SUI>(arg0, arg6, arg8, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::withdraw_ctokens<T0, 0x2::sui::SUI>(arg0, arg6, &arg2.obligation_owner_cap, arg8, arg5, arg9), arg4, arg9);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::unstake_sui_from_staker<T0>(arg0, arg6, &v0, arg7, arg9);
        let v1 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::fulfill_liquidity_request<T0, 0x2::sui::SUI>(arg0, arg6, v0, arg9);
        let v2 = 0x2::coin::into_balance<0x2::sui::SUI>(v1);
        0xa65b136a35b9371b74a00f6d4ee21100c0cfce95ae3bef10c123ce698a2cf2b7::market::join_fee<T1, T2, 0x2::sui::SUI>(arg1, 0x2::balance::split<0x2::sui::SUI>(&mut v2, calculate_fee(0xa65b136a35b9371b74a00f6d4ee21100c0cfce95ae3bef10c123ce698a2cf2b7::market::close_fee_rate<T1, T2>(arg1), 1000000, 0x2::coin::value<0x2::sui::SUI>(&v1))), is_long<T0>(arg2));
        let v3 = WithdrawEvent{
            position_id     : 0x2::object::id<Position<T0>>(arg2),
            owner           : 0x2::tx_context::sender(arg9),
            coin_type       : 0x1::type_name::get<0x2::sui::SUI>(),
            withdraw_amount : arg5,
            timestamp       : 0x2::clock::timestamp_ms(arg8),
        };
        0x2::event::emit<WithdrawEvent>(v3);
        0x2::coin::from_balance<0x2::sui::SUI>(v2, arg9)
    }

    // decompiled from Move bytecode v6
}

