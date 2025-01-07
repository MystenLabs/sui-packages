module 0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::lending_market {
    struct LendingMarket<phantom T0> has key {
        id: 0x2::object::UID,
        version: u64,
        reserves: vector<0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::reserve::Reserve<T0>>,
        obligations: 0x2::object_table::ObjectTable<0x2::object::ID, 0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::obligation::Obligation<T0>>,
        balances: 0x2::bag::Bag,
        rate_limiter: 0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::rate_limiter::RateLimiter,
    }

    struct LendingMarketOwnerCap<phantom T0> has store, key {
        id: 0x2::object::UID,
        lending_market_id: 0x2::object::ID,
    }

    struct ObligationOwnerCap<phantom T0> has store, key {
        id: 0x2::object::UID,
        obligation_id: 0x2::object::ID,
    }

    struct Balances<phantom T0, phantom T1> has store {
        reserve_id: u64,
        available_amount: 0x2::balance::Balance<T1>,
        ctoken_supply: 0x2::balance::Supply<CToken<T0, T1>>,
        deposited_ctokens: 0x2::balance::Balance<CToken<T0, T1>>,
        fees: 0x2::balance::Balance<T1>,
        ctoken_fees: 0x2::balance::Balance<CToken<T0, T1>>,
    }

    struct Name<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct CToken<phantom T0, phantom T1> has drop {
        dummy_field: bool,
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

    public fun borrow<T0, T1>(arg0: &mut LendingMarket<T0>, arg1: &ObligationOwnerCap<T0>, arg2: &0x2::clock::Clock, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(arg0.version == 1, 1);
        assert!(arg3 > 0, 2);
        let v0 = 0x2::object_table::borrow_mut<0x2::object::ID, 0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::obligation::Obligation<T0>>(&mut arg0.obligations, arg1.obligation_id);
        0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::obligation::refresh<T0>(v0, &mut arg0.reserves, arg2);
        let v1 = Name<T1>{dummy_field: false};
        let v2 = 0x2::bag::borrow_mut<Name<T1>, Balances<T0, T1>>(&mut arg0.balances, v1);
        let v3 = 0x1::vector::borrow_mut<0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::reserve::Reserve<T0>>(&mut arg0.reserves, v2.reserve_id);
        0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::reserve::compound_interest<T0>(v3, arg2);
        0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::reserve::assert_price_is_fresh<T0>(v3, arg2);
        let v4 = 0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::reserve::calculate_borrow_fee<T0>(v3, arg3);
        0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::reserve::borrow_liquidity<T0>(v3, arg3 + v4);
        0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::obligation::borrow<T0>(v0, v3, arg3 + v4);
        0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::rate_limiter::process_qty(&mut arg0.rate_limiter, 0x2::clock::timestamp_ms(arg2) / 1000, 0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::reserve::market_value_upper_bound<T0>(v3, 0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::decimal::from(arg3 + v4)));
        let v5 = BorrowEvent<T0, T1>{
            liquidity_amount : arg3 + v4,
            obligation_id    : arg1.obligation_id,
            caller           : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<BorrowEvent<T0, T1>>(v5);
        0x2::balance::join<T1>(&mut v2.fees, 0x2::balance::split<T1>(&mut v2.available_amount, v4));
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v2.available_amount, arg3), arg4)
    }

    public fun add_reserve<T0, T1>(arg0: &LendingMarketOwnerCap<T0>, arg1: &mut LendingMarket<T0>, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: 0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::reserve_config::ReserveConfig, arg4: &0x2::coin::CoinMetadata<T1>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 1, 1);
        0x1::vector::push_back<0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::reserve::Reserve<T0>>(&mut arg1.reserves, 0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::reserve::create_reserve<T0, T1>(arg3, arg4, arg2, arg5, arg6));
        let v0 = Name<T1>{dummy_field: false};
        let v1 = CToken<T0, T1>{dummy_field: false};
        let v2 = Balances<T0, T1>{
            reserve_id        : 0x1::vector::length<0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::reserve::Reserve<T0>>(&arg1.reserves),
            available_amount  : 0x2::balance::zero<T1>(),
            ctoken_supply     : 0x2::balance::create_supply<CToken<T0, T1>>(v1),
            deposited_ctokens : 0x2::balance::zero<CToken<T0, T1>>(),
            fees              : 0x2::balance::zero<T1>(),
            ctoken_fees       : 0x2::balance::zero<CToken<T0, T1>>(),
        };
        0x2::bag::add<Name<T1>, Balances<T0, T1>>(&mut arg1.balances, v0, v2);
    }

    public fun claim_fees<T0, T1>(arg0: &LendingMarketOwnerCap<T0>, arg1: &mut LendingMarket<T0>, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<CToken<T0, T1>>, 0x2::coin::Coin<T1>) {
        assert!(arg1.version == 1, 1);
        let (v0, v1) = get_reserve_mut<T0, T1>(arg1);
        let v2 = 0x2::balance::withdraw_all<T1>(&mut v1.fees);
        0x2::balance::join<T1>(&mut v2, 0x2::balance::split<T1>(&mut v1.available_amount, 0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::reserve::claim_spread_fees<T0>(v0)));
        (0x2::coin::from_balance<CToken<T0, T1>>(0x2::balance::withdraw_all<CToken<T0, T1>>(&mut v1.ctoken_fees), arg2), 0x2::coin::from_balance<T1>(v2, arg2))
    }

    public fun create_lending_market<T0: drop>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) : (LendingMarketOwnerCap<T0>, LendingMarket<T0>) {
        assert!(0x2::types::is_one_time_witness<T0>(&arg0), 0);
        let v0 = LendingMarket<T0>{
            id           : 0x2::object::new(arg1),
            version      : 1,
            reserves     : 0x1::vector::empty<0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::reserve::Reserve<T0>>(),
            obligations  : 0x2::object_table::new<0x2::object::ID, 0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::obligation::Obligation<T0>>(arg1),
            balances     : 0x2::bag::new(arg1),
            rate_limiter : 0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::rate_limiter::new(0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::rate_limiter::new_config(1, 18446744073709551615), 0),
        };
        let v1 = LendingMarketOwnerCap<T0>{
            id                : 0x2::object::new(arg1),
            lending_market_id : 0x2::object::id<LendingMarket<T0>>(&v0),
        };
        (v1, v0)
    }

    public fun create_obligation<T0>(arg0: &mut LendingMarket<T0>, arg1: &mut 0x2::tx_context::TxContext) : ObligationOwnerCap<T0> {
        assert!(arg0.version == 1, 1);
        let v0 = 0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::obligation::create_obligation<T0>(arg1);
        let v1 = ObligationOwnerCap<T0>{
            id            : 0x2::object::new(arg1),
            obligation_id : 0x2::object::id<0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::obligation::Obligation<T0>>(&v0),
        };
        0x2::object_table::add<0x2::object::ID, 0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::obligation::Obligation<T0>>(&mut arg0.obligations, 0x2::object::id<0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::obligation::Obligation<T0>>(&v0), v0);
        v1
    }

    public fun deposit_ctokens_into_obligation<T0, T1>(arg0: &mut LendingMarket<T0>, arg1: &ObligationOwnerCap<T0>, arg2: 0x2::coin::Coin<CToken<T0, T1>>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 1);
        assert!(0x2::coin::value<CToken<T0, T1>>(&arg2) > 0, 2);
        let v0 = Name<T1>{dummy_field: false};
        let v1 = 0x2::bag::borrow_mut<Name<T1>, Balances<T0, T1>>(&mut arg0.balances, v0);
        0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::obligation::deposit<T0>(0x2::object_table::borrow_mut<0x2::object::ID, 0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::obligation::Obligation<T0>>(&mut arg0.obligations, arg1.obligation_id), 0x1::vector::borrow<0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::reserve::Reserve<T0>>(&arg0.reserves, v1.reserve_id), 0x2::coin::value<CToken<T0, T1>>(&arg2));
        let v2 = DepositEvent<T0, T1>{
            ctoken_amount : 0x2::coin::value<CToken<T0, T1>>(&arg2),
            obligation_id : arg1.obligation_id,
            caller        : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<DepositEvent<T0, T1>>(v2);
        0x2::balance::join<CToken<T0, T1>>(&mut v1.deposited_ctokens, 0x2::coin::into_balance<CToken<T0, T1>>(arg2));
    }

    public fun deposit_liquidity_and_mint_ctokens<T0, T1>(arg0: &mut LendingMarket<T0>, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<CToken<T0, T1>> {
        assert!(arg0.version == 1, 1);
        assert!(0x2::coin::value<T1>(&arg2) > 0, 2);
        let (v0, v1) = get_reserve_mut<T0, T1>(arg0);
        0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::reserve::compound_interest<T0>(v0, arg1);
        let v2 = 0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::reserve::deposit_liquidity_and_mint_ctokens<T0>(v0, 0x2::coin::value<T1>(&arg2));
        assert!(v2 > 0, 2);
        let v3 = MintEvent<T0, T1>{
            in_liquidity_amount : 0x2::coin::value<T1>(&arg2),
            out_ctoken_amount   : v2,
            caller              : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<MintEvent<T0, T1>>(v3);
        0x2::balance::join<T1>(&mut v1.available_amount, 0x2::coin::into_balance<T1>(arg2));
        0x2::coin::from_balance<CToken<T0, T1>>(0x2::balance::increase_supply<CToken<T0, T1>>(&mut v1.ctoken_supply, v2), arg3)
    }

    fun get_reserve_mut<T0, T1>(arg0: &mut LendingMarket<T0>) : (&mut 0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::reserve::Reserve<T0>, &mut Balances<T0, T1>) {
        let v0 = Name<T1>{dummy_field: false};
        let v1 = 0x2::bag::borrow_mut<Name<T1>, Balances<T0, T1>>(&mut arg0.balances, v0);
        (0x1::vector::borrow_mut<0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::reserve::Reserve<T0>>(&mut arg0.reserves, v1.reserve_id), v1)
    }

    public fun liquidate<T0, T1, T2>(arg0: &mut LendingMarket<T0>, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<T1>, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<CToken<T0, T2>>) {
        assert!(arg0.version == 1, 1);
        assert!(0x2::coin::value<T1>(&arg3) > 0, 2);
        let v0 = 0x2::object_table::borrow_mut<0x2::object::ID, 0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::obligation::Obligation<T0>>(&mut arg0.obligations, arg1);
        0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::obligation::refresh<T0>(v0, &mut arg0.reserves, arg2);
        let v1 = Name<T1>{dummy_field: false};
        let v2 = Name<T1>{dummy_field: false};
        let v3 = 0x1::vector::borrow<0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::reserve::Reserve<T0>>(&arg0.reserves, 0x2::bag::borrow<Name<T1>, Balances<T0, T1>>(&arg0.balances, v2).reserve_id);
        let (v4, v5) = 0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::obligation::liquidate<T0>(v0, 0x1::vector::borrow<0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::reserve::Reserve<T0>>(&arg0.reserves, 0x2::bag::borrow<Name<T1>, Balances<T0, T1>>(&arg0.balances, v1).reserve_id), v3, 0x2::coin::value<T1>(&arg3));
        assert!(v4 > 0, 2);
        assert!(v5 > 0, 2);
        let (v6, v7) = get_reserve_mut<T0, T1>(arg0);
        0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::reserve::repay_liquidity<T0>(v6, v5);
        0x2::balance::join<T1>(&mut v7.available_amount, 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg3, v5, arg4)));
        let (_, v9) = get_reserve_mut<T0, T2>(arg0);
        let v10 = 0x2::balance::split<CToken<T0, T2>>(&mut v9.deposited_ctokens, v4);
        0x2::balance::join<CToken<T0, T2>>(&mut v9.ctoken_fees, 0x2::balance::split<CToken<T0, T2>>(&mut v10, 0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::reserve::calculate_liquidation_fee<T0>(v3, v4)));
        let v11 = LiquidateEvent<T0, T1, T2>{
            repay_amount    : v5,
            withdraw_amount : v4,
            obligation_id   : arg1,
            caller          : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<LiquidateEvent<T0, T1, T2>>(v11);
        (arg3, 0x2::coin::from_balance<CToken<T0, T2>>(v10, arg4))
    }

    public fun obligation_id<T0>(arg0: &ObligationOwnerCap<T0>) : 0x2::object::ID {
        arg0.obligation_id
    }

    public fun redeem_ctokens_and_withdraw_liquidity<T0, T1>(arg0: &mut LendingMarket<T0>, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<CToken<T0, T1>>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(arg0.version == 1, 1);
        assert!(0x2::coin::value<CToken<T0, T1>>(&arg2) > 0, 2);
        let (v0, v1) = get_reserve_mut<T0, T1>(arg0);
        0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::reserve::compound_interest<T0>(v0, arg1);
        let v2 = 0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::reserve::redeem_ctokens<T0>(v0, 0x2::coin::value<CToken<T0, T1>>(&arg2));
        assert!(v2 > 0, 2);
        let v3 = RedeemEvent<T0, T1>{
            in_ctoken_amount     : 0x2::coin::value<CToken<T0, T1>>(&arg2),
            out_liquidity_amount : v2,
            caller               : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<RedeemEvent<T0, T1>>(v3);
        0x2::balance::decrease_supply<CToken<T0, T1>>(&mut v1.ctoken_supply, 0x2::coin::into_balance<CToken<T0, T1>>(arg2));
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v1.available_amount, v2), arg3)
    }

    public fun refresh_reserve_price<T0, T1>(arg0: &mut LendingMarket<T0>, arg1: &0x2::clock::Clock, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject) {
        assert!(arg0.version == 1, 1);
        let (v0, _) = get_reserve_mut<T0, T1>(arg0);
        0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::reserve::update_price<T0>(v0, arg1, arg2);
    }

    public fun repay<T0, T1>(arg0: &mut LendingMarket<T0>, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<T1>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 1);
        let v0 = Name<T1>{dummy_field: false};
        let v1 = 0x2::bag::borrow_mut<Name<T1>, Balances<T0, T1>>(&mut arg0.balances, v0);
        let v2 = 0x1::vector::borrow_mut<0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::reserve::Reserve<T0>>(&mut arg0.reserves, v1.reserve_id);
        0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::reserve::compound_interest<T0>(v2, arg2);
        0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::reserve::repay_liquidity<T0>(v2, 0x2::coin::value<T1>(&arg3));
        0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::obligation::repay<T0>(0x2::object_table::borrow_mut<0x2::object::ID, 0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::obligation::Obligation<T0>>(&mut arg0.obligations, arg1), v2, 0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::decimal::from(0x2::coin::value<T1>(&arg3)));
        let v3 = RepayEvent<T0, T1>{
            liquidity_amount : 0x2::coin::value<T1>(&arg3),
            obligation_id    : arg1,
            caller           : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<RepayEvent<T0, T1>>(v3);
        0x2::balance::join<T1>(&mut v1.available_amount, 0x2::coin::into_balance<T1>(arg3));
    }

    public fun share_lending_market<T0>(arg0: &LendingMarketOwnerCap<T0>, arg1: LendingMarket<T0>) {
        assert!(arg1.version == 1, 1);
        0x2::transfer::share_object<LendingMarket<T0>>(arg1);
    }

    public fun update_reserve_config<T0, T1>(arg0: &LendingMarketOwnerCap<T0>, arg1: &mut LendingMarket<T0>, arg2: 0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::reserve_config::ReserveConfig) {
        assert!(arg1.version == 1, 1);
        let (v0, _) = get_reserve_mut<T0, T1>(arg1);
        0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::reserve::update_reserve_config<T0>(v0, arg2);
    }

    public fun withdraw_ctokens<T0, T1>(arg0: &mut LendingMarket<T0>, arg1: &ObligationOwnerCap<T0>, arg2: &0x2::clock::Clock, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<CToken<T0, T1>> {
        assert!(arg0.version == 1, 1);
        assert!(arg3 > 0, 2);
        let v0 = 0x2::object_table::borrow_mut<0x2::object::ID, 0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::obligation::Obligation<T0>>(&mut arg0.obligations, arg1.obligation_id);
        0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::obligation::refresh<T0>(v0, &mut arg0.reserves, arg2);
        let v1 = Name<T1>{dummy_field: false};
        let v2 = 0x2::bag::borrow_mut<Name<T1>, Balances<T0, T1>>(&mut arg0.balances, v1);
        let v3 = 0x1::vector::borrow_mut<0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::reserve::Reserve<T0>>(&mut arg0.reserves, v2.reserve_id);
        0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::obligation::withdraw<T0>(v0, v3, arg3);
        0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::rate_limiter::process_qty(&mut arg0.rate_limiter, 0x2::clock::timestamp_ms(arg2) / 1000, 0x2c6c5820d8a2e5905fd8be6ffa5dd7d4ebf0d12820a79c5c5edd09302f2a07c3::reserve::ctoken_market_value_upper_bound<T0>(v3, arg3));
        let v4 = WithdrawEvent<T0, T1>{
            ctoken_amount : arg3,
            obligation_id : arg1.obligation_id,
            caller        : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<WithdrawEvent<T0, T1>>(v4);
        0x2::coin::from_balance<CToken<T0, T1>>(0x2::balance::split<CToken<T0, T1>>(&mut v2.deposited_ctokens, arg3), arg4)
    }

    // decompiled from Move bytecode v6
}

