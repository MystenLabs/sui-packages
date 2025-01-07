module 0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::lending_market {
    struct LENDING_MARKET has drop {
        dummy_field: bool,
    }

    struct LendingMarket<phantom T0> has store, key {
        id: 0x2::object::UID,
        version: u64,
        reserves: vector<0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::reserve::Reserve<T0>>,
        obligations: 0x2::object_table::ObjectTable<0x2::object::ID, 0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::obligation::Obligation<T0>>,
        rate_limiter: 0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::rate_limiter::RateLimiter,
        fee_receiver: address,
        bad_debt_usd: 0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::decimal::Decimal,
        bad_debt_limit_usd: 0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::decimal::Decimal,
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

    struct MintEvent has copy, drop {
        lending_market: 0x1::type_name::TypeName,
        coin_type: 0x1::type_name::TypeName,
        reserve_id: address,
        liquidity_amount: u64,
        ctoken_amount: u64,
    }

    struct RedeemEvent has copy, drop {
        lending_market: 0x1::type_name::TypeName,
        coin_type: 0x1::type_name::TypeName,
        reserve_id: address,
        ctoken_amount: u64,
        liquidity_amount: u64,
    }

    struct DepositEvent has copy, drop {
        lending_market: 0x1::type_name::TypeName,
        coin_type: 0x1::type_name::TypeName,
        reserve_id: address,
        obligation_id: address,
        ctoken_amount: u64,
    }

    struct WithdrawEvent has copy, drop {
        lending_market: 0x1::type_name::TypeName,
        coin_type: 0x1::type_name::TypeName,
        reserve_id: address,
        obligation_id: address,
        ctoken_amount: u64,
    }

    struct BorrowEvent has copy, drop {
        lending_market: 0x1::type_name::TypeName,
        coin_type: 0x1::type_name::TypeName,
        reserve_id: address,
        obligation_id: address,
        liquidity_amount: u64,
        origination_fee_amount: u64,
    }

    struct RepayEvent has copy, drop {
        lending_market: 0x1::type_name::TypeName,
        coin_type: 0x1::type_name::TypeName,
        reserve_id: address,
        obligation_id: address,
        liquidity_amount: u64,
    }

    struct LiquidateEvent has copy, drop {
        lending_market: 0x1::type_name::TypeName,
        repay_reserve_id: address,
        withdraw_reserve_id: address,
        obligation_id: address,
        repay_amount: u64,
        withdraw_amount: u64,
        protocol_fee_amount: u64,
        liquidator_bonus_amount: u64,
    }

    public fun borrow<T0, T1>(arg0: &mut LendingMarket<T0>, arg1: u64, arg2: &ObligationOwnerCap<T0>, arg3: &0x2::clock::Clock, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(arg0.version == 1, 1);
        assert!(arg4 > 0, 2);
        let v0 = 0x2::object_table::borrow_mut<0x2::object::ID, 0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::obligation::Obligation<T0>>(&mut arg0.obligations, arg2.obligation_id);
        0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::obligation::refresh<T0>(v0, &mut arg0.reserves, arg3);
        let v1 = 0x1::vector::borrow_mut<0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::reserve::Reserve<T0>>(&mut arg0.reserves, arg1);
        assert!(0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::reserve::coin_type<T0>(v1) == 0x1::type_name::get<T1>(), 3);
        0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::reserve::compound_interest<T0>(v1, arg3);
        0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::reserve::assert_price_is_fresh<T0>(v1, arg3);
        let (v2, v3) = 0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::reserve::borrow_liquidity<T0, T1>(v1, arg4);
        let v4 = v2;
        0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::obligation::borrow<T0>(v0, v1, arg3, v3);
        0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::rate_limiter::process_qty(&mut arg0.rate_limiter, 0x2::clock::timestamp_ms(arg3) / 1000, 0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::reserve::market_value_upper_bound<T0>(v1, 0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::decimal::from(v3)));
        let v5 = BorrowEvent{
            lending_market         : 0x1::type_name::get<T0>(),
            coin_type              : 0x1::type_name::get<T1>(),
            reserve_id             : 0x2::object::id_address<0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::reserve::Reserve<T0>>(v1),
            obligation_id          : 0x2::object::id_address<0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::obligation::Obligation<T0>>(v0),
            liquidity_amount       : v3,
            origination_fee_amount : v3 - 0x2::balance::value<T1>(&v4),
        };
        0x2::event::emit<BorrowEvent>(v5);
        0x2::coin::from_balance<T1>(v4, arg5)
    }

    public fun add_pool_reward<T0, T1>(arg0: &LendingMarketOwnerCap<T0>, arg1: &mut LendingMarket<T0>, arg2: u64, arg3: bool, arg4: 0x2::coin::Coin<T1>, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg3) {
            0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::reserve::deposits_pool_reward_manager_mut<T0>(0x1::vector::borrow_mut<0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::reserve::Reserve<T0>>(&mut arg1.reserves, arg2))
        } else {
            0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::reserve::borrows_pool_reward_manager_mut<T0>(0x1::vector::borrow_mut<0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::reserve::Reserve<T0>>(&mut arg1.reserves, arg2))
        };
        0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::liquidity_mining::add_pool_reward<T1>(v0, 0x2::coin::into_balance<T1>(arg4), arg5, arg6, arg7, arg8);
    }

    public fun add_reserve<T0, T1>(arg0: &LendingMarketOwnerCap<T0>, arg1: &mut LendingMarket<T0>, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: 0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::reserve_config::ReserveConfig, arg4: &0x2::coin::CoinMetadata<T1>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 1, 1);
        assert!(reserve_array_index<T0, T1>(arg1) == 0x1::vector::length<0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::reserve::Reserve<T0>>(&arg1.reserves), 4);
        0x1::vector::push_back<0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::reserve::Reserve<T0>>(&mut arg1.reserves, 0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::reserve::create_reserve<T0, T1>(arg3, 0x1::vector::length<0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::reserve::Reserve<T0>>(&arg1.reserves), arg4, arg2, arg5, arg6));
    }

    public fun cancel_pool_reward<T0, T1>(arg0: &LendingMarketOwnerCap<T0>, arg1: &mut LendingMarket<T0>, arg2: u64, arg3: bool, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = if (arg3) {
            0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::reserve::deposits_pool_reward_manager_mut<T0>(0x1::vector::borrow_mut<0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::reserve::Reserve<T0>>(&mut arg1.reserves, arg2))
        } else {
            0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::reserve::borrows_pool_reward_manager_mut<T0>(0x1::vector::borrow_mut<0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::reserve::Reserve<T0>>(&mut arg1.reserves, arg2))
        };
        0x2::coin::from_balance<T1>(0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::liquidity_mining::cancel_pool_reward<T1>(v0, arg4, arg5), arg6)
    }

    entry fun claim_fees<T0, T1>(arg0: &mut LendingMarket<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 1);
        let v0 = 0x1::vector::borrow_mut<0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::reserve::Reserve<T0>>(&mut arg0.reserves, arg1);
        assert!(0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::reserve::coin_type<T0>(v0) == 0x1::type_name::get<T1>(), 3);
        let (v1, v2) = 0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::reserve::claim_fees<T0, T1>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::reserve::CToken<T0, T1>>>(0x2::coin::from_balance<0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::reserve::CToken<T0, T1>>(v1, arg2), arg0.fee_receiver);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v2, arg2), arg0.fee_receiver);
    }

    public fun claim_rewards<T0, T1>(arg0: &mut LendingMarket<T0>, arg1: &ObligationOwnerCap<T0>, arg2: &0x2::clock::Clock, arg3: u64, arg4: u64, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        claim_rewards_by_obligation_id<T0, T1>(arg0, arg1.obligation_id, arg2, arg3, arg4, arg5, arg6)
    }

    public fun claim_rewards_and_deposit<T0, T1>(arg0: &mut LendingMarket<T0>, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock, arg3: u64, arg4: u64, arg5: bool, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = claim_rewards_by_obligation_id<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg7);
        if (0x2::coin::value<T1>(&v0) == 0) {
            0x2::coin::destroy_zero<T1>(v0);
            return
        };
        let v1 = deposit_liquidity_and_mint_ctokens<T0, T1>(arg0, arg6, arg2, v0, arg7);
        if (0x2::coin::value<0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::reserve::CToken<T0, T1>>(&v1) == 0) {
            0x2::coin::destroy_zero<0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::reserve::CToken<T0, T1>>(v1);
            return
        };
        deposit_ctokens_into_obligation_by_id<T0, T1>(arg0, arg6, arg1, arg2, v1, arg7);
    }

    fun claim_rewards_by_obligation_id<T0, T1>(arg0: &mut LendingMarket<T0>, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock, arg3: u64, arg4: u64, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x1::vector::borrow_mut<0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::reserve::Reserve<T0>>(&mut arg0.reserves, arg3);
        0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::reserve::compound_interest<T0>(v0, arg2);
        let v1 = if (arg5) {
            0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::reserve::deposits_pool_reward_manager_mut<T0>(v0)
        } else {
            0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::reserve::borrows_pool_reward_manager_mut<T0>(v0)
        };
        0x2::coin::from_balance<T1>(0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::obligation::claim_rewards<T0, T1>(0x2::object_table::borrow_mut<0x2::object::ID, 0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::obligation::Obligation<T0>>(&mut arg0.obligations, arg1), v1, arg2, arg4), arg6)
    }

    public fun close_pool_reward<T0, T1>(arg0: &LendingMarketOwnerCap<T0>, arg1: &mut LendingMarket<T0>, arg2: u64, arg3: bool, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = if (arg3) {
            0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::reserve::deposits_pool_reward_manager_mut<T0>(0x1::vector::borrow_mut<0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::reserve::Reserve<T0>>(&mut arg1.reserves, arg2))
        } else {
            0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::reserve::borrows_pool_reward_manager_mut<T0>(0x1::vector::borrow_mut<0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::reserve::Reserve<T0>>(&mut arg1.reserves, arg2))
        };
        0x2::coin::from_balance<T1>(0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::liquidity_mining::close_pool_reward<T1>(v0, arg4, arg5), arg6)
    }

    public(friend) fun create_lending_market<T0>(arg0: &mut 0x2::tx_context::TxContext) : (LendingMarketOwnerCap<T0>, LendingMarket<T0>) {
        let v0 = LendingMarket<T0>{
            id                 : 0x2::object::new(arg0),
            version            : 1,
            reserves           : 0x1::vector::empty<0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::reserve::Reserve<T0>>(),
            obligations        : 0x2::object_table::new<0x2::object::ID, 0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::obligation::Obligation<T0>>(arg0),
            rate_limiter       : 0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::rate_limiter::new(0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::rate_limiter::new_config(1, 18446744073709551615), 0),
            fee_receiver       : 0x2::tx_context::sender(arg0),
            bad_debt_usd       : 0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::decimal::from(0),
            bad_debt_limit_usd : 0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::decimal::from(0),
        };
        let v1 = LendingMarketOwnerCap<T0>{
            id                : 0x2::object::new(arg0),
            lending_market_id : 0x2::object::id<LendingMarket<T0>>(&v0),
        };
        (v1, v0)
    }

    public fun create_obligation<T0>(arg0: &mut LendingMarket<T0>, arg1: &mut 0x2::tx_context::TxContext) : ObligationOwnerCap<T0> {
        assert!(arg0.version == 1, 1);
        let v0 = 0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::obligation::create_obligation<T0>(arg1);
        let v1 = ObligationOwnerCap<T0>{
            id            : 0x2::object::new(arg1),
            obligation_id : 0x2::object::id<0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::obligation::Obligation<T0>>(&v0),
        };
        0x2::object_table::add<0x2::object::ID, 0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::obligation::Obligation<T0>>(&mut arg0.obligations, 0x2::object::id<0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::obligation::Obligation<T0>>(&v0), v0);
        v1
    }

    public fun deposit_ctokens_into_obligation<T0, T1>(arg0: &mut LendingMarket<T0>, arg1: u64, arg2: &ObligationOwnerCap<T0>, arg3: &0x2::clock::Clock, arg4: 0x2::coin::Coin<0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::reserve::CToken<T0, T1>>, arg5: &mut 0x2::tx_context::TxContext) {
        deposit_ctokens_into_obligation_by_id<T0, T1>(arg0, arg1, arg2.obligation_id, arg3, arg4, arg5);
    }

    fun reserve<T0, T1>(arg0: &LendingMarket<T0>) : &0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::reserve::Reserve<T0> {
        0x1::vector::borrow<0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::reserve::Reserve<T0>>(&arg0.reserves, reserve_array_index<T0, T1>(arg0))
    }

    fun deposit_ctokens_into_obligation_by_id<T0, T1>(arg0: &mut LendingMarket<T0>, arg1: u64, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock, arg4: 0x2::coin::Coin<0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::reserve::CToken<T0, T1>>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 1);
        assert!(0x2::coin::value<0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::reserve::CToken<T0, T1>>(&arg4) > 0, 2);
        let v0 = 0x1::vector::borrow_mut<0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::reserve::Reserve<T0>>(&mut arg0.reserves, arg1);
        assert!(0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::reserve::coin_type<T0>(v0) == 0x1::type_name::get<T1>(), 3);
        let v1 = 0x2::object_table::borrow_mut<0x2::object::ID, 0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::obligation::Obligation<T0>>(&mut arg0.obligations, arg2);
        let v2 = DepositEvent{
            lending_market : 0x1::type_name::get<T0>(),
            coin_type      : 0x1::type_name::get<T1>(),
            reserve_id     : 0x2::object::id_address<0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::reserve::Reserve<T0>>(v0),
            obligation_id  : 0x2::object::id_address<0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::obligation::Obligation<T0>>(v1),
            ctoken_amount  : 0x2::coin::value<0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::reserve::CToken<T0, T1>>(&arg4),
        };
        0x2::event::emit<DepositEvent>(v2);
        0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::obligation::deposit<T0>(v1, v0, arg3, 0x2::coin::value<0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::reserve::CToken<T0, T1>>(&arg4));
        0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::reserve::deposit_ctokens<T0, T1>(v0, 0x2::coin::into_balance<0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::reserve::CToken<T0, T1>>(arg4));
    }

    public fun deposit_liquidity_and_mint_ctokens<T0, T1>(arg0: &mut LendingMarket<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<T1>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::reserve::CToken<T0, T1>> {
        assert!(arg0.version == 1, 1);
        assert!(0x2::coin::value<T1>(&arg3) > 0, 2);
        let v0 = 0x1::vector::borrow_mut<0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::reserve::Reserve<T0>>(&mut arg0.reserves, arg1);
        assert!(0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::reserve::coin_type<T0>(v0) == 0x1::type_name::get<T1>(), 3);
        0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::reserve::compound_interest<T0>(v0, arg2);
        let v1 = 0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::reserve::deposit_liquidity_and_mint_ctokens<T0, T1>(v0, 0x2::coin::into_balance<T1>(arg3));
        assert!(0x2::balance::value<0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::reserve::CToken<T0, T1>>(&v1) > 0, 2);
        let v2 = MintEvent{
            lending_market   : 0x1::type_name::get<T0>(),
            coin_type        : 0x1::type_name::get<T1>(),
            reserve_id       : 0x2::object::id_address<0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::reserve::Reserve<T0>>(v0),
            liquidity_amount : 0x2::coin::value<T1>(&arg3),
            ctoken_amount    : 0x2::balance::value<0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::reserve::CToken<T0, T1>>(&v1),
        };
        0x2::event::emit<MintEvent>(v2);
        0x2::coin::from_balance<0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::reserve::CToken<T0, T1>>(v1, arg4)
    }

    fun init(arg0: LENDING_MARKET, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<LENDING_MARKET>(arg0, arg1);
    }

    public fun liquidate<T0, T1, T2>(arg0: &mut LendingMarket<T0>, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::coin::Coin<T1>, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::reserve::CToken<T0, T2>>, RateLimiterExemption<T0, T2>) {
        assert!(arg0.version == 1, 1);
        assert!(0x2::coin::value<T1>(arg5) > 0, 2);
        let v0 = 0x2::object_table::borrow_mut<0x2::object::ID, 0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::obligation::Obligation<T0>>(&mut arg0.obligations, arg1);
        0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::obligation::refresh<T0>(v0, &mut arg0.reserves, arg4);
        let (v1, v2) = 0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::obligation::liquidate<T0>(v0, &mut arg0.reserves, arg2, arg3, arg4, 0x2::coin::value<T1>(arg5));
        assert!(v1 > 0, 2);
        assert!(0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::decimal::gt(v2, 0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::decimal::from(0)), 2);
        let v3 = 0x1::vector::borrow_mut<0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::reserve::Reserve<T0>>(&mut arg0.reserves, arg2);
        assert!(0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::reserve::coin_type<T0>(v3) == 0x1::type_name::get<T1>(), 3);
        0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::reserve::repay_liquidity<T0, T1>(v3, 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(arg5, 0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::decimal::ceil(v2), arg6)), v2);
        let v4 = 0x1::vector::borrow_mut<0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::reserve::Reserve<T0>>(&mut arg0.reserves, arg3);
        assert!(0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::reserve::coin_type<T0>(v4) == 0x1::type_name::get<T2>(), 3);
        let v5 = 0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::reserve::withdraw_ctokens<T0, T2>(v4, v1);
        let (v6, v7) = 0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::reserve::deduct_liquidation_fee<T0, T2>(v4, &mut v5);
        let v8 = LiquidateEvent{
            lending_market          : 0x1::type_name::get<T0>(),
            repay_reserve_id        : 0x2::object::id_address<0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::reserve::Reserve<T0>>(0x1::vector::borrow<0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::reserve::Reserve<T0>>(&arg0.reserves, arg2)),
            withdraw_reserve_id     : 0x2::object::id_address<0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::reserve::Reserve<T0>>(0x1::vector::borrow<0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::reserve::Reserve<T0>>(&arg0.reserves, arg3)),
            obligation_id           : 0x2::object::id_address<0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::obligation::Obligation<T0>>(v0),
            repay_amount            : 0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::decimal::ceil(v2),
            withdraw_amount         : v1,
            protocol_fee_amount     : v6,
            liquidator_bonus_amount : v7,
        };
        0x2::event::emit<LiquidateEvent>(v8);
        let v9 = RateLimiterExemption<T0, T2>{amount: 0x2::balance::value<0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::reserve::CToken<T0, T2>>(&v5)};
        (0x2::coin::from_balance<0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::reserve::CToken<T0, T2>>(v5, arg6), v9)
    }

    public fun obligation<T0>(arg0: &LendingMarket<T0>, arg1: 0x2::object::ID) : &0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::obligation::Obligation<T0> {
        0x2::object_table::borrow<0x2::object::ID, 0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::obligation::Obligation<T0>>(&arg0.obligations, arg1)
    }

    public fun obligation_id<T0>(arg0: &ObligationOwnerCap<T0>) : 0x2::object::ID {
        arg0.obligation_id
    }

    public fun redeem_ctokens_and_withdraw_liquidity<T0, T1>(arg0: &mut LendingMarket<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::reserve::CToken<T0, T1>>, arg4: 0x1::option::Option<RateLimiterExemption<T0, T1>>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(arg0.version == 1, 1);
        assert!(0x2::coin::value<0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::reserve::CToken<T0, T1>>(&arg3) > 0, 2);
        let v0 = 0x2::coin::value<0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::reserve::CToken<T0, T1>>(&arg3);
        let v1 = 0x1::vector::borrow_mut<0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::reserve::Reserve<T0>>(&mut arg0.reserves, arg1);
        assert!(0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::reserve::coin_type<T0>(v1) == 0x1::type_name::get<T1>(), 3);
        0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::reserve::compound_interest<T0>(v1, arg2);
        let v2 = false;
        if (0x1::option::is_some<RateLimiterExemption<T0, T1>>(&arg4)) {
            if (0x1::option::borrow_mut<RateLimiterExemption<T0, T1>>(&mut arg4).amount >= v0) {
                v2 = true;
            };
        };
        if (!v2) {
            0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::rate_limiter::process_qty(&mut arg0.rate_limiter, 0x2::clock::timestamp_ms(arg2) / 1000, 0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::reserve::ctoken_market_value_upper_bound<T0>(v1, v0));
        };
        let v3 = 0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::reserve::redeem_ctokens<T0, T1>(v1, 0x2::coin::into_balance<0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::reserve::CToken<T0, T1>>(arg3));
        assert!(0x2::balance::value<T1>(&v3) > 0, 2);
        let v4 = RedeemEvent{
            lending_market   : 0x1::type_name::get<T0>(),
            coin_type        : 0x1::type_name::get<T1>(),
            reserve_id       : 0x2::object::id_address<0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::reserve::Reserve<T0>>(v1),
            ctoken_amount    : v0,
            liquidity_amount : 0x2::balance::value<T1>(&v3),
        };
        0x2::event::emit<RedeemEvent>(v4);
        0x2::coin::from_balance<T1>(v3, arg5)
    }

    public fun refresh_reserve_price<T0>(arg0: &mut LendingMarket<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject) {
        assert!(arg0.version == 1, 1);
        0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::reserve::update_price<T0>(0x1::vector::borrow_mut<0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::reserve::Reserve<T0>>(&mut arg0.reserves, arg1), arg2, arg3);
    }

    public fun repay<T0, T1>(arg0: &mut LendingMarket<T0>, arg1: u64, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock, arg4: &mut 0x2::coin::Coin<T1>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 1);
        let v0 = 0x2::object_table::borrow_mut<0x2::object::ID, 0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::obligation::Obligation<T0>>(&mut arg0.obligations, arg2);
        let v1 = 0x1::vector::borrow_mut<0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::reserve::Reserve<T0>>(&mut arg0.reserves, arg1);
        assert!(0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::reserve::coin_type<T0>(v1) == 0x1::type_name::get<T1>(), 3);
        0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::reserve::compound_interest<T0>(v1, arg3);
        let v2 = 0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::obligation::repay<T0>(v0, v1, arg3, 0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::decimal::from(0x2::coin::value<T1>(arg4)));
        0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::reserve::repay_liquidity<T0, T1>(v1, 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(arg4, 0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::decimal::ceil(v2), arg5)), v2);
        let v3 = RepayEvent{
            lending_market   : 0x1::type_name::get<T0>(),
            coin_type        : 0x1::type_name::get<T1>(),
            reserve_id       : 0x2::object::id_address<0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::reserve::Reserve<T0>>(v1),
            obligation_id    : 0x2::object::id_address<0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::obligation::Obligation<T0>>(v0),
            liquidity_amount : 0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::decimal::ceil(v2),
        };
        0x2::event::emit<RepayEvent>(v3);
    }

    fun reserve_array_index<T0, T1>(arg0: &LendingMarket<T0>) : u64 {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::reserve::Reserve<T0>>(&arg0.reserves)) {
            if (0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::reserve::coin_type<T0>(0x1::vector::borrow<0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::reserve::Reserve<T0>>(&arg0.reserves, v0)) == 0x1::type_name::get<T1>()) {
                return v0
            };
            v0 = v0 + 1;
        };
        v0
    }

    public fun update_rate_limiter_config<T0>(arg0: &LendingMarketOwnerCap<T0>, arg1: &mut LendingMarket<T0>, arg2: &0x2::clock::Clock, arg3: 0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::rate_limiter::RateLimiterConfig) {
        assert!(arg1.version == 1, 1);
        arg1.rate_limiter = 0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::rate_limiter::new(arg3, 0x2::clock::timestamp_ms(arg2) / 1000);
    }

    public fun update_reserve_config<T0, T1>(arg0: &LendingMarketOwnerCap<T0>, arg1: &mut LendingMarket<T0>, arg2: u64, arg3: 0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::reserve_config::ReserveConfig) {
        assert!(arg1.version == 1, 1);
        let v0 = 0x1::vector::borrow_mut<0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::reserve::Reserve<T0>>(&mut arg1.reserves, arg2);
        assert!(0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::reserve::coin_type<T0>(v0) == 0x1::type_name::get<T1>(), 3);
        0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::reserve::update_reserve_config<T0>(v0, arg3);
    }

    public fun withdraw_ctokens<T0, T1>(arg0: &mut LendingMarket<T0>, arg1: u64, arg2: &ObligationOwnerCap<T0>, arg3: &0x2::clock::Clock, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::reserve::CToken<T0, T1>> {
        assert!(arg0.version == 1, 1);
        assert!(arg4 > 0, 2);
        let v0 = 0x2::object_table::borrow_mut<0x2::object::ID, 0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::obligation::Obligation<T0>>(&mut arg0.obligations, arg2.obligation_id);
        0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::obligation::refresh<T0>(v0, &mut arg0.reserves, arg3);
        let v1 = 0x1::vector::borrow_mut<0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::reserve::Reserve<T0>>(&mut arg0.reserves, arg1);
        assert!(0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::reserve::coin_type<T0>(v1) == 0x1::type_name::get<T1>(), 3);
        0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::obligation::withdraw<T0>(v0, v1, arg3, arg4);
        let v2 = WithdrawEvent{
            lending_market : 0x1::type_name::get<T0>(),
            coin_type      : 0x1::type_name::get<T1>(),
            reserve_id     : 0x2::object::id_address<0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::reserve::Reserve<T0>>(v1),
            obligation_id  : 0x2::object::id_address<0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::obligation::Obligation<T0>>(v0),
            ctoken_amount  : arg4,
        };
        0x2::event::emit<WithdrawEvent>(v2);
        0x2::coin::from_balance<0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::reserve::CToken<T0, T1>>(0x38b4f53fbf1c1335d2043390d7386fde79f9abc5b2c13fff0775dba60b9126dd::reserve::withdraw_ctokens<T0, T1>(v1, arg4), arg5)
    }

    // decompiled from Move bytecode v6
}

