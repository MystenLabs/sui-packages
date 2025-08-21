module 0xcb778bd3bf7e50f9c114285938dd7df90b93498400d6e6799ff75414bd199765::position {
    struct Position<phantom T0, phantom T1, phantom T2> has store, key {
        id: 0x2::object::UID,
        deposit_token: 0x1::type_name::TypeName,
        init_deposit_token_amount: u64,
        is_long: bool,
        obligation_owner_cap: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>,
        borrowed_base: 0x2::balance::Balance<T1>,
        borrowed_quote: 0x2::balance::Balance<T2>,
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
        init_deposit_amount: u64,
        suilend_deposit_amount: u64,
        leverage: u64,
        is_long: bool,
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
        coin_type: 0x1::type_name::TypeName,
        owner: address,
        repay_amount: u64,
        timestamp: u64,
    }

    public fun borrow_not_sui<T0, T1, T2, T3>(arg0: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg1: &Position<T0, T1, T2>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T3> {
        let v0 = BorrowEvent{
            position_id   : 0x2::object::id<Position<T0, T1, T2>>(arg1),
            owner         : 0x2::tx_context::sender(arg5),
            coin_type     : 0x1::type_name::get<T3>(),
            borrow_amount : arg3,
            timestamp     : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<BorrowEvent>(v0);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::borrow<T0, T3>(arg0, arg2, &arg1.obligation_owner_cap, arg4, arg3, arg5)
    }

    public fun borrow_sui<T0, T1, T2>(arg0: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg1: &Position<T0, T1, T2>, arg2: u64, arg3: u64, arg4: &mut 0x3::sui_system::SuiSystemState, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::borrow_request<T0, 0x2::sui::SUI>(arg0, arg2, &arg1.obligation_owner_cap, arg5, arg3);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::unstake_sui_from_staker<T0>(arg0, arg2, &v0, arg4, arg6);
        let v1 = BorrowEvent{
            position_id   : 0x2::object::id<Position<T0, T1, T2>>(arg1),
            owner         : 0x2::tx_context::sender(arg6),
            coin_type     : 0x1::type_name::get<0x2::sui::SUI>(),
            borrow_amount : arg3,
            timestamp     : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<BorrowEvent>(v1);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::fulfill_liquidity_request<T0, 0x2::sui::SUI>(arg0, arg2, v0, arg6)
    }

    public fun calculate_fee(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg0 < arg1, 0xcb778bd3bf7e50f9c114285938dd7df90b93498400d6e6799ff75414bd199765::errors::err_invalid_fee_rate());
        (((arg2 as u128) * (arg0 as u128) / (arg1 as u128)) as u64)
    }

    fun check_empty_position<T0, T1, T2>(arg0: &Position<T0, T1, T2>) {
        assert!(0x2::balance::value<T1>(&arg0.borrowed_base) == 0 && 0x2::balance::value<T2>(&arg0.borrowed_quote) == 0, 0xcb778bd3bf7e50f9c114285938dd7df90b93498400d6e6799ff75414bd199765::errors::err_position_balance_not_zero());
    }

    public fun close<T0, T1, T2>(arg0: &0xcb778bd3bf7e50f9c114285938dd7df90b93498400d6e6799ff75414bd199765::config::GlobalConfig, arg1: &mut 0xcb778bd3bf7e50f9c114285938dd7df90b93498400d6e6799ff75414bd199765::market::Market<T1, T2>, arg2: Position<T0, T1, T2>, arg3: &0x2::clock::Clock) {
        0xcb778bd3bf7e50f9c114285938dd7df90b93498400d6e6799ff75414bd199765::config::assert_package_version(arg0);
        0xcb778bd3bf7e50f9c114285938dd7df90b93498400d6e6799ff75414bd199765::config::assert_global_close_not_paused(arg0);
        0xcb778bd3bf7e50f9c114285938dd7df90b93498400d6e6799ff75414bd199765::market::assert_close_not_paused<T1, T2>(arg1);
        check_empty_position<T0, T1, T2>(&arg2);
        let v0 = 0x2::object::id<Position<T0, T1, T2>>(&arg2);
        let Position {
            id                        : v1,
            deposit_token             : _,
            init_deposit_token_amount : _,
            is_long                   : _,
            obligation_owner_cap      : v5,
            borrowed_base             : v6,
            borrowed_quote            : v7,
            created_ts                : _,
            owner                     : v9,
            cetus_pool_id             : _,
            lending_market_id         : _,
            base_reserve_array_index  : _,
            quote_reserve_array_index : _,
        } = arg2;
        let v14 = ClosePositionEvent{
            position_id : v0,
            market_id   : 0xcb778bd3bf7e50f9c114285938dd7df90b93498400d6e6799ff75414bd199765::market::get_market_id<T1, T2>(arg1),
            owner       : v9,
            timestamp   : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<ClosePositionEvent>(v14);
        0x2::balance::destroy_zero<T1>(v6);
        0x2::balance::destroy_zero<T2>(v7);
        0x2::object::delete(v1);
        0x2::transfer::public_share_object<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>>(v5);
        0xcb778bd3bf7e50f9c114285938dd7df90b93498400d6e6799ff75414bd199765::market::remove_position_info<T1, T2>(arg1, v0);
    }

    public fun deposit<T0, T1, T2, T3>(arg0: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg1: &mut Position<T0, T1, T2>, arg2: 0x2::coin::Coin<T3>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_ctokens_into_obligation<T0, T3>(arg0, arg1.base_reserve_array_index, &arg1.obligation_owner_cap, arg3, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_liquidity_and_mint_ctokens<T0, T3>(arg0, arg1.base_reserve_array_index, arg3, arg2, arg4), arg4);
        let v0 = DepositEvent{
            position_id    : 0x2::object::id<Position<T0, T1, T2>>(arg1),
            owner          : 0x2::tx_context::sender(arg4),
            coin_type      : 0x1::type_name::get<T3>(),
            deposit_amount : 0x2::coin::value<T3>(&arg2),
            timestamp      : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<DepositEvent>(v0);
    }

    public fun get_borrowed_amounts<T0, T1, T2>(arg0: &Position<T0, T1, T2>) : (u64, u64) {
        (0x2::balance::value<T1>(&arg0.borrowed_base), 0x2::balance::value<T2>(&arg0.borrowed_quote))
    }

    public fun get_init_collateral_amount<T0, T1, T2>(arg0: &Position<T0, T1, T2>) : u64 {
        arg0.init_deposit_token_amount
    }

    public fun get_is_long<T0, T1, T2>(arg0: &Position<T0, T1, T2>) : bool {
        arg0.is_long
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

    public fun obligation_id<T0, T1, T2>(arg0: &Position<T0, T1, T2>) : 0x2::object::ID {
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation_id<T0>(&arg0.obligation_owner_cap)
    }

    public(friend) fun open_long<T0, T1, T2>(arg0: &0xcb778bd3bf7e50f9c114285938dd7df90b93498400d6e6799ff75414bd199765::config::GlobalConfig, arg1: &mut 0xcb778bd3bf7e50f9c114285938dd7df90b93498400d6e6799ff75414bd199765::market::Market<T1, T2>, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: 0x2::object::ID, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : Position<T0, T1, T2> {
        0xcb778bd3bf7e50f9c114285938dd7df90b93498400d6e6799ff75414bd199765::config::assert_package_version(arg0);
        0xcb778bd3bf7e50f9c114285938dd7df90b93498400d6e6799ff75414bd199765::config::assert_global_open_not_paused(arg0);
        0xcb778bd3bf7e50f9c114285938dd7df90b93498400d6e6799ff75414bd199765::market::assert_open_not_paused<T1, T2>(arg1);
        0xcb778bd3bf7e50f9c114285938dd7df90b93498400d6e6799ff75414bd199765::market::assert_leverage_valid<T1, T2>(arg1, arg5, true);
        let v0 = 0x2::coin::value<T1>(&arg3);
        assert!(v0 > 0, 0xcb778bd3bf7e50f9c114285938dd7df90b93498400d6e6799ff75414bd199765::errors::err_insufficient_collateral());
        let v1 = calculate_fee(0xcb778bd3bf7e50f9c114285938dd7df90b93498400d6e6799ff75414bd199765::market::get_open_fee_rate<T1, T2>(arg1), 1000000, v0);
        let v2 = v0 - v1;
        let v3 = 0x2::coin::into_balance<T1>(arg3);
        0xcb778bd3bf7e50f9c114285938dd7df90b93498400d6e6799ff75414bd199765::market::join_fee<T1, T2>(arg1, 0x2::balance::split<T1>(&mut v3, v1), 0x2::balance::zero<T2>(), true, arg9);
        let v4 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::create_obligation<T0>(arg2, arg10);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_ctokens_into_obligation<T0, T1>(arg2, arg6, &v4, arg9, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_liquidity_and_mint_ctokens<T0, T1>(arg2, arg6, arg9, 0x2::coin::from_balance<T1>(v3, arg10), arg10), arg10);
        let v5 = Position<T0, T1, T2>{
            id                        : 0x2::object::new(arg10),
            deposit_token             : 0x1::type_name::get<T1>(),
            init_deposit_token_amount : arg4,
            is_long                   : true,
            obligation_owner_cap      : v4,
            borrowed_base             : 0x2::balance::zero<T1>(),
            borrowed_quote            : 0x2::balance::zero<T2>(),
            created_ts                : 0x2::clock::timestamp_ms(arg9),
            owner                     : 0x2::tx_context::sender(arg10),
            cetus_pool_id             : arg8,
            lending_market_id         : 0x2::object::id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>>(arg2),
            base_reserve_array_index  : arg6,
            quote_reserve_array_index : arg7,
        };
        let v6 = 0x2::object::id<Position<T0, T1, T2>>(&v5);
        0xcb778bd3bf7e50f9c114285938dd7df90b93498400d6e6799ff75414bd199765::market::add_position_info<T1, T2>(arg1, 0xcb778bd3bf7e50f9c114285938dd7df90b93498400d6e6799ff75414bd199765::market::create_position_info(v6, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation_id<T0>(&v5.obligation_owner_cap), v5.init_deposit_token_amount, true));
        let v7 = DepositEvent{
            position_id    : 0x2::object::id<Position<T0, T1, T2>>(&v5),
            owner          : 0x2::tx_context::sender(arg10),
            coin_type      : 0x1::type_name::get<T1>(),
            deposit_amount : v2,
            timestamp      : 0x2::clock::timestamp_ms(arg9),
        };
        0x2::event::emit<DepositEvent>(v7);
        let v8 = OpenPositionEvent{
            position_id            : v6,
            market_id              : 0xcb778bd3bf7e50f9c114285938dd7df90b93498400d6e6799ff75414bd199765::market::get_market_id<T1, T2>(arg1),
            init_deposit_amount    : arg4,
            suilend_deposit_amount : v2,
            leverage               : arg5,
            is_long                : true,
            owner                  : 0x2::tx_context::sender(arg10),
            timestamp              : 0x2::clock::timestamp_ms(arg9),
        };
        0x2::event::emit<OpenPositionEvent>(v8);
        v5
    }

    public fun open_position<T0, T1, T2>(arg0: &0xcb778bd3bf7e50f9c114285938dd7df90b93498400d6e6799ff75414bd199765::config::GlobalConfig, arg1: &mut 0xcb778bd3bf7e50f9c114285938dd7df90b93498400d6e6799ff75414bd199765::market::Market<T1, T2>, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: bool, arg4: 0x2::coin::Coin<T1>, arg5: 0x2::coin::Coin<T2>, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: 0x2::object::ID, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : Position<T0, T1, T2> {
        if (arg3) {
            0x2::coin::destroy_zero<T2>(arg5);
            open_long<T0, T1, T2>(arg0, arg1, arg2, arg4, arg6, arg7, arg8, arg9, arg10, arg11, arg12)
        } else {
            0x2::coin::destroy_zero<T1>(arg4);
            open_short<T0, T1, T2>(arg0, arg1, arg2, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12)
        }
    }

    public(friend) fun open_short<T0, T1, T2>(arg0: &0xcb778bd3bf7e50f9c114285938dd7df90b93498400d6e6799ff75414bd199765::config::GlobalConfig, arg1: &mut 0xcb778bd3bf7e50f9c114285938dd7df90b93498400d6e6799ff75414bd199765::market::Market<T1, T2>, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: 0x2::coin::Coin<T2>, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: 0x2::object::ID, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : Position<T0, T1, T2> {
        0xcb778bd3bf7e50f9c114285938dd7df90b93498400d6e6799ff75414bd199765::config::assert_package_version(arg0);
        0xcb778bd3bf7e50f9c114285938dd7df90b93498400d6e6799ff75414bd199765::config::assert_global_open_not_paused(arg0);
        0xcb778bd3bf7e50f9c114285938dd7df90b93498400d6e6799ff75414bd199765::market::assert_open_not_paused<T1, T2>(arg1);
        0xcb778bd3bf7e50f9c114285938dd7df90b93498400d6e6799ff75414bd199765::market::assert_leverage_valid<T1, T2>(arg1, arg5, false);
        let v0 = 0x2::coin::value<T2>(&arg3);
        assert!(v0 > 0, 0xcb778bd3bf7e50f9c114285938dd7df90b93498400d6e6799ff75414bd199765::errors::err_insufficient_collateral());
        let v1 = calculate_fee(0xcb778bd3bf7e50f9c114285938dd7df90b93498400d6e6799ff75414bd199765::market::get_open_fee_rate<T1, T2>(arg1), 1000000, v0);
        let v2 = v0 - v1;
        let v3 = 0x2::coin::into_balance<T2>(arg3);
        0xcb778bd3bf7e50f9c114285938dd7df90b93498400d6e6799ff75414bd199765::market::join_fee<T1, T2>(arg1, 0x2::balance::zero<T1>(), 0x2::balance::split<T2>(&mut v3, v1), true, arg9);
        let v4 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::create_obligation<T0>(arg2, arg10);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_ctokens_into_obligation<T0, T2>(arg2, arg7, &v4, arg9, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_liquidity_and_mint_ctokens<T0, T2>(arg2, arg7, arg9, 0x2::coin::from_balance<T2>(v3, arg10), arg10), arg10);
        let v5 = Position<T0, T1, T2>{
            id                        : 0x2::object::new(arg10),
            deposit_token             : 0x1::type_name::get<T2>(),
            init_deposit_token_amount : arg4,
            is_long                   : false,
            obligation_owner_cap      : v4,
            borrowed_base             : 0x2::balance::zero<T1>(),
            borrowed_quote            : 0x2::balance::zero<T2>(),
            created_ts                : 0x2::clock::timestamp_ms(arg9),
            owner                     : 0x2::tx_context::sender(arg10),
            cetus_pool_id             : arg8,
            lending_market_id         : 0x2::object::id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>>(arg2),
            base_reserve_array_index  : arg6,
            quote_reserve_array_index : arg7,
        };
        let v6 = 0x2::object::id<Position<T0, T1, T2>>(&v5);
        0xcb778bd3bf7e50f9c114285938dd7df90b93498400d6e6799ff75414bd199765::market::add_position_info<T1, T2>(arg1, 0xcb778bd3bf7e50f9c114285938dd7df90b93498400d6e6799ff75414bd199765::market::create_position_info(v6, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation_id<T0>(&v5.obligation_owner_cap), v5.init_deposit_token_amount, false));
        let v7 = DepositEvent{
            position_id    : 0x2::object::id<Position<T0, T1, T2>>(&v5),
            owner          : 0x2::tx_context::sender(arg10),
            coin_type      : 0x1::type_name::get<T2>(),
            deposit_amount : v2,
            timestamp      : 0x2::clock::timestamp_ms(arg9),
        };
        0x2::event::emit<DepositEvent>(v7);
        let v8 = OpenPositionEvent{
            position_id            : v6,
            market_id              : 0xcb778bd3bf7e50f9c114285938dd7df90b93498400d6e6799ff75414bd199765::market::get_market_id<T1, T2>(arg1),
            init_deposit_amount    : arg4,
            suilend_deposit_amount : v2,
            leverage               : arg5,
            is_long                : true,
            owner                  : 0x2::tx_context::sender(arg10),
            timestamp              : 0x2::clock::timestamp_ms(arg9),
        };
        0x2::event::emit<OpenPositionEvent>(v8);
        v5
    }

    public fun repay<T0, T1, T2>(arg0: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg1: &mut Position<T0, T1, T2>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = if (get_is_long<T0, T1, T2>(arg1)) {
            let v1 = 0x2::coin::from_balance<T2>(0x2::balance::split<T2>(&mut arg1.borrowed_quote, arg2), arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::repay<T0, T2>(arg0, arg1.quote_reserve_array_index, obligation_id<T0, T1, T2>(arg1), arg3, &mut v1, arg4);
            if (0x2::coin::value<T2>(&v1) > 0) {
                0x2::balance::join<T2>(&mut arg1.borrowed_quote, 0x2::coin::into_balance<T2>(v1));
            } else {
                0x2::coin::destroy_zero<T2>(v1);
            };
            0x1::type_name::get<T2>()
        } else {
            let v2 = 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg1.borrowed_base, arg2), arg4);
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::repay<T0, T1>(arg0, arg1.base_reserve_array_index, obligation_id<T0, T1, T2>(arg1), arg3, &mut v2, arg4);
            if (0x2::coin::value<T1>(&v2) > 0) {
                0x2::balance::join<T1>(&mut arg1.borrowed_base, 0x2::coin::into_balance<T1>(v2));
            } else {
                0x2::coin::destroy_zero<T1>(v2);
            };
            0x1::type_name::get<T1>()
        };
        let v3 = RepayEvent{
            position_id  : 0x2::object::id<Position<T0, T1, T2>>(arg1),
            coin_type    : v0,
            owner        : 0x2::tx_context::sender(arg4),
            repay_amount : arg2,
            timestamp    : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<RepayEvent>(v3);
    }

    public fun withdraw_not_sui<T0, T1, T2, T3>(arg0: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg1: &Position<T0, T1, T2>, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: 0x1::option::Option<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, T3>>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T3> {
        let v0 = if (get_is_long<T0, T1, T2>(arg1)) {
            arg1.base_reserve_array_index
        } else {
            arg1.quote_reserve_array_index
        };
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<T0>(arg0, v0, arg5, arg2);
        let v1 = WithdrawEvent{
            position_id     : 0x2::object::id<Position<T0, T1, T2>>(arg1),
            owner           : 0x2::tx_context::sender(arg6),
            coin_type       : 0x1::type_name::get<T3>(),
            withdraw_amount : arg4,
            timestamp       : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<WithdrawEvent>(v1);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity<T0, T3>(arg0, v0, arg5, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::withdraw_ctokens<T0, T3>(arg0, v0, &arg1.obligation_owner_cap, arg5, arg4, arg6), arg3, arg6)
    }

    public fun withdraw_sui<T0, T1, T2>(arg0: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg1: &Position<T0, T1, T2>, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: 0x1::option::Option<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, 0x2::sui::SUI>>, arg4: u64, arg5: &mut 0x3::sui_system::SuiSystemState, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = if (get_is_long<T0, T1, T2>(arg1)) {
            arg1.base_reserve_array_index
        } else {
            arg1.quote_reserve_array_index
        };
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<T0>(arg0, v0, arg6, arg2);
        let v1 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity_request<T0, 0x2::sui::SUI>(arg0, v0, arg6, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::withdraw_ctokens<T0, 0x2::sui::SUI>(arg0, v0, &arg1.obligation_owner_cap, arg6, arg4, arg7), arg3, arg7);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::unstake_sui_from_staker<T0>(arg0, v0, &v1, arg5, arg7);
        let v2 = WithdrawEvent{
            position_id     : 0x2::object::id<Position<T0, T1, T2>>(arg1),
            owner           : 0x2::tx_context::sender(arg7),
            coin_type       : 0x1::type_name::get<0x2::sui::SUI>(),
            withdraw_amount : arg4,
            timestamp       : 0x2::clock::timestamp_ms(arg6),
        };
        0x2::event::emit<WithdrawEvent>(v2);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::fulfill_liquidity_request<T0, 0x2::sui::SUI>(arg0, v0, v1, arg7)
    }

    // decompiled from Move bytecode v6
}

