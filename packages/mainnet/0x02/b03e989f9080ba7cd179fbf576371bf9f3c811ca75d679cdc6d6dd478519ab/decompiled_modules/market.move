module 0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::market {
    struct Market<phantom T0> has key {
        id: 0x2::object::UID,
        inner: 0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::versioned_object::VersionedObject,
    }

    struct CreatorCap has store, key {
        id: 0x2::object::UID,
        market_id: 0x2::object::ID,
    }

    struct MarketCreated has copy, drop {
        market_id: 0x2::object::ID,
        title: 0x1::string::String,
        created_at_ms: u64,
        expires_at_ms: u64,
        outcome_values: vector<vector<u8>>,
    }

    struct MarketResolved has copy, drop {
        market_id: 0x2::object::ID,
        winning_index: u64,
        resolved_at_ms: u64,
        final_prices: vector<u64>,
    }

    struct Trade has copy, drop {
        market_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        amount: u64,
        is_buy: bool,
        quantity: u64,
        fee_amount: u64,
        min_payout: u64,
        timestamp_ms: u64,
        outcome_index: u64,
        max_total_cost: u64,
        new_prices: vector<u64>,
    }

    struct Redeem has copy, drop {
        market_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        amount: u64,
        payout: u64,
        timestamp_ms: u64,
        outcome_index: u64,
    }

    struct LiquidityAdded has copy, drop {
        market_id: 0x2::object::ID,
        amount: u64,
        timestamp_ms: u64,
        total_funding: u64,
    }

    struct MarketPaused has copy, drop {
        market_id: 0x2::object::ID,
        timestamp_ms: u64,
    }

    struct MarketResumed has copy, drop {
        market_id: 0x2::object::ID,
        timestamp_ms: u64,
    }

    public fun add_liquidity<T0>(arg0: &mut Market<T0>, arg1: &0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::config::ProtocolConfig, arg2: &CreatorCap, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock) {
        assert!(0x2::object::uid_to_inner(&arg0.id) == arg2.market_id, 4);
        let v0 = load_data_mut<T0>(arg0);
        assert!(!0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::market_data::is_paused<T0>(v0), 15);
        assert!(0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::market_data::is_fundable<T0>(v0, arg4), 0);
        let v1 = 0x2::coin::value<T0>(&arg3);
        if (0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::market_data::funding_amount<T0>(v0) == 0) {
            assert!(v1 >= 0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::config::min_funding_amount(arg1, 0x1::type_name::with_defining_ids<T0>()), 1);
        };
        0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::market_data::add_liquidity<T0>(v0, 0x2::coin::into_balance<T0>(arg3));
        let v2 = 0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::market_data::funding_amount<T0>(v0);
        let v3 = 0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::config::resolve_tier_for_funding(arg1, v2);
        let v4 = if (0x1::option::is_some<0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::config::FundingTier>(&v3)) {
            let v5 = 0x1::option::destroy_some<0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::config::FundingTier>(v3);
            0x1::option::some<u64>(0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::config::funding_tier_fee_share_bps(&v5))
        } else {
            0x1::option::destroy_none<0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::config::FundingTier>(v3);
            0x1::option::none<u64>()
        };
        0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::market_data::set_creator_fee_share_bps<T0>(v0, 0x1::option::destroy_with_default<u64>(v4, 0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::config::default_creator_fee_share_bps(arg1)));
        let v6 = LiquidityAdded{
            market_id     : 0x2::object::uid_to_inner(&arg0.id),
            amount        : v1,
            timestamp_ms  : 0x2::clock::timestamp_ms(arg4),
            total_funding : v2,
        };
        0x2::event::emit<LiquidityAdded>(v6);
    }

    public fun buy<T0>(arg0: &mut Market<T0>, arg1: &mut 0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::position::Position<T0>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0xecfd9df9860ec25e63556165f7d6a60ca8fb01b34ebf617e2b3f48d232dfe03d::share::Share<0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::coral::CORAL_XCH>, 0x2::coin::Coin<T0>) {
        assert!(0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::position::market_id<T0>(arg1) == 0x2::object::uid_to_inner(&arg0.id), 7);
        let v0 = load_data_mut<T0>(arg0);
        assert!(!0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::market_data::is_paused<T0>(v0), 15);
        assert!(0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::market_data::state<T0>(v0, arg6) == 0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::market_data::state_active(), 0);
        assert!(arg3 < 0x1::vector::length<vector<u8>>(0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::market_data::outcome_values<T0>(v0)), 2);
        let (v1, v2) = preview_cost<T0>(v0, arg3, arg4);
        let v3 = v1 + v2;
        assert!(v3 <= arg5, 8);
        assert!(0x2::coin::value<T0>(&arg2) >= v3, 1);
        0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::market_data::deposit<T0>(v0, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg2, v3, arg7)), v2);
        let v4 = 0x2::clock::timestamp_ms(arg6);
        0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::position::apply_buy<T0>(arg1, arg3, arg4, v3, v2, v4);
        let v5 = v0;
        let v6 = Trade{
            market_id      : 0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::position::market_id<T0>(arg1),
            position_id    : 0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::position::id<T0>(arg1),
            amount         : v3,
            is_buy         : true,
            quantity       : arg4,
            fee_amount     : v2,
            min_payout     : 0,
            timestamp_ms   : v4,
            outcome_index  : arg3,
            max_total_cost : arg5,
            new_prices     : 0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::dlmsr::prices(0xecfd9df9860ec25e63556165f7d6a60ca8fb01b34ebf617e2b3f48d232dfe03d::supply::supply_values<0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::coral::CORAL_XCH>(0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::market_data::supply_state<T0>(v5)), 0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::market_data::alpha_bps(0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::market_data::config<T0>(v5)), 0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::market_data::liquidity_param<T0>(v5), 0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::market_data::decimals(0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::market_data::config<T0>(v5))),
        };
        0x2::event::emit<Trade>(v6);
        (0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::market_data::mint_share<T0>(v0, arg3, arg4, arg7), arg2)
    }

    public fun share<T0>(arg0: Market<T0>, arg1: &0x2::clock::Clock) {
        let v0 = &mut arg0;
        let v1 = load_data<T0>(v0);
        assert!(!0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::market_data::is_paused<T0>(v1), 15);
        assert!(0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::market_data::is_shareable<T0>(v1, arg1), 13);
        0x2::transfer::share_object<Market<T0>>(arg0);
    }

    public fun claim_creator_fees<T0>(arg0: &mut Market<T0>, arg1: &CreatorCap, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg1.market_id == 0x2::object::uid_to_inner(&arg0.id), 4);
        let v0 = load_data_mut<T0>(arg0);
        assert!(!0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::market_data::is_paused<T0>(v0), 15);
        0x2::coin::from_balance<T0>(0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::market_data::withdraw_creator_fees<T0>(v0), arg2)
    }

    public fun claim_protocol_fees<T0>(arg0: &mut Market<T0>, arg1: &0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::config::ProtocolCap, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = load_data_mut<T0>(arg0);
        assert!(!0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::market_data::is_paused<T0>(v0), 15);
        0x2::coin::from_balance<T0>(0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::market_data::withdraw_protocol_fees<T0>(v0), arg2)
    }

    public(friend) fun create_market<T0>(arg0: &0x2::coin_registry::Currency<T0>, arg1: &0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::config::ProtocolConfig, arg2: 0x1::string::String, arg3: 0x1::option::Option<u64>, arg4: u64, arg5: vector<vector<u8>>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (Market<T0>, CreatorCap) {
        let v0 = 0x1::vector::length<vector<u8>>(&arg5);
        assert!(v0 >= 2 && v0 < 8, 14);
        assert!(0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::config::is_quote_allowed(arg1, 0x1::type_name::with_defining_ids<T0>()), 11);
        let v1 = 0x2::clock::timestamp_ms(arg6);
        let v2 = 0x1::option::destroy_with_default<u64>(arg3, v1);
        assert!(v2 >= v1, 6);
        let v3 = 0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::config::duration_config(arg1);
        assert!(arg4 > v2, 10);
        let v4 = arg4 - v2;
        assert!(v4 >= 0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::config::min_duration_ms(v3), 10);
        let v5 = 0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::config::max_duration_ms(v3);
        if (0x1::option::is_some<u64>(&v5)) {
            assert!(v4 <= 0x1::option::destroy_some<u64>(v5), 10);
        };
        let v6 = 0x2::object::new(arg7);
        let v7 = MarketCreated{
            market_id      : 0x2::object::uid_to_inner(&v6),
            title          : arg2,
            created_at_ms  : v1,
            expires_at_ms  : arg4,
            outcome_values : arg5,
        };
        0x2::event::emit<MarketCreated>(v7);
        let v8 = CreatorCap{
            id        : 0x2::derived_object::claim<vector<u8>>(&mut v6, b"CREATOR_CAP"),
            market_id : 0x2::object::uid_to_inner(&v6),
        };
        let v9 = Market<T0>{
            id    : v6,
            inner : 0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::versioned_object::create<0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::market_data::MarketData<T0>>(0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::market_data::current_version(), 0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::market_data::create<T0>(&mut v6, 0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::market_data::new_config<T0>(arg0, 0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::config::trading_fee_bps(arg1), 0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::config::default_creator_fee_share_bps(arg1), 0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::config::vig_bps(arg1), v0), arg2, v2, arg4, arg5, arg6), arg7),
        };
        (v9, v8)
    }

    public fun create_market_with_oracle_custom_topic<T0, T1>(arg0: &0x2::coin_registry::Currency<T1>, arg1: &0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::config::ProtocolConfig, arg2: &mut 0x74355104dc60857523e4367650df08c7fef8cfb08629f84ab3385d34fa063041::protocol::Protocol, arg3: &0x74355104dc60857523e4367650df08c7fef8cfb08629f84ab3385d34fa063041::resolver::Resolver, arg4: 0x1::string::String, arg5: vector<u8>, arg6: vector<u8>, arg7: 0x74355104dc60857523e4367650df08c7fef8cfb08629f84ab3385d34fa063041::schema::DataType, arg8: vector<vector<u8>>, arg9: 0x1::option::Option<u64>, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : (0x74355104dc60857523e4367650df08c7fef8cfb08629f84ab3385d34fa063041::query::Query<T0>, Market<T1>, CreatorCap) {
        let (v0, v1) = create_market<T1>(arg0, arg1, arg4, arg9, arg10, arg8, arg11, arg12);
        let v2 = v0;
        let v3 = 0x1::vector::empty<0x2::object::ID>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x2::object::ID>(v4, 0x2::object::uid_to_inner(&v2.id));
        0x1::vector::push_back<0x2::object::ID>(v4, 0x2::object::id<0x2::clock::Clock>(arg11));
        let v5 = 0x74355104dc60857523e4367650df08c7fef8cfb08629f84ab3385d34fa063041::query::create_with_schema<T0, 0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::coral::CORAL_XCH>(0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::coral::make_witness(), arg2, arg3, 0x74355104dc60857523e4367650df08c7fef8cfb08629f84ab3385d34fa063041::query::new_custom_schema(0x74355104dc60857523e4367650df08c7fef8cfb08629f84ab3385d34fa063041::schema::new_options_schema(arg7, arg8)), arg5, arg6, 0x1::option::none<u64>(), 0x1::option::none<u64>(), v3, arg11, arg12);
        let v6 = &mut v2;
        0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::market_data::set_reef_query_id<T1>(load_data_mut<T1>(v6), 0x74355104dc60857523e4367650df08c7fef8cfb08629f84ab3385d34fa063041::query::id<T0>(&v5));
        (v5, v2, v1)
    }

    public fun create_market_with_oracle_standard_topic<T0, T1>(arg0: &0x2::coin_registry::Currency<T1>, arg1: &0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::config::ProtocolConfig, arg2: &mut 0x74355104dc60857523e4367650df08c7fef8cfb08629f84ab3385d34fa063041::protocol::Protocol, arg3: &0x74355104dc60857523e4367650df08c7fef8cfb08629f84ab3385d34fa063041::resolver::Resolver, arg4: 0x1::string::String, arg5: vector<u8>, arg6: u64, arg7: vector<u8>, arg8: 0x1::option::Option<u64>, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : (0x74355104dc60857523e4367650df08c7fef8cfb08629f84ab3385d34fa063041::query::Query<T0>, Market<T1>, CreatorCap) {
        let (v0, v1) = create_market<T1>(arg0, arg1, arg4, arg8, arg9, 0x74355104dc60857523e4367650df08c7fef8cfb08629f84ab3385d34fa063041::schema::options(0x74355104dc60857523e4367650df08c7fef8cfb08629f84ab3385d34fa063041::protocol::topic_schema(arg2, arg5, arg6)), arg10, arg11);
        let v2 = v0;
        let v3 = 0x1::vector::empty<0x2::object::ID>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x2::object::ID>(v4, 0x2::object::uid_to_inner(&v2.id));
        0x1::vector::push_back<0x2::object::ID>(v4, 0x2::object::id<0x2::clock::Clock>(arg10));
        let v5 = 0x74355104dc60857523e4367650df08c7fef8cfb08629f84ab3385d34fa063041::query::create<T0, 0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::coral::CORAL_XCH>(0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::coral::make_witness(), arg2, arg3, arg5, arg6, arg7, 0x1::option::none<u64>(), 0x1::option::none<u64>(), v3, arg10, arg11);
        let v6 = &mut v2;
        0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::market_data::set_reef_query_id<T1>(load_data_mut<T1>(v6), 0x74355104dc60857523e4367650df08c7fef8cfb08629f84ab3385d34fa063041::query::id<T0>(&v5));
        (v5, v2, v1)
    }

    public fun create_position<T0>(arg0: &mut Market<T0>, arg1: address) : 0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::position::Position<T0> {
        let v0 = load_data<T0>(arg0);
        assert!(!0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::market_data::is_paused<T0>(v0), 15);
        0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::position::new<T0>(&mut arg0.id, arg1, 0x1::vector::length<vector<u8>>(0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::market_data::outcome_values<T0>(v0)))
    }

    public fun keep_position<T0>(arg0: 0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::position::Position<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::position::transfer<T0>(arg0, 0x2::tx_context::sender(arg1));
    }

    fun load_data<T0>(arg0: &mut Market<T0>) : &0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::market_data::MarketData<T0> {
        assert!(0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::versioned_object::version(&arg0.inner) == 0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::market_data::current_version(), 9);
        0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::versioned_object::load_value<0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::market_data::MarketData<T0>>(&arg0.inner)
    }

    fun load_data_mut<T0>(arg0: &mut Market<T0>) : &mut 0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::market_data::MarketData<T0> {
        assert!(0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::versioned_object::version(&arg0.inner) == 0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::market_data::current_version(), 9);
        0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::versioned_object::load_value_mut<0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::market_data::MarketData<T0>>(&mut arg0.inner)
    }

    public(friend) fun outcome_values<T0>(arg0: &mut Market<T0>) : &vector<vector<u8>> {
        0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::market_data::outcome_values<T0>(load_data<T0>(arg0))
    }

    public fun pause_market<T0>(arg0: &mut Market<T0>, arg1: &0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::config::ProtocolCap, arg2: &0x2::clock::Clock) {
        let v0 = load_data_mut<T0>(arg0);
        assert!(!0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::market_data::is_paused<T0>(v0), 15);
        0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::market_data::set_paused<T0>(v0, true);
        let v1 = MarketPaused{
            market_id    : 0x2::object::uid_to_inner(&arg0.id),
            timestamp_ms : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<MarketPaused>(v1);
    }

    fun preview_cost<T0>(arg0: &0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::market_data::MarketData<T0>, arg1: u64, arg2: u64) : (u64, u64) {
        assert!(arg1 < 0x1::vector::length<vector<u8>>(0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::market_data::outcome_values<T0>(arg0)), 2);
        let v0 = 0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::dlmsr::cost(arg1, arg2, 0xecfd9df9860ec25e63556165f7d6a60ca8fb01b34ebf617e2b3f48d232dfe03d::supply::supply_values<0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::coral::CORAL_XCH>(0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::market_data::supply_state<T0>(arg0)), 0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::market_data::alpha_bps(0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::market_data::config<T0>(arg0)), 0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::market_data::liquidity_param<T0>(arg0), 0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::market_data::decimals(0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::market_data::config<T0>(arg0)));
        (v0, 0xc9e327ded995f2f1d983537b21f027935479e702a6a1f64bd3aefd47c077ba8e::u64::mul_div_up(v0, 0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::market_data::trading_fee_bps(0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::market_data::config<T0>(arg0)), 10000))
    }

    fun preview_payout<T0>(arg0: &0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::market_data::MarketData<T0>, arg1: u64, arg2: u64) : (u64, u64) {
        assert!(arg1 < 0x1::vector::length<vector<u8>>(0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::market_data::outcome_values<T0>(arg0)), 2);
        let v0 = 0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::dlmsr::payout(arg1, arg2, 0xecfd9df9860ec25e63556165f7d6a60ca8fb01b34ebf617e2b3f48d232dfe03d::supply::supply_values<0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::coral::CORAL_XCH>(0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::market_data::supply_state<T0>(arg0)), 0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::market_data::alpha_bps(0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::market_data::config<T0>(arg0)), 0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::market_data::liquidity_param<T0>(arg0), 0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::market_data::decimals(0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::market_data::config<T0>(arg0)));
        (v0, 0xc9e327ded995f2f1d983537b21f027935479e702a6a1f64bd3aefd47c077ba8e::u64::mul_div_up(v0, 0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::market_data::trading_fee_bps(0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::market_data::config<T0>(arg0)), 10000))
    }

    public fun rebalance_liquidity<T0>(arg0: &mut Market<T0>, arg1: &0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::config::ProtocolCap) {
        let v0 = load_data_mut<T0>(arg0);
        assert!(0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::market_data::is_paused<T0>(v0), 16);
        0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::market_data::rebalance_liquidity_param<T0>(v0);
    }

    public fun redeem<T0>(arg0: &mut Market<T0>, arg1: &mut 0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::position::Position<T0>, arg2: 0xecfd9df9860ec25e63556165f7d6a60ca8fb01b34ebf617e2b3f48d232dfe03d::share::Share<0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::coral::CORAL_XCH>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::object::uid_to_inner(&arg0.id);
        assert!(0xecfd9df9860ec25e63556165f7d6a60ca8fb01b34ebf617e2b3f48d232dfe03d::share::belongs_to_market<0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::coral::CORAL_XCH>(&arg2, v0), 5);
        assert!(0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::position::market_id<T0>(arg1) == v0, 7);
        let v1 = load_data_mut<T0>(arg0);
        assert!(0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::market_data::state<T0>(v1, arg3) == 0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::market_data::state_resolved(), 3);
        let v2 = 0xecfd9df9860ec25e63556165f7d6a60ca8fb01b34ebf617e2b3f48d232dfe03d::share::value<0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::coral::CORAL_XCH>(&arg2);
        let v3 = 0xecfd9df9860ec25e63556165f7d6a60ca8fb01b34ebf617e2b3f48d232dfe03d::share::outcome_index<0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::coral::CORAL_XCH>(&arg2);
        let v4 = 0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::market_data::resolution<T0>(v1);
        if (0x1::option::is_some<0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::market_data::Resolution>(v4)) {
            assert!(v3 == 0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::market_data::outcome_index(0x1::option::borrow<0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::market_data::Resolution>(v4)), 2);
        };
        let v5 = 0x2::clock::timestamp_ms(arg3);
        0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::position::apply_redeem<T0>(arg1, v3, v2, v5);
        let v6 = Redeem{
            market_id     : v0,
            position_id   : 0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::position::id<T0>(arg1),
            amount        : v2,
            payout        : v2,
            timestamp_ms  : v5,
            outcome_index : v3,
        };
        0x2::event::emit<Redeem>(v6);
        0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::market_data::burn_share<T0>(v1, arg2);
        0x2::coin::from_balance<T0>(0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::market_data::redeem<T0>(v1, v2), arg4)
    }

    public(friend) fun reef_query_id<T0>(arg0: &mut Market<T0>) : 0x1::option::Option<0x2::object::ID> {
        0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::market_data::reef_query_id<T0>(load_data<T0>(arg0))
    }

    public fun remove_liquidity<T0>(arg0: &mut Market<T0>, arg1: &CreatorCap, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::object::uid_to_inner(&arg0.id) == arg1.market_id, 4);
        let v0 = load_data_mut<T0>(arg0);
        assert!(!0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::market_data::is_paused<T0>(v0), 15);
        assert!(0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::market_data::state<T0>(v0, arg3) == 0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::market_data::state_resolved(), 0);
        0x2::coin::from_balance<T0>(0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::market_data::remove_liquidity<T0>(v0, arg2), arg4)
    }

    public(friend) fun resolve<T0>(arg0: &mut Market<T0>, arg1: u64, arg2: &0x2::clock::Clock) {
        let v0 = load_data_mut<T0>(arg0);
        let v1 = 0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::market_data::supply_state<T0>(v0);
        assert!(0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::market_data::state<T0>(v0, arg2) == 0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::market_data::state_expired(), 0);
        assert!(0xecfd9df9860ec25e63556165f7d6a60ca8fb01b34ebf617e2b3f48d232dfe03d::supply::is_state_cap<0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::coral::CORAL_XCH>(0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::market_data::supply_cap<T0>(v0), v1), 12);
        assert!(arg1 < 0x1::vector::length<vector<u8>>(0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::market_data::outcome_values<T0>(v0)), 2);
        let v2 = v0;
        let v3 = 0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::dlmsr::prices(0xecfd9df9860ec25e63556165f7d6a60ca8fb01b34ebf617e2b3f48d232dfe03d::supply::supply_values<0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::coral::CORAL_XCH>(0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::market_data::supply_state<T0>(v2)), 0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::market_data::alpha_bps(0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::market_data::config<T0>(v2)), 0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::market_data::liquidity_param<T0>(v2), 0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::market_data::decimals(0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::market_data::config<T0>(v2)));
        let v4 = 0xecfd9df9860ec25e63556165f7d6a60ca8fb01b34ebf617e2b3f48d232dfe03d::supply::supply_values<0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::coral::CORAL_XCH>(v1);
        0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::market_data::resolve<T0>(v0, v3, arg1, *0x1::vector::borrow<u64>(&v4, arg1), arg2);
        let v5 = MarketResolved{
            market_id      : 0x2::object::uid_to_inner(&arg0.id),
            winning_index  : arg1,
            resolved_at_ms : 0x2::clock::timestamp_ms(arg2),
            final_prices   : v3,
        };
        0x2::event::emit<MarketResolved>(v5);
    }

    public fun resolve_market<T0>(arg0: &mut Market<T0>, arg1: &0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::config::ProtocolCap, arg2: u64, arg3: &0x2::clock::Clock) {
        resolve<T0>(arg0, arg2, arg3);
    }

    public fun resume_market<T0>(arg0: &mut Market<T0>, arg1: &0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::config::ProtocolCap, arg2: &0x2::clock::Clock) {
        let v0 = load_data_mut<T0>(arg0);
        assert!(0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::market_data::is_paused<T0>(v0), 16);
        0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::market_data::set_paused<T0>(v0, false);
        0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::market_data::rebalance_liquidity_param<T0>(v0);
        let v1 = MarketResumed{
            market_id    : 0x2::object::uid_to_inner(&arg0.id),
            timestamp_ms : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<MarketResumed>(v1);
    }

    public fun sell<T0>(arg0: &mut Market<T0>, arg1: &mut 0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::position::Position<T0>, arg2: 0xecfd9df9860ec25e63556165f7d6a60ca8fb01b34ebf617e2b3f48d232dfe03d::share::Share<0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::coral::CORAL_XCH>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0xecfd9df9860ec25e63556165f7d6a60ca8fb01b34ebf617e2b3f48d232dfe03d::share::belongs_to_market<0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::coral::CORAL_XCH>(&arg2, 0x2::object::uid_to_inner(&arg0.id)), 5);
        assert!(0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::position::market_id<T0>(arg1) == 0x2::object::uid_to_inner(&arg0.id), 7);
        let v0 = 0xecfd9df9860ec25e63556165f7d6a60ca8fb01b34ebf617e2b3f48d232dfe03d::share::outcome_index<0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::coral::CORAL_XCH>(&arg2);
        let v1 = load_data_mut<T0>(arg0);
        assert!(!0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::market_data::is_paused<T0>(v1), 15);
        assert!(0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::market_data::state<T0>(v1, arg4) == 0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::market_data::state_active(), 0);
        assert!(v0 < 0x1::vector::length<vector<u8>>(0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::market_data::outcome_values<T0>(v1)), 2);
        let v2 = 0xecfd9df9860ec25e63556165f7d6a60ca8fb01b34ebf617e2b3f48d232dfe03d::share::value<0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::coral::CORAL_XCH>(&arg2);
        let (v3, v4) = preview_payout<T0>(v1, v0, v2);
        let v5 = 0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::market_data::withdraw<T0>(v1, v3, v4);
        assert!(0x2::balance::value<T0>(&v5) >= arg3, 8);
        0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::market_data::burn_share<T0>(v1, arg2);
        let v6 = 0x2::clock::timestamp_ms(arg4);
        0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::position::apply_sell<T0>(arg1, v0, v2, 0x2::balance::value<T0>(&v5), v4, v6);
        let v7 = v1;
        let v8 = Trade{
            market_id      : 0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::position::market_id<T0>(arg1),
            position_id    : 0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::position::id<T0>(arg1),
            amount         : 0x2::balance::value<T0>(&v5),
            is_buy         : false,
            quantity       : v2,
            fee_amount     : v4,
            min_payout     : arg3,
            timestamp_ms   : v6,
            outcome_index  : v0,
            max_total_cost : 0,
            new_prices     : 0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::dlmsr::prices(0xecfd9df9860ec25e63556165f7d6a60ca8fb01b34ebf617e2b3f48d232dfe03d::supply::supply_values<0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::coral::CORAL_XCH>(0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::market_data::supply_state<T0>(v7)), 0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::market_data::alpha_bps(0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::market_data::config<T0>(v7)), 0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::market_data::liquidity_param<T0>(v7), 0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::market_data::decimals(0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::market_data::config<T0>(v7))),
        };
        0x2::event::emit<Trade>(v8);
        0x2::coin::from_balance<T0>(v5, arg5)
    }

    public fun state_active() : 0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::market_data::State {
        0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::market_data::state_active()
    }

    public fun state_expired() : 0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::market_data::State {
        0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::market_data::state_expired()
    }

    public fun state_paused() : 0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::market_data::State {
        0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::market_data::state_paused()
    }

    public fun state_pending() : 0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::market_data::State {
        0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::market_data::state_pending()
    }

    public fun state_resolved() : 0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::market_data::State {
        0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::market_data::state_resolved()
    }

    public fun transfer_position<T0>(arg0: 0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::position::Position<T0>, arg1: address) {
        0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::position::transfer<T0>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

