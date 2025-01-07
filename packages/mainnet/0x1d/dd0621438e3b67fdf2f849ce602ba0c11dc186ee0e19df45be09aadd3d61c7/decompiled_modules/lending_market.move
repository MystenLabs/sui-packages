module 0x1ddd0621438e3b67fdf2f849ce602ba0c11dc186ee0e19df45be09aadd3d61c7::lending_market {
    struct LendingMarket<phantom T0> has key {
        id: 0x2::object::UID,
        version: u64,
        reserves: vector<0x1ddd0621438e3b67fdf2f849ce602ba0c11dc186ee0e19df45be09aadd3d61c7::reserve::Reserve<T0>>,
        obligations: 0x2::object_table::ObjectTable<0x2::object::ID, 0x1ddd0621438e3b67fdf2f849ce602ba0c11dc186ee0e19df45be09aadd3d61c7::obligation::Obligation<T0>>,
        rate_limiter: 0x1ddd0621438e3b67fdf2f849ce602ba0c11dc186ee0e19df45be09aadd3d61c7::rate_limiter::RateLimiter,
        fee_receiver: address,
    }

    struct LendingMarketOwnerCap<phantom T0> has store, key {
        id: 0x2::object::UID,
        lending_market_id: 0x2::object::ID,
    }

    struct ObligationOwnerCap<phantom T0> has store, key {
        id: 0x2::object::UID,
        obligation_id: 0x2::object::ID,
    }

    struct RateLimiterExemption<phantom T0, phantom T1> has drop {
        amount: u64,
    }

    struct MintEvent<phantom T0, phantom T1> has copy, drop {
        in_liquidity_amount: u64,
        out_ctoken_amount: u64,
        caller: address,
    }

    struct RedeemEvent<phantom T0, phantom T1> has copy, drop {
        in_ctoken_amount: u64,
        out_liquidity_amount: u64,
        caller: address,
    }

    struct DepositEvent<phantom T0, phantom T1> has copy, drop {
        ctoken_amount: u64,
        obligation_id: 0x2::object::ID,
        caller: address,
    }

    struct WithdrawEvent<phantom T0, phantom T1> has copy, drop {
        ctoken_amount: u64,
        obligation_id: 0x2::object::ID,
        caller: address,
    }

    struct BorrowEvent<phantom T0, phantom T1> has copy, drop {
        liquidity_amount: u64,
        obligation_id: 0x2::object::ID,
        caller: address,
    }

    struct RepayEvent<phantom T0, phantom T1> has copy, drop {
        liquidity_amount: u64,
        obligation_id: 0x2::object::ID,
        caller: address,
    }

    struct LiquidateEvent<phantom T0, phantom T1, phantom T2> has copy, drop {
        repay_amount: u64,
        withdraw_amount: u64,
        obligation_id: 0x2::object::ID,
        caller: address,
    }

    public fun borrow<T0, T1>(arg0: &mut LendingMarket<T0>, arg1: u64, arg2: &ObligationOwnerCap<T0>, arg3: &0x2::clock::Clock, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(arg0.version == 1, 1);
        assert!(arg4 > 0, 2);
        let v0 = 0x2::object_table::borrow_mut<0x2::object::ID, 0x1ddd0621438e3b67fdf2f849ce602ba0c11dc186ee0e19df45be09aadd3d61c7::obligation::Obligation<T0>>(&mut arg0.obligations, arg2.obligation_id);
        0x1ddd0621438e3b67fdf2f849ce602ba0c11dc186ee0e19df45be09aadd3d61c7::obligation::refresh<T0>(v0, &mut arg0.reserves, arg3);
        let v1 = 0x1::vector::borrow_mut<0x1ddd0621438e3b67fdf2f849ce602ba0c11dc186ee0e19df45be09aadd3d61c7::reserve::Reserve<T0>>(&mut arg0.reserves, arg1);
        assert!(0x1ddd0621438e3b67fdf2f849ce602ba0c11dc186ee0e19df45be09aadd3d61c7::reserve::coin_type<T0>(v1) == 0x1::type_name::get<T1>(), 3);
        0x1ddd0621438e3b67fdf2f849ce602ba0c11dc186ee0e19df45be09aadd3d61c7::reserve::compound_interest<T0>(v1, arg3);
        0x1ddd0621438e3b67fdf2f849ce602ba0c11dc186ee0e19df45be09aadd3d61c7::reserve::assert_price_is_fresh<T0>(v1, arg3);
        let (v2, v3) = 0x1ddd0621438e3b67fdf2f849ce602ba0c11dc186ee0e19df45be09aadd3d61c7::reserve::borrow_liquidity<T0, T1>(v1, arg4);
        0x1ddd0621438e3b67fdf2f849ce602ba0c11dc186ee0e19df45be09aadd3d61c7::obligation::borrow<T0>(v0, v1, v3);
        0x1ddd0621438e3b67fdf2f849ce602ba0c11dc186ee0e19df45be09aadd3d61c7::rate_limiter::process_qty(&mut arg0.rate_limiter, 0x2::clock::timestamp_ms(arg3) / 1000, 0x1ddd0621438e3b67fdf2f849ce602ba0c11dc186ee0e19df45be09aadd3d61c7::reserve::market_value_upper_bound<T0>(v1, 0x1ddd0621438e3b67fdf2f849ce602ba0c11dc186ee0e19df45be09aadd3d61c7::decimal::from(v3)));
        let v4 = BorrowEvent<T0, T1>{
            liquidity_amount : v3,
            obligation_id    : arg2.obligation_id,
            caller           : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<BorrowEvent<T0, T1>>(v4);
        0x2::coin::from_balance<T1>(v2, arg5)
    }

    public fun add_reserve<T0, T1>(arg0: &LendingMarketOwnerCap<T0>, arg1: &mut LendingMarket<T0>, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: 0x1ddd0621438e3b67fdf2f849ce602ba0c11dc186ee0e19df45be09aadd3d61c7::reserve_config::ReserveConfig, arg4: &0x2::coin::CoinMetadata<T1>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 1, 1);
        assert!(reserve_array_index<T0, T1>(arg1) == 0x1::vector::length<0x1ddd0621438e3b67fdf2f849ce602ba0c11dc186ee0e19df45be09aadd3d61c7::reserve::Reserve<T0>>(&arg1.reserves), 4);
        0x1::vector::push_back<0x1ddd0621438e3b67fdf2f849ce602ba0c11dc186ee0e19df45be09aadd3d61c7::reserve::Reserve<T0>>(&mut arg1.reserves, 0x1ddd0621438e3b67fdf2f849ce602ba0c11dc186ee0e19df45be09aadd3d61c7::reserve::create_reserve<T0, T1>(arg3, 0x1::vector::length<0x1ddd0621438e3b67fdf2f849ce602ba0c11dc186ee0e19df45be09aadd3d61c7::reserve::Reserve<T0>>(&arg1.reserves), arg4, arg2, arg5, arg6));
    }

    entry fun claim_fees<T0, T1>(arg0: &mut LendingMarket<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 1);
        let v0 = 0x1::vector::borrow_mut<0x1ddd0621438e3b67fdf2f849ce602ba0c11dc186ee0e19df45be09aadd3d61c7::reserve::Reserve<T0>>(&mut arg0.reserves, arg1);
        assert!(0x1ddd0621438e3b67fdf2f849ce602ba0c11dc186ee0e19df45be09aadd3d61c7::reserve::coin_type<T0>(v0) == 0x1::type_name::get<T1>(), 3);
        let (v1, v2) = 0x1ddd0621438e3b67fdf2f849ce602ba0c11dc186ee0e19df45be09aadd3d61c7::reserve::claim_fees<T0, T1>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x1ddd0621438e3b67fdf2f849ce602ba0c11dc186ee0e19df45be09aadd3d61c7::reserve::CToken<T0, T1>>>(0x2::coin::from_balance<0x1ddd0621438e3b67fdf2f849ce602ba0c11dc186ee0e19df45be09aadd3d61c7::reserve::CToken<T0, T1>>(v1, arg2), arg0.fee_receiver);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v2, arg2), arg0.fee_receiver);
    }

    public fun create_lending_market<T0: drop>(arg0: T0, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : (LendingMarketOwnerCap<T0>, LendingMarket<T0>) {
        assert!(0x2::types::is_one_time_witness<T0>(&arg0), 0);
        let v0 = LendingMarket<T0>{
            id           : 0x2::object::new(arg2),
            version      : 1,
            reserves     : 0x1::vector::empty<0x1ddd0621438e3b67fdf2f849ce602ba0c11dc186ee0e19df45be09aadd3d61c7::reserve::Reserve<T0>>(),
            obligations  : 0x2::object_table::new<0x2::object::ID, 0x1ddd0621438e3b67fdf2f849ce602ba0c11dc186ee0e19df45be09aadd3d61c7::obligation::Obligation<T0>>(arg2),
            rate_limiter : 0x1ddd0621438e3b67fdf2f849ce602ba0c11dc186ee0e19df45be09aadd3d61c7::rate_limiter::new(0x1ddd0621438e3b67fdf2f849ce602ba0c11dc186ee0e19df45be09aadd3d61c7::rate_limiter::new_config(1, 18446744073709551615), 0),
            fee_receiver : arg1,
        };
        let v1 = LendingMarketOwnerCap<T0>{
            id                : 0x2::object::new(arg2),
            lending_market_id : 0x2::object::id<LendingMarket<T0>>(&v0),
        };
        (v1, v0)
    }

    public fun create_obligation<T0>(arg0: &mut LendingMarket<T0>, arg1: &mut 0x2::tx_context::TxContext) : ObligationOwnerCap<T0> {
        assert!(arg0.version == 1, 1);
        let v0 = 0x1ddd0621438e3b67fdf2f849ce602ba0c11dc186ee0e19df45be09aadd3d61c7::obligation::create_obligation<T0>(arg1);
        let v1 = ObligationOwnerCap<T0>{
            id            : 0x2::object::new(arg1),
            obligation_id : 0x2::object::id<0x1ddd0621438e3b67fdf2f849ce602ba0c11dc186ee0e19df45be09aadd3d61c7::obligation::Obligation<T0>>(&v0),
        };
        0x2::object_table::add<0x2::object::ID, 0x1ddd0621438e3b67fdf2f849ce602ba0c11dc186ee0e19df45be09aadd3d61c7::obligation::Obligation<T0>>(&mut arg0.obligations, 0x2::object::id<0x1ddd0621438e3b67fdf2f849ce602ba0c11dc186ee0e19df45be09aadd3d61c7::obligation::Obligation<T0>>(&v0), v0);
        v1
    }

    public fun deposit_ctokens_into_obligation<T0, T1>(arg0: &mut LendingMarket<T0>, arg1: u64, arg2: &ObligationOwnerCap<T0>, arg3: 0x2::coin::Coin<0x1ddd0621438e3b67fdf2f849ce602ba0c11dc186ee0e19df45be09aadd3d61c7::reserve::CToken<T0, T1>>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 1);
        assert!(0x2::coin::value<0x1ddd0621438e3b67fdf2f849ce602ba0c11dc186ee0e19df45be09aadd3d61c7::reserve::CToken<T0, T1>>(&arg3) > 0, 2);
        let v0 = 0x1::vector::borrow_mut<0x1ddd0621438e3b67fdf2f849ce602ba0c11dc186ee0e19df45be09aadd3d61c7::reserve::Reserve<T0>>(&mut arg0.reserves, arg1);
        assert!(0x1ddd0621438e3b67fdf2f849ce602ba0c11dc186ee0e19df45be09aadd3d61c7::reserve::coin_type<T0>(v0) == 0x1::type_name::get<T1>(), 3);
        let v1 = DepositEvent<T0, T1>{
            ctoken_amount : 0x2::coin::value<0x1ddd0621438e3b67fdf2f849ce602ba0c11dc186ee0e19df45be09aadd3d61c7::reserve::CToken<T0, T1>>(&arg3),
            obligation_id : arg2.obligation_id,
            caller        : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<DepositEvent<T0, T1>>(v1);
        0x1ddd0621438e3b67fdf2f849ce602ba0c11dc186ee0e19df45be09aadd3d61c7::obligation::deposit<T0>(0x2::object_table::borrow_mut<0x2::object::ID, 0x1ddd0621438e3b67fdf2f849ce602ba0c11dc186ee0e19df45be09aadd3d61c7::obligation::Obligation<T0>>(&mut arg0.obligations, arg2.obligation_id), v0, 0x2::coin::value<0x1ddd0621438e3b67fdf2f849ce602ba0c11dc186ee0e19df45be09aadd3d61c7::reserve::CToken<T0, T1>>(&arg3));
        0x1ddd0621438e3b67fdf2f849ce602ba0c11dc186ee0e19df45be09aadd3d61c7::reserve::deposit_ctokens<T0, T1>(v0, 0x2::coin::into_balance<0x1ddd0621438e3b67fdf2f849ce602ba0c11dc186ee0e19df45be09aadd3d61c7::reserve::CToken<T0, T1>>(arg3));
    }

    fun reserve<T0, T1>(arg0: &LendingMarket<T0>) : &0x1ddd0621438e3b67fdf2f849ce602ba0c11dc186ee0e19df45be09aadd3d61c7::reserve::Reserve<T0> {
        0x1::vector::borrow<0x1ddd0621438e3b67fdf2f849ce602ba0c11dc186ee0e19df45be09aadd3d61c7::reserve::Reserve<T0>>(&arg0.reserves, reserve_array_index<T0, T1>(arg0))
    }

    public fun deposit_liquidity_and_mint_ctokens<T0, T1>(arg0: &mut LendingMarket<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<T1>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x1ddd0621438e3b67fdf2f849ce602ba0c11dc186ee0e19df45be09aadd3d61c7::reserve::CToken<T0, T1>> {
        assert!(arg0.version == 1, 1);
        assert!(0x2::coin::value<T1>(&arg3) > 0, 2);
        let v0 = 0x1::vector::borrow_mut<0x1ddd0621438e3b67fdf2f849ce602ba0c11dc186ee0e19df45be09aadd3d61c7::reserve::Reserve<T0>>(&mut arg0.reserves, arg1);
        assert!(0x1ddd0621438e3b67fdf2f849ce602ba0c11dc186ee0e19df45be09aadd3d61c7::reserve::coin_type<T0>(v0) == 0x1::type_name::get<T1>(), 3);
        0x1ddd0621438e3b67fdf2f849ce602ba0c11dc186ee0e19df45be09aadd3d61c7::reserve::compound_interest<T0>(v0, arg2);
        let v1 = 0x1ddd0621438e3b67fdf2f849ce602ba0c11dc186ee0e19df45be09aadd3d61c7::reserve::deposit_liquidity_and_mint_ctokens<T0, T1>(v0, 0x2::coin::into_balance<T1>(arg3));
        assert!(0x2::balance::value<0x1ddd0621438e3b67fdf2f849ce602ba0c11dc186ee0e19df45be09aadd3d61c7::reserve::CToken<T0, T1>>(&v1) > 0, 2);
        let v2 = MintEvent<T0, T1>{
            in_liquidity_amount : 0x2::coin::value<T1>(&arg3),
            out_ctoken_amount   : 0x2::balance::value<0x1ddd0621438e3b67fdf2f849ce602ba0c11dc186ee0e19df45be09aadd3d61c7::reserve::CToken<T0, T1>>(&v1),
            caller              : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<MintEvent<T0, T1>>(v2);
        0x2::coin::from_balance<0x1ddd0621438e3b67fdf2f849ce602ba0c11dc186ee0e19df45be09aadd3d61c7::reserve::CToken<T0, T1>>(v1, arg4)
    }

    public fun liquidate<T0, T1, T2>(arg0: &mut LendingMarket<T0>, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::coin::Coin<T1>, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x1ddd0621438e3b67fdf2f849ce602ba0c11dc186ee0e19df45be09aadd3d61c7::reserve::CToken<T0, T2>>, RateLimiterExemption<T0, T2>) {
        assert!(arg0.version == 1, 1);
        assert!(0x2::coin::value<T1>(arg5) > 0, 2);
        let v0 = 0x2::object_table::borrow_mut<0x2::object::ID, 0x1ddd0621438e3b67fdf2f849ce602ba0c11dc186ee0e19df45be09aadd3d61c7::obligation::Obligation<T0>>(&mut arg0.obligations, arg1);
        0x1ddd0621438e3b67fdf2f849ce602ba0c11dc186ee0e19df45be09aadd3d61c7::obligation::refresh<T0>(v0, &mut arg0.reserves, arg4);
        let v1 = 0x1::vector::borrow<0x1ddd0621438e3b67fdf2f849ce602ba0c11dc186ee0e19df45be09aadd3d61c7::reserve::Reserve<T0>>(&arg0.reserves, arg2);
        assert!(0x1ddd0621438e3b67fdf2f849ce602ba0c11dc186ee0e19df45be09aadd3d61c7::reserve::coin_type<T0>(v1) == 0x1::type_name::get<T1>(), 3);
        let v2 = 0x1::vector::borrow<0x1ddd0621438e3b67fdf2f849ce602ba0c11dc186ee0e19df45be09aadd3d61c7::reserve::Reserve<T0>>(&arg0.reserves, arg3);
        assert!(0x1ddd0621438e3b67fdf2f849ce602ba0c11dc186ee0e19df45be09aadd3d61c7::reserve::coin_type<T0>(v2) == 0x1::type_name::get<T2>(), 3);
        let (v3, v4) = 0x1ddd0621438e3b67fdf2f849ce602ba0c11dc186ee0e19df45be09aadd3d61c7::obligation::liquidate<T0>(v0, v1, v2, 0x2::coin::value<T1>(arg5));
        assert!(v3 > 0, 2);
        assert!(v4 > 0, 2);
        0x1ddd0621438e3b67fdf2f849ce602ba0c11dc186ee0e19df45be09aadd3d61c7::reserve::repay_liquidity<T0, T1>(0x1::vector::borrow_mut<0x1ddd0621438e3b67fdf2f849ce602ba0c11dc186ee0e19df45be09aadd3d61c7::reserve::Reserve<T0>>(&mut arg0.reserves, arg2), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(arg5, v4, arg6)));
        let v5 = 0x1::vector::borrow_mut<0x1ddd0621438e3b67fdf2f849ce602ba0c11dc186ee0e19df45be09aadd3d61c7::reserve::Reserve<T0>>(&mut arg0.reserves, arg3);
        let v6 = 0x1ddd0621438e3b67fdf2f849ce602ba0c11dc186ee0e19df45be09aadd3d61c7::reserve::withdraw_ctokens<T0, T2>(v5, v3);
        0x1ddd0621438e3b67fdf2f849ce602ba0c11dc186ee0e19df45be09aadd3d61c7::reserve::deduct_liquidation_fee<T0, T2>(v5, &mut v6);
        let v7 = LiquidateEvent<T0, T1, T2>{
            repay_amount    : v4,
            withdraw_amount : v3,
            obligation_id   : arg1,
            caller          : 0x2::tx_context::sender(arg6),
        };
        0x2::event::emit<LiquidateEvent<T0, T1, T2>>(v7);
        let v8 = RateLimiterExemption<T0, T2>{amount: 0x2::balance::value<0x1ddd0621438e3b67fdf2f849ce602ba0c11dc186ee0e19df45be09aadd3d61c7::reserve::CToken<T0, T2>>(&v6)};
        (0x2::coin::from_balance<0x1ddd0621438e3b67fdf2f849ce602ba0c11dc186ee0e19df45be09aadd3d61c7::reserve::CToken<T0, T2>>(v6, arg6), v8)
    }

    public fun obligation<T0>(arg0: &LendingMarket<T0>, arg1: 0x2::object::ID) : &0x1ddd0621438e3b67fdf2f849ce602ba0c11dc186ee0e19df45be09aadd3d61c7::obligation::Obligation<T0> {
        0x2::object_table::borrow<0x2::object::ID, 0x1ddd0621438e3b67fdf2f849ce602ba0c11dc186ee0e19df45be09aadd3d61c7::obligation::Obligation<T0>>(&arg0.obligations, arg1)
    }

    public fun obligation_id<T0>(arg0: &ObligationOwnerCap<T0>) : 0x2::object::ID {
        arg0.obligation_id
    }

    public fun redeem_ctokens_and_withdraw_liquidity<T0, T1>(arg0: &mut LendingMarket<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<0x1ddd0621438e3b67fdf2f849ce602ba0c11dc186ee0e19df45be09aadd3d61c7::reserve::CToken<T0, T1>>, arg4: 0x1::option::Option<RateLimiterExemption<T0, T1>>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(arg0.version == 1, 1);
        assert!(0x2::coin::value<0x1ddd0621438e3b67fdf2f849ce602ba0c11dc186ee0e19df45be09aadd3d61c7::reserve::CToken<T0, T1>>(&arg3) > 0, 2);
        let v0 = 0x2::coin::value<0x1ddd0621438e3b67fdf2f849ce602ba0c11dc186ee0e19df45be09aadd3d61c7::reserve::CToken<T0, T1>>(&arg3);
        let v1 = 0x1::vector::borrow_mut<0x1ddd0621438e3b67fdf2f849ce602ba0c11dc186ee0e19df45be09aadd3d61c7::reserve::Reserve<T0>>(&mut arg0.reserves, arg1);
        assert!(0x1ddd0621438e3b67fdf2f849ce602ba0c11dc186ee0e19df45be09aadd3d61c7::reserve::coin_type<T0>(v1) == 0x1::type_name::get<T1>(), 3);
        0x1ddd0621438e3b67fdf2f849ce602ba0c11dc186ee0e19df45be09aadd3d61c7::reserve::compound_interest<T0>(v1, arg2);
        let v2 = false;
        if (0x1::option::is_some<RateLimiterExemption<T0, T1>>(&arg4)) {
            if (0x1::option::borrow_mut<RateLimiterExemption<T0, T1>>(&mut arg4).amount >= v0) {
                v2 = true;
            };
        };
        if (!v2) {
            0x1ddd0621438e3b67fdf2f849ce602ba0c11dc186ee0e19df45be09aadd3d61c7::rate_limiter::process_qty(&mut arg0.rate_limiter, 0x2::clock::timestamp_ms(arg2) / 1000, 0x1ddd0621438e3b67fdf2f849ce602ba0c11dc186ee0e19df45be09aadd3d61c7::reserve::ctoken_market_value_upper_bound<T0>(v1, v0));
        };
        let v3 = 0x1ddd0621438e3b67fdf2f849ce602ba0c11dc186ee0e19df45be09aadd3d61c7::reserve::redeem_ctokens<T0, T1>(v1, 0x2::coin::into_balance<0x1ddd0621438e3b67fdf2f849ce602ba0c11dc186ee0e19df45be09aadd3d61c7::reserve::CToken<T0, T1>>(arg3));
        assert!(0x2::balance::value<T1>(&v3) > 0, 2);
        let v4 = RedeemEvent<T0, T1>{
            in_ctoken_amount     : v0,
            out_liquidity_amount : 0x2::balance::value<T1>(&v3),
            caller               : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<RedeemEvent<T0, T1>>(v4);
        0x2::coin::from_balance<T1>(v3, arg5)
    }

    public fun refresh_reserve_price<T0>(arg0: &mut LendingMarket<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject) {
        assert!(arg0.version == 1, 1);
        0x1ddd0621438e3b67fdf2f849ce602ba0c11dc186ee0e19df45be09aadd3d61c7::reserve::update_price<T0>(0x1::vector::borrow_mut<0x1ddd0621438e3b67fdf2f849ce602ba0c11dc186ee0e19df45be09aadd3d61c7::reserve::Reserve<T0>>(&mut arg0.reserves, arg1), arg2, arg3);
    }

    public fun repay<T0, T1>(arg0: &mut LendingMarket<T0>, arg1: u64, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock, arg4: 0x2::coin::Coin<T1>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 1);
        let v0 = RepayEvent<T0, T1>{
            liquidity_amount : 0x2::coin::value<T1>(&arg4),
            obligation_id    : arg2,
            caller           : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<RepayEvent<T0, T1>>(v0);
        let v1 = 0x2::object_table::borrow_mut<0x2::object::ID, 0x1ddd0621438e3b67fdf2f849ce602ba0c11dc186ee0e19df45be09aadd3d61c7::obligation::Obligation<T0>>(&mut arg0.obligations, arg2);
        let v2 = 0x1::vector::borrow_mut<0x1ddd0621438e3b67fdf2f849ce602ba0c11dc186ee0e19df45be09aadd3d61c7::reserve::Reserve<T0>>(&mut arg0.reserves, arg1);
        assert!(0x1ddd0621438e3b67fdf2f849ce602ba0c11dc186ee0e19df45be09aadd3d61c7::reserve::coin_type<T0>(v2) == 0x1::type_name::get<T1>(), 3);
        0x1ddd0621438e3b67fdf2f849ce602ba0c11dc186ee0e19df45be09aadd3d61c7::reserve::compound_interest<T0>(v2, arg3);
        0x1ddd0621438e3b67fdf2f849ce602ba0c11dc186ee0e19df45be09aadd3d61c7::obligation::repay<T0>(v1, v2, 0x1ddd0621438e3b67fdf2f849ce602ba0c11dc186ee0e19df45be09aadd3d61c7::decimal::from(0x2::coin::value<T1>(&arg4)));
        0x1ddd0621438e3b67fdf2f849ce602ba0c11dc186ee0e19df45be09aadd3d61c7::reserve::repay_liquidity<T0, T1>(v2, 0x2::coin::into_balance<T1>(arg4));
    }

    fun reserve_array_index<T0, T1>(arg0: &LendingMarket<T0>) : u64 {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1ddd0621438e3b67fdf2f849ce602ba0c11dc186ee0e19df45be09aadd3d61c7::reserve::Reserve<T0>>(&arg0.reserves)) {
            if (0x1ddd0621438e3b67fdf2f849ce602ba0c11dc186ee0e19df45be09aadd3d61c7::reserve::coin_type<T0>(0x1::vector::borrow<0x1ddd0621438e3b67fdf2f849ce602ba0c11dc186ee0e19df45be09aadd3d61c7::reserve::Reserve<T0>>(&arg0.reserves, v0)) == 0x1::type_name::get<T1>()) {
                return v0
            };
            v0 = v0 + 1;
        };
        v0
    }

    public fun share_lending_market<T0>(arg0: &LendingMarketOwnerCap<T0>, arg1: LendingMarket<T0>) {
        assert!(arg1.version == 1, 1);
        0x2::transfer::share_object<LendingMarket<T0>>(arg1);
    }

    public fun update_rate_limiter_config<T0>(arg0: &LendingMarketOwnerCap<T0>, arg1: &mut LendingMarket<T0>, arg2: &0x2::clock::Clock, arg3: 0x1ddd0621438e3b67fdf2f849ce602ba0c11dc186ee0e19df45be09aadd3d61c7::rate_limiter::RateLimiterConfig) {
        assert!(arg1.version == 1, 1);
        arg1.rate_limiter = 0x1ddd0621438e3b67fdf2f849ce602ba0c11dc186ee0e19df45be09aadd3d61c7::rate_limiter::new(arg3, 0x2::clock::timestamp_ms(arg2) / 1000);
    }

    public fun update_reserve_config<T0, T1>(arg0: &LendingMarketOwnerCap<T0>, arg1: &mut LendingMarket<T0>, arg2: u64, arg3: 0x1ddd0621438e3b67fdf2f849ce602ba0c11dc186ee0e19df45be09aadd3d61c7::reserve_config::ReserveConfig) {
        assert!(arg1.version == 1, 1);
        let v0 = 0x1::vector::borrow_mut<0x1ddd0621438e3b67fdf2f849ce602ba0c11dc186ee0e19df45be09aadd3d61c7::reserve::Reserve<T0>>(&mut arg1.reserves, arg2);
        assert!(0x1ddd0621438e3b67fdf2f849ce602ba0c11dc186ee0e19df45be09aadd3d61c7::reserve::coin_type<T0>(v0) == 0x1::type_name::get<T1>(), 3);
        0x1ddd0621438e3b67fdf2f849ce602ba0c11dc186ee0e19df45be09aadd3d61c7::reserve::update_reserve_config<T0>(v0, arg3);
    }

    public fun withdraw_ctokens<T0, T1>(arg0: &mut LendingMarket<T0>, arg1: u64, arg2: &ObligationOwnerCap<T0>, arg3: &0x2::clock::Clock, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x1ddd0621438e3b67fdf2f849ce602ba0c11dc186ee0e19df45be09aadd3d61c7::reserve::CToken<T0, T1>> {
        assert!(arg0.version == 1, 1);
        assert!(arg4 > 0, 2);
        let v0 = 0x2::object_table::borrow_mut<0x2::object::ID, 0x1ddd0621438e3b67fdf2f849ce602ba0c11dc186ee0e19df45be09aadd3d61c7::obligation::Obligation<T0>>(&mut arg0.obligations, arg2.obligation_id);
        0x1ddd0621438e3b67fdf2f849ce602ba0c11dc186ee0e19df45be09aadd3d61c7::obligation::refresh<T0>(v0, &mut arg0.reserves, arg3);
        let v1 = 0x1::vector::borrow_mut<0x1ddd0621438e3b67fdf2f849ce602ba0c11dc186ee0e19df45be09aadd3d61c7::reserve::Reserve<T0>>(&mut arg0.reserves, arg1);
        assert!(0x1ddd0621438e3b67fdf2f849ce602ba0c11dc186ee0e19df45be09aadd3d61c7::reserve::coin_type<T0>(v1) == 0x1::type_name::get<T1>(), 3);
        0x1ddd0621438e3b67fdf2f849ce602ba0c11dc186ee0e19df45be09aadd3d61c7::obligation::withdraw<T0>(v0, v1, arg4);
        let v2 = WithdrawEvent<T0, T1>{
            ctoken_amount : arg4,
            obligation_id : arg2.obligation_id,
            caller        : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<WithdrawEvent<T0, T1>>(v2);
        0x2::coin::from_balance<0x1ddd0621438e3b67fdf2f849ce602ba0c11dc186ee0e19df45be09aadd3d61c7::reserve::CToken<T0, T1>>(0x1ddd0621438e3b67fdf2f849ce602ba0c11dc186ee0e19df45be09aadd3d61c7::reserve::withdraw_ctokens<T0, T1>(v1, arg4), arg5)
    }

    // decompiled from Move bytecode v6
}

