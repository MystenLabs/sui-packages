module 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::orderbook {
    struct Order<phantom T0> has store {
        id: u64,
        price: u128,
        timestamp: u64,
        input: 0x2::balance::Balance<T0>,
        maker_fee_reserve: 0x2::balance::Balance<T0>,
        original_amount: u64,
        maker_fee_bps: u64,
        maker_quote_filled: u64,
        sender: address,
    }

    struct OrderBook<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        asks: OrderSide<T0>,
        bids: OrderSide<T1>,
        decimals_t: u8,
        decimals_t1: u8,
        next_order_id: u64,
        coin_quote_maker_fee_bps: u64,
        coin_quote_taker_fee_bps: u64,
        coin_quote_fee_vault: 0x2::balance::Balance<T1>,
        minimum_quote_notional: u64,
    }

    struct OrderbookCreated has copy, drop {
        orderbook_id: 0x2::object::ID,
        base_type: 0x1::type_name::TypeName,
        quote_type: 0x1::type_name::TypeName,
        base_decimals: u8,
        quote_decimals: u8,
        minimum_quote_notional: u64,
    }

    struct OrderSide<phantom T0> has store {
        levels: 0x337f85b36287d38cdf2bb60964187f432dd3abeb5228f8a2db4cff7a9f47a87d::keyed_big_vector::KeyedBigVector,
        price_index: 0x337f85b36287d38cdf2bb60964187f432dd3abeb5228f8a2db4cff7a9f47a87d::linked_table::LinkedTable<u128, PriceLevelIndexEntry>,
        best_price: 0x1::option::Option<u128>,
        is_bid: bool,
        order_count: u64,
    }

    struct PriceLevel<phantom T0> has store {
        price: u128,
        orders: 0x337f85b36287d38cdf2bb60964187f432dd3abeb5228f8a2db4cff7a9f47a87d::linked_table::LinkedTable<u64, Order<T0>>,
    }

    struct PriceLevelIndexEntry has drop, store {
        dummy_field: bool,
    }

    struct PriceLevelSummary has copy, drop, store {
        price: u128,
        order_count: u64,
        total_remaining: u64,
    }

    struct OrderSummary has copy, drop, store {
        id: u64,
        price: u128,
        timestamp: u64,
        remaining_amount: u64,
        original_amount: u64,
        maker_fee_bps: u64,
        maker_fee_reserve: u64,
        sender: address,
    }

    struct OrderLocationKey has copy, drop, store {
        pos0: u64,
    }

    struct OrderLocation has copy, drop, store {
        side: u8,
        price: u128,
    }

    struct OrderPointTokenMarketKey has copy, drop, store {
        pos0: u64,
    }

    struct OrderPointTokenMarketBinding has store {
        point_token_market_id: 0x2::object::ID,
    }

    fun add_order_location<T0, T1>(arg0: &mut OrderBook<T0, T1>, arg1: u64, arg2: u8, arg3: u128) {
        let v0 = OrderLocationKey{pos0: arg1};
        let v1 = OrderLocation{
            side  : arg2,
            price : arg3,
        };
        0x2::dynamic_field::add<OrderLocationKey, OrderLocation>(&mut arg0.id, v0, v1);
    }

    fun add_order_point_token_market_binding<T0, T1, T2>(arg0: &mut OrderBook<T0, T1>, arg1: u64, arg2: &0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::token::PointTokenMarket<T2>) {
        let v0 = OrderPointTokenMarketKey{pos0: arg1};
        assert!(!0x2::dynamic_field::exists<OrderPointTokenMarketKey>(&arg0.id, v0), 7);
        let v1 = OrderPointTokenMarketBinding{point_token_market_id: 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::token::point_token_market_id<T2>(arg2)};
        0x2::dynamic_field::add<OrderPointTokenMarketKey, OrderPointTokenMarketBinding>(&mut arg0.id, v0, v1);
    }

    fun add_order_to_side<T0>(arg0: &mut OrderSide<T0>, arg1: Order<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = arg1.price;
        if (0x337f85b36287d38cdf2bb60964187f432dd3abeb5228f8a2db4cff7a9f47a87d::keyed_big_vector::contains<u128>(&arg0.levels, v0)) {
            assert!(0x337f85b36287d38cdf2bb60964187f432dd3abeb5228f8a2db4cff7a9f47a87d::linked_table::length<u64, Order<T0>>(&0x337f85b36287d38cdf2bb60964187f432dd3abeb5228f8a2db4cff7a9f47a87d::keyed_big_vector::borrow_by_key<u128, PriceLevel<T0>>(&arg0.levels, v0).orders) < 100, 14);
        } else {
            let v1 = PriceLevel<T0>{
                price  : v0,
                orders : 0x337f85b36287d38cdf2bb60964187f432dd3abeb5228f8a2db4cff7a9f47a87d::linked_table::new<u64, Order<T0>>(arg2),
            };
            0x337f85b36287d38cdf2bb60964187f432dd3abeb5228f8a2db4cff7a9f47a87d::keyed_big_vector::push_back<u128, PriceLevel<T0>>(&mut arg0.levels, v0, v1);
            insert_price_index<T0>(arg0, v0);
        };
        0x337f85b36287d38cdf2bb60964187f432dd3abeb5228f8a2db4cff7a9f47a87d::linked_table::push_back<u64, Order<T0>>(&mut 0x337f85b36287d38cdf2bb60964187f432dd3abeb5228f8a2db4cff7a9f47a87d::keyed_big_vector::borrow_by_key_mut<u128, PriceLevel<T0>>(&mut arg0.levels, v0).orders, arg1.id, arg1);
        arg0.order_count = arg0.order_count + 1;
    }

    fun allocate_order_id<T0, T1>(arg0: &mut OrderBook<T0, T1>) : u64 {
        let v0 = arg0.next_order_id;
        arg0.next_order_id = v0 + 1;
        v0
    }

    public fun ask_count<T0, T1>(arg0: &OrderBook<T0, T1>) : u64 {
        side_count<T0>(&arg0.asks)
    }

    public fun ask_level_count<T0, T1>(arg0: &OrderBook<T0, T1>) : u64 {
        side_level_count<T0>(&arg0.asks)
    }

    public fun ask_level_summary_at<T0, T1>(arg0: &OrderBook<T0, T1>, arg1: u64) : PriceLevelSummary {
        level_summary<T0>(&arg0.asks, price_at_side_level<T0>(&arg0.asks, arg1))
    }

    public fun ask_level_summary_by_price<T0, T1>(arg0: &OrderBook<T0, T1>, arg1: u128) : PriceLevelSummary {
        level_summary<T0>(&arg0.asks, arg1)
    }

    public fun ask_order_id_at<T0, T1>(arg0: &OrderBook<T0, T1>, arg1: u64) : u64 {
        order_at<T0>(&arg0.asks, arg1).id
    }

    public fun ask_order_summary_at_price<T0, T1>(arg0: &OrderBook<T0, T1>, arg1: u128, arg2: u64) : OrderSummary {
        order_summary<T0>(borrow_order<T0>(&arg0.asks, arg1, order_id_at_side_price<T0>(&arg0.asks, arg1, arg2)))
    }

    public fun ask_remaining_at<T0, T1>(arg0: &OrderBook<T0, T1>, arg1: u64) : u64 {
        0x2::balance::value<T0>(&order_at<T0>(&arg0.asks, arg1).input)
    }

    public fun ask_remaining_by_order_id<T0, T1>(arg0: &OrderBook<T0, T1>, arg1: u64) : u64 {
        0x2::balance::value<T0>(&borrow_order<T0>(&arg0.asks, assert_order_side_and_price<T0, T1>(arg0, arg1, 0), arg1).input)
    }

    fun assert_ask_meets_minimum_notional<T0, T1>(arg0: &OrderBook<T0, T1>, arg1: &Order<T0>) {
        assert!(base_to_quote_amount_round_up(0x2::balance::value<T0>(&arg1.input), arg1.price, arg0.decimals_t, arg0.decimals_t1) >= arg0.minimum_quote_notional, 15);
    }

    fun assert_order_has_no_point_token_market_binding<T0, T1>(arg0: &OrderBook<T0, T1>, arg1: u64) {
        let v0 = OrderPointTokenMarketKey{pos0: arg1};
        assert!(!0x2::dynamic_field::exists<OrderPointTokenMarketKey>(&arg0.id, v0), 7);
    }

    fun assert_order_input_point_token_market<T0, T1, T2>(arg0: &OrderBook<T0, T1>, arg1: u64, arg2: &0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::token::PointTokenMarket<T2>) {
        let v0 = OrderPointTokenMarketKey{pos0: arg1};
        assert!(0x2::dynamic_field::exists<OrderPointTokenMarketKey>(&arg0.id, v0), 7);
        assert!(0x2::dynamic_field::borrow<OrderPointTokenMarketKey, OrderPointTokenMarketBinding>(&arg0.id, v0).point_token_market_id == 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::token::point_token_market_id<T2>(arg2), 7);
    }

    fun assert_order_side_and_price<T0, T1>(arg0: &OrderBook<T0, T1>, arg1: u64, arg2: u8) : u128 {
        let v0 = OrderLocationKey{pos0: arg1};
        assert!(0x2::dynamic_field::exists_with_type<OrderLocationKey, OrderLocation>(&arg0.id, v0), 5);
        let v1 = OrderLocationKey{pos0: arg1};
        let v2 = 0x2::dynamic_field::borrow<OrderLocationKey, OrderLocation>(&arg0.id, v1);
        assert!(v2.side == arg2, 8);
        v2.price
    }

    fun assert_score_trading_scale<T0>(arg0: &0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::token::PointTokenMarket<T0>) {
        assert!(0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::token::point_token_market_scale<T0>(arg0) == 1, 17);
    }

    fun assert_valid_max_fills(arg0: u64) {
        assert!(arg0 > 0 && arg0 <= 32, 11);
    }

    fun base_to_quote_amount_round_down_capped(arg0: u64, arg1: u128, arg2: u8, arg3: u8, arg4: u64) : u64 {
        assert!(arg1 > 0, 1);
        div_floor_capped_to_u64(base_to_quote_numerator(arg0, arg1, arg3), base_to_quote_denominator(arg2), arg4)
    }

    fun base_to_quote_amount_round_up(arg0: u64, arg1: u128, arg2: u8, arg3: u8) : u64 {
        assert!(arg1 > 0, 1);
        0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::point_math::div_ceil_to_u64(base_to_quote_numerator(arg0, arg1, arg3), base_to_quote_denominator(arg2))
    }

    fun base_to_quote_denominator(arg0: u8) : u256 {
        0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::point_math::checked_mul_u256(0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::point_math::decimal_scale(arg0), 1000000000000000000)
    }

    fun base_to_quote_numerator(arg0: u64, arg1: u128, arg2: u8) : u256 {
        0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::point_math::checked_mul_u256(0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::point_math::checked_mul_u256((arg0 as u256), (arg1 as u256)), 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::point_math::decimal_scale(arg2))
    }

    public fun best_ask<T0, T1>(arg0: &OrderBook<T0, T1>) : (u64, u128, u64) {
        let (v0, v1) = best_order_location<T0>(&arg0.asks);
        let v2 = borrow_order<T0>(&arg0.asks, v1, v0);
        (v2.id, v2.price, 0x2::balance::value<T0>(&v2.input))
    }

    public fun best_ask_summary<T0, T1>(arg0: &OrderBook<T0, T1>) : OrderSummary {
        let (v0, v1) = best_order_location<T0>(&arg0.asks);
        order_summary<T0>(borrow_order<T0>(&arg0.asks, v1, v0))
    }

    public fun best_bid<T0, T1>(arg0: &OrderBook<T0, T1>) : (u64, u128, u64) {
        let (v0, v1) = best_order_location<T1>(&arg0.bids);
        let v2 = borrow_order<T1>(&arg0.bids, v1, v0);
        (v2.id, v2.price, 0x2::balance::value<T1>(&v2.input))
    }

    public fun best_bid_summary<T0, T1>(arg0: &OrderBook<T0, T1>) : OrderSummary {
        let (v0, v1) = best_order_location<T1>(&arg0.bids);
        order_summary<T1>(borrow_order<T1>(&arg0.bids, v1, v0))
    }

    fun best_order_location<T0>(arg0: &OrderSide<T0>) : (u64, u128) {
        assert!(0x1::option::is_some<u128>(&arg0.best_price), 5);
        let v0 = *0x1::option::borrow<u128>(&arg0.best_price);
        let v1 = 0x337f85b36287d38cdf2bb60964187f432dd3abeb5228f8a2db4cff7a9f47a87d::linked_table::front<u64, Order<T0>>(&0x337f85b36287d38cdf2bb60964187f432dd3abeb5228f8a2db4cff7a9f47a87d::keyed_big_vector::borrow_by_key<u128, PriceLevel<T0>>(&arg0.levels, v0).orders);
        assert!(0x1::option::is_some<u64>(&v1), 5);
        (*0x1::option::borrow<u64>(&v1), v0)
    }

    public fun bid_count<T0, T1>(arg0: &OrderBook<T0, T1>) : u64 {
        side_count<T1>(&arg0.bids)
    }

    public fun bid_level_count<T0, T1>(arg0: &OrderBook<T0, T1>) : u64 {
        side_level_count<T1>(&arg0.bids)
    }

    public fun bid_level_summary_at<T0, T1>(arg0: &OrderBook<T0, T1>, arg1: u64) : PriceLevelSummary {
        level_summary<T1>(&arg0.bids, price_at_side_level<T1>(&arg0.bids, arg1))
    }

    public fun bid_level_summary_by_price<T0, T1>(arg0: &OrderBook<T0, T1>, arg1: u128) : PriceLevelSummary {
        level_summary<T1>(&arg0.bids, arg1)
    }

    public fun bid_order_id_at<T0, T1>(arg0: &OrderBook<T0, T1>, arg1: u64) : u64 {
        order_at<T1>(&arg0.bids, arg1).id
    }

    public fun bid_order_summary_at_price<T0, T1>(arg0: &OrderBook<T0, T1>, arg1: u128, arg2: u64) : OrderSummary {
        order_summary<T1>(borrow_order<T1>(&arg0.bids, arg1, order_id_at_side_price<T1>(&arg0.bids, arg1, arg2)))
    }

    public fun bid_remaining_at<T0, T1>(arg0: &OrderBook<T0, T1>, arg1: u64) : u64 {
        0x2::balance::value<T1>(&order_at<T1>(&arg0.bids, arg1).input)
    }

    public fun bid_remaining_by_order_id<T0, T1>(arg0: &OrderBook<T0, T1>, arg1: u64) : u64 {
        0x2::balance::value<T1>(&borrow_order<T1>(&arg0.bids, assert_order_side_and_price<T0, T1>(arg0, arg1, 1), arg1).input)
    }

    fun borrow_order<T0>(arg0: &OrderSide<T0>, arg1: u128, arg2: u64) : &Order<T0> {
        0x337f85b36287d38cdf2bb60964187f432dd3abeb5228f8a2db4cff7a9f47a87d::linked_table::borrow<u64, Order<T0>>(&0x337f85b36287d38cdf2bb60964187f432dd3abeb5228f8a2db4cff7a9f47a87d::keyed_big_vector::borrow_by_key<u128, PriceLevel<T0>>(&arg0.levels, arg1).orders, arg2)
    }

    fun borrow_order_mut<T0>(arg0: &mut OrderSide<T0>, arg1: u128, arg2: u64) : &mut Order<T0> {
        0x337f85b36287d38cdf2bb60964187f432dd3abeb5228f8a2db4cff7a9f47a87d::linked_table::borrow_mut<u64, Order<T0>>(&mut 0x337f85b36287d38cdf2bb60964187f432dd3abeb5228f8a2db4cff7a9f47a87d::keyed_big_vector::borrow_by_key_mut<u128, PriceLevel<T0>>(&mut arg0.levels, arg1).orders, arg2)
    }

    fun cancel_ask<T0, T1>(arg0: &mut OrderBook<T0, T1>, arg1: &mut 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::token::PointTokenMarket<T0>, arg2: u64, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = cancel_ask_result<T0, T1>(arg0, arg1, arg2, arg3, arg4);
        0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::token::transfer_token_to<T0>(arg1, v0, v1, arg4);
    }

    public fun cancel_ask_order<T0, T1>(arg0: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::GlobalConfig, arg1: &mut OrderBook<T0, T1>, arg2: &mut 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::token::PointTokenMarket<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::package_version::assert_domain_enabled(arg0, 0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::orderbook_domain());
        cancel_ask<T0, T1>(arg1, arg2, arg3, false, arg4);
    }

    public fun cancel_ask_order_result<T0, T1>(arg0: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::GlobalConfig, arg1: &mut OrderBook<T0, T1>, arg2: &mut 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::token::PointTokenMarket<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::token::Token<T0> {
        0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::package_version::assert_domain_enabled(arg0, 0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::orderbook_domain());
        let (v0, _) = cancel_ask_result<T0, T1>(arg1, arg2, arg3, false, arg4);
        v0
    }

    public fun cancel_ask_order_to_score<T0, T1>(arg0: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::GlobalConfig, arg1: &mut OrderBook<T0, T1>, arg2: &mut 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::token::PointTokenMarket<T0>, arg3: &mut 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::scoreboard::Scoreboard, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert_score_trading_scale<T0>(arg2);
        let v0 = cancel_ask_order_result<T0, T1>(arg0, arg1, arg2, arg4, arg6);
        0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::token::restore_score_from_tokens<T0>(arg0, arg2, arg3, v0, arg5, arg6);
    }

    fun cancel_ask_result<T0, T1>(arg0: &mut OrderBook<T0, T1>, arg1: &mut 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::token::PointTokenMarket<T0>, arg2: u64, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) : (0x2::token::Token<T0>, address) {
        let v0 = 0x2::object::id<OrderBook<T0, T1>>(arg0);
        let v1 = assert_order_side_and_price<T0, T1>(arg0, arg2, 0);
        assert_order_input_point_token_market<T0, T1, T0>(arg0, arg2, arg1);
        let v2 = remove_ask_order<T0, T1>(arg0, v1, arg2);
        remove_order_point_token_market_binding<T0, T1>(arg0, arg2);
        let Order {
            id                 : v3,
            price              : v4,
            timestamp          : v5,
            input              : v6,
            maker_fee_reserve  : v7,
            original_amount    : _,
            maker_fee_bps      : _,
            maker_quote_filled : _,
            sender             : v11,
        } = v2;
        let v12 = v6;
        assert!(arg3 || v11 == 0x2::tx_context::sender(arg4), 0);
        0x2::balance::destroy_zero<T0>(v7);
        let v13 = 0x2::balance::value<T0>(&v12);
        let v14 = token_from_balance<T0>(arg1, v12, arg4);
        0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::event::emit_order_cancelled(v0, 0, v3, v11, 0x1::type_name::with_original_ids<T0>(), 0x1::type_name::with_original_ids<T1>(), v4, v5, v13);
        if (arg3) {
            0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::event::emit_order_cancelled_by_admin(v0, 0, v3, v11, 0x2::tx_context::sender(arg4), 0x1::type_name::with_original_ids<T0>(), 0x1::type_name::with_original_ids<T1>(), v4, v5, v13);
        };
        (v14, v11)
    }

    public fun cancel_bid_order_coin_quote<T0, T1>(arg0: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::GlobalConfig, arg1: &mut OrderBook<T0, T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::package_version::assert_domain_enabled(arg0, 0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::orderbook_domain());
        cancel_coin_bid<T0, T1>(arg1, arg2, false, arg3);
    }

    fun cancel_coin_bid<T0, T1>(arg0: &mut OrderBook<T0, T1>, arg1: u64, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<OrderBook<T0, T1>>(arg0);
        let v1 = assert_order_side_and_price<T0, T1>(arg0, arg1, 1);
        assert_order_has_no_point_token_market_binding<T0, T1>(arg0, arg1);
        let v2 = remove_bid_order<T0, T1>(arg0, v1, arg1);
        remove_order_point_token_market_binding<T0, T1>(arg0, arg1);
        let Order {
            id                 : v3,
            price              : v4,
            timestamp          : v5,
            input              : v6,
            maker_fee_reserve  : v7,
            original_amount    : _,
            maker_fee_bps      : _,
            maker_quote_filled : _,
            sender             : v11,
        } = v2;
        let v12 = v6;
        assert!(arg2 || v11 == 0x2::tx_context::sender(arg3), 0);
        let v13 = 0x2::balance::value<T1>(&v12);
        0x2::balance::join<T1>(&mut v12, v7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v12, arg3), v11);
        0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::event::emit_order_cancelled(v0, 1, v3, v11, 0x1::type_name::with_original_ids<T0>(), 0x1::type_name::with_original_ids<T1>(), v4, v5, v13);
        if (arg2) {
            0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::event::emit_order_cancelled_by_admin(v0, 1, v3, v11, 0x2::tx_context::sender(arg3), 0x1::type_name::with_original_ids<T0>(), 0x1::type_name::with_original_ids<T1>(), v4, v5, v13);
        };
    }

    fun cancel_coin_quote_order<T0, T1>(arg0: &mut OrderBook<T0, T1>, arg1: &mut 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::token::PointTokenMarket<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = order_side<T0, T1>(arg0, arg2);
        if (v0 == 0) {
            cancel_ask<T0, T1>(arg0, arg1, arg2, true, arg3);
        } else {
            assert!(v0 == 1, 8);
            cancel_coin_bid<T0, T1>(arg0, arg2, true, arg3);
        };
    }

    public fun cancel_order_by_acl<T0, T1>(arg0: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::GlobalConfig, arg1: &0x1c12a970d5e8072ad437c6f591dd87f16ec0eacf5d5c0884c7522df0926ecfb3::acl::ACL, arg2: &mut OrderBook<T0, T1>, arg3: &mut 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::token::PointTokenMarket<T0>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::package_version::assert_domain_enabled(arg0, 0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::orderbook_domain());
        0x1c12a970d5e8072ad437c6f591dd87f16ec0eacf5d5c0884c7522df0926ecfb3::acl::assert_has_role(arg1, arg0, 0x2::tx_context::sender(arg5), 0x1c12a970d5e8072ad437c6f591dd87f16ec0eacf5d5c0884c7522df0926ecfb3::operations::orderbook_cleanup());
        cancel_coin_quote_order<T0, T1>(arg2, arg3, arg4, arg5);
    }

    public fun cancel_order_by_admin<T0, T1>(arg0: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::GlobalConfig, arg1: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::admin::AdminCap, arg2: &mut OrderBook<T0, T1>, arg3: &mut 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::token::PointTokenMarket<T0>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::package_version::assert_domain_enabled(arg0, 0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::orderbook_domain());
        cancel_coin_quote_order<T0, T1>(arg2, arg3, arg4, arg5);
    }

    fun coin_quote_fee_amount<T0, T1>(arg0: &OrderBook<T0, T1>, arg1: u64) : u64 {
        coin_quote_fee_amount_bps(arg1, arg0.coin_quote_taker_fee_bps)
    }

    fun coin_quote_fee_amount_bps(arg0: u64, arg1: u64) : u64 {
        assert!(arg1 <= 10000, 9);
        if (arg0 == 0 || arg1 == 0) {
            0
        } else {
            0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::point_math::mul_div_ceil_to_u64((arg0 as u256), (arg1 as u256), (10000 as u256))
        }
    }

    public fun coin_quote_fee_balance<T0, T1>(arg0: &OrderBook<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.coin_quote_fee_vault)
    }

    fun coin_quote_gross_amount<T0, T1>(arg0: &OrderBook<T0, T1>, arg1: u64) : u64 {
        0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::point_math::checked_add(arg1, coin_quote_fee_amount<T0, T1>(arg0, arg1))
    }

    fun coin_quote_gross_for_exact_net_output(arg0: u64, arg1: u64) : u64 {
        assert!(arg1 < 10000, 13);
        if (arg0 == 0) {
            return 0
        };
        let v0 = 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::point_math::mul_div_ceil_to_u64((arg0 as u256), (10000 as u256), ((10000 - arg1) as u256));
        assert!(coin_quote_net_output_amount(v0, arg1) == arg0, 13);
        v0
    }

    public fun coin_quote_maker_fee_bps<T0, T1>(arg0: &OrderBook<T0, T1>) : u64 {
        arg0.coin_quote_maker_fee_bps
    }

    fun coin_quote_net_budget<T0, T1>(arg0: &OrderBook<T0, T1>, arg1: u64) : u64 {
        if (arg1 == 0 || arg0.coin_quote_taker_fee_bps == 0) {
            arg1
        } else {
            0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::point_math::div_floor_to_u64(0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::point_math::checked_mul_u256((arg1 as u256), (10000 as u256)), ((10000 + arg0.coin_quote_taker_fee_bps) as u256))
        }
    }

    fun coin_quote_net_output_amount(arg0: u64, arg1: u64) : u64 {
        assert!(arg1 <= 10000, 9);
        arg0 - coin_quote_fee_amount_bps(arg0, arg1)
    }

    fun coin_quote_notional_from_gross(arg0: u64, arg1: u64) : u64 {
        assert!(arg1 <= 10000, 9);
        if (arg0 == 0 || arg1 == 0) {
            return arg0
        };
        let v0 = 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::point_math::div_floor_to_u64(0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::point_math::checked_mul_u256((arg0 as u256), (10000 as u256)), ((10000 + arg1) as u256));
        while (v0 > 0 && 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::point_math::checked_add(v0, coin_quote_fee_amount_bps(v0, arg1)) > arg0) {
            v0 = v0 - 1;
        };
        let v1 = 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::point_math::checked_add(v0, 1);
        if (v1 <= arg0 && 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::point_math::checked_add(v1, coin_quote_fee_amount_bps(v1, arg1)) <= arg0) {
            v0 = v1;
        };
        v0
    }

    public fun coin_quote_taker_fee_bps<T0, T1>(arg0: &OrderBook<T0, T1>) : u64 {
        arg0.coin_quote_taker_fee_bps
    }

    public fun collect_coin_quote_fees<T0, T1>(arg0: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::GlobalConfig, arg1: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::admin::AdminCap, arg2: &mut OrderBook<T0, T1>, arg3: &mut 0x2::tx_context::TxContext) : u64 {
        0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::package_version::assert_domain_enabled(arg0, 0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::orderbook_domain());
        let v0 = 0x2::balance::value<T1>(&arg2.coin_quote_fee_vault);
        if (v0 == 0) {
            return 0
        };
        let v1 = 0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::treasury_recipient(arg0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg2.coin_quote_fee_vault, v0), arg3), v1);
        0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::event::emit_orderbook_coin_quote_fees_collected(0x2::object::id<OrderBook<T0, T1>>(arg2), v1, 0x1::type_name::with_original_ids<T1>(), v0);
        v0
    }

    public fun create_orderbook<T0, T1>(arg0: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::GlobalConfig, arg1: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::admin::AdminCap, arg2: &0x2::coin::CoinMetadata<T0>, arg3: &0x2::coin::CoinMetadata<T1>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::package_version::assert_domain_enabled(arg0, 0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::orderbook_domain());
        share_orderbook<T0, T1>(0x2::coin::get_decimals<T0>(arg2), 0x2::coin::get_decimals<T1>(arg3), arg4, arg5);
    }

    public fun create_orderbook_from_currency<T0, T1>(arg0: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::GlobalConfig, arg1: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::admin::AdminCap, arg2: &0x2::coin_registry::Currency<T0>, arg3: &0x2::coin_registry::Currency<T1>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::package_version::assert_domain_enabled(arg0, 0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::orderbook_domain());
        share_orderbook<T0, T1>(0x2::coin_registry::decimals<T0>(arg2), 0x2::coin_registry::decimals<T1>(arg3), arg4, arg5);
    }

    public fun create_orderbook_with_decimals<T0, T1>(arg0: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::GlobalConfig, arg1: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::admin::AdminCap, arg2: u8, arg3: u8, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::package_version::assert_domain_enabled(arg0, 0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::orderbook_domain());
        share_orderbook<T0, T1>(arg2, arg3, arg4, arg5);
    }

    fun div_floor_capped_to_u64(arg0: u256, arg1: u256, arg2: u64) : u64 {
        assert!(arg1 > 0, 1);
        let v0 = arg0 / arg1;
        if (v0 > (arg2 as u256)) {
            arg2
        } else {
            (v0 as u64)
        }
    }

    public fun fill_ask_exact_in_coin_quote<T0, T1>(arg0: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::GlobalConfig, arg1: &mut OrderBook<T0, T1>, arg2: &mut 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::token::PointTokenMarket<T0>, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::package_version::assert_domain_enabled(arg0, 0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::orderbook_domain());
        let v0 = 0x2::object::id<OrderBook<T0, T1>>(arg1);
        let v1 = 0x2::coin::value<T1>(&arg3);
        assert!(v1 > 0, 2);
        let v2 = assert_order_side_and_price<T0, T1>(arg1, arg4, 0);
        let v3 = borrow_order<T0>(&arg1.asks, v2, arg4);
        let v4 = quote_to_base_amount_round_down_capped(coin_quote_net_budget<T0, T1>(arg1, v1), v3.price, arg1.decimals_t, arg1.decimals_t1, 0x2::balance::value<T0>(&v3.input));
        assert!(v4 > 0, 6);
        let v5 = base_to_quote_amount_round_up(v4, v3.price, arg1.decimals_t, arg1.decimals_t1);
        assert!(v4 > 0, 3);
        assert!(coin_quote_gross_amount<T0, T1>(arg1, v5) <= v1, 4);
        let v6 = &mut arg3;
        let v7 = split_coin_quote_payment<T0, T1>(arg1, v6, v5, 0, arg4, arg5);
        assert_order_input_point_token_market<T0, T1, T0>(arg1, arg4, arg2);
        let v8 = &mut arg1.asks;
        let v9 = borrow_order_mut<T0>(v8, v2, arg4);
        let (v10, v11, v12) = settle_ask_fill_coin_quote<T0, T1>(v0, v9, arg2, v7, v4, arg4, arg5);
        join_coin_quote_fee_balance<T0, T1>(arg1, v11, 0, v12, 0, arg4, v5);
        finalize_ask_fill<T0, T1>(arg1, arg2, v2, arg4, v10, arg5);
        arg3
    }

    public fun fill_ask_exact_out_coin_quote<T0, T1>(arg0: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::GlobalConfig, arg1: &mut OrderBook<T0, T1>, arg2: &mut 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::token::PointTokenMarket<T0>, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let (v0, v1) = fill_ask_exact_out_coin_quote_result<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::token::transfer_token_to<T0>(arg2, v0, 0x2::tx_context::sender(arg6), arg6);
        v1
    }

    public fun fill_ask_exact_out_coin_quote_result<T0, T1>(arg0: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::GlobalConfig, arg1: &mut OrderBook<T0, T1>, arg2: &mut 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::token::PointTokenMarket<T0>, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : (0x2::token::Token<T0>, 0x2::coin::Coin<T1>) {
        let (v0, v1, v2, v3) = fill_ask_exact_out_core<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        finalize_ask_fill<T0, T1>(arg1, arg2, v2, arg5, v3, arg6);
        (v0, v1)
    }

    public fun fill_ask_exact_out_coin_quote_to_score<T0, T1>(arg0: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::GlobalConfig, arg1: &mut OrderBook<T0, T1>, arg2: &mut 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::token::PointTokenMarket<T0>, arg3: &mut 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::scoreboard::Scoreboard, arg4: 0x2::coin::Coin<T1>, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert_score_trading_scale<T0>(arg2);
        let (v0, v1, v2, v3) = fill_ask_exact_out_core<T0, T1>(arg0, arg1, arg2, arg4, arg5, arg6, arg8);
        0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::token::restore_score_from_tokens<T0>(arg0, arg2, arg3, v0, arg7, arg8);
        finalize_ask_fill_to_score<T0, T1>(arg0, arg1, arg2, arg3, v2, arg6, v3, arg7, arg8);
        v1
    }

    fun fill_ask_exact_out_core<T0, T1>(arg0: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::GlobalConfig, arg1: &mut OrderBook<T0, T1>, arg2: &mut 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::token::PointTokenMarket<T0>, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : (0x2::token::Token<T0>, 0x2::coin::Coin<T1>, u128, u64) {
        0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::package_version::assert_domain_enabled(arg0, 0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::orderbook_domain());
        let v0 = 0x2::object::id<OrderBook<T0, T1>>(arg1);
        let v1 = assert_order_side_and_price<T0, T1>(arg1, arg5, 0);
        let v2 = borrow_order<T0>(&arg1.asks, v1, arg5);
        assert!(arg4 > 0, 2);
        assert!(arg4 <= 0x2::balance::value<T0>(&v2.input), 3);
        let v3 = base_to_quote_amount_round_up(arg4, v2.price, arg1.decimals_t, arg1.decimals_t1);
        assert!(coin_quote_gross_amount<T0, T1>(arg1, v3) <= 0x2::coin::value<T1>(&arg3), 4);
        let v4 = &mut arg3;
        let v5 = split_coin_quote_payment<T0, T1>(arg1, v4, v3, 0, arg5, arg6);
        assert_order_input_point_token_market<T0, T1, T0>(arg1, arg5, arg2);
        let v6 = &mut arg1.asks;
        let v7 = borrow_order_mut<T0>(v6, v1, arg5);
        let (v8, v9, v10, v11) = settle_ask_fill_coin_quote_result<T0, T1>(v0, v7, arg2, v5, arg4, arg5, arg6);
        join_coin_quote_fee_balance<T0, T1>(arg1, v9, 0, v10, 0, arg5, v3);
        (v11, arg3, v1, v8)
    }

    public fun fill_best_ask_exact_in_coin_quote<T0, T1>(arg0: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::GlobalConfig, arg1: &mut OrderBook<T0, T1>, arg2: &mut 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::token::PointTokenMarket<T0>, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::package_version::assert_domain_enabled(arg0, 0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::orderbook_domain());
        assert_valid_max_fills(arg4);
        assert!(0x2::coin::value<T1>(&arg3) > 0, 2);
        let v0 = 0x2::object::id<OrderBook<T0, T1>>(arg1);
        let v1 = 0;
        loop {
            let v2 = if (0x2::coin::value<T1>(&arg3) > 0) {
                if (side_count<T0>(&arg1.asks) > 0) {
                    v1 < arg4
                } else {
                    false
                }
            } else {
                false
            };
            if (v2) {
                let (v3, v4) = best_order_location<T0>(&arg1.asks);
                let v5 = borrow_order<T0>(&arg1.asks, v4, v3);
                let v6 = quote_to_base_amount_round_down_capped(coin_quote_net_budget<T0, T1>(arg1, 0x2::coin::value<T1>(&arg3)), v5.price, arg1.decimals_t, arg1.decimals_t1, 0x2::balance::value<T0>(&v5.input));
                let (v7, v8) = if (v6 == 0) {
                    (0, 0)
                } else {
                    let v8 = base_to_quote_amount_round_up(v6, v5.price, arg1.decimals_t, arg1.decimals_t1);
                    (v6, v8)
                };
                if (v7 == 0) {
                    return arg3
                };
                let v9 = &mut arg3;
                let v10 = split_coin_quote_payment<T0, T1>(arg1, v9, v8, 0, v3, arg5);
                assert_order_input_point_token_market<T0, T1, T0>(arg1, v3, arg2);
                let v11 = &mut arg1.asks;
                let v12 = borrow_order_mut<T0>(v11, v4, v3);
                let (v13, v14, v15) = settle_ask_fill_coin_quote<T0, T1>(v0, v12, arg2, v10, v7, v3, arg5);
                join_coin_quote_fee_balance<T0, T1>(arg1, v14, 0, v15, 0, v3, v8);
                finalize_ask_fill<T0, T1>(arg1, arg2, v4, v3, v13, arg5);
                v1 = v1 + 1;
            } else {
                break
            };
        };
        arg3
    }

    public fun fill_best_ask_exact_out_coin_quote<T0, T1>(arg0: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::GlobalConfig, arg1: &mut OrderBook<T0, T1>, arg2: &mut 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::token::PointTokenMarket<T0>, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::package_version::assert_domain_enabled(arg0, 0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::orderbook_domain());
        assert_valid_max_fills(arg5);
        assert!(arg4 > 0, 2);
        let v0 = 0x2::object::id<OrderBook<T0, T1>>(arg1);
        let v1 = arg4;
        let v2 = 0;
        while (v1 > 0 && v2 < arg5) {
            assert!(side_count<T0>(&arg1.asks) > 0, 3);
            let (v3, v4) = best_order_location<T0>(&arg1.asks);
            let v5 = borrow_order<T0>(&arg1.asks, v4, v3);
            let v6 = min(v1, 0x2::balance::value<T0>(&v5.input));
            let v7 = base_to_quote_amount_round_up(v6, v5.price, arg1.decimals_t, arg1.decimals_t1);
            assert!(coin_quote_gross_amount<T0, T1>(arg1, v7) <= 0x2::coin::value<T1>(&arg3), 4);
            let v8 = &mut arg3;
            let v9 = split_coin_quote_payment<T0, T1>(arg1, v8, v7, 0, v3, arg6);
            assert_order_input_point_token_market<T0, T1, T0>(arg1, v3, arg2);
            let v10 = &mut arg1.asks;
            let v11 = borrow_order_mut<T0>(v10, v4, v3);
            let (v12, v13, v14) = settle_ask_fill_coin_quote<T0, T1>(v0, v11, arg2, v9, v6, v3, arg6);
            join_coin_quote_fee_balance<T0, T1>(arg1, v13, 0, v14, 0, v3, v7);
            finalize_ask_fill<T0, T1>(arg1, arg2, v4, v3, v12, arg6);
            v1 = v1 - v6;
            v2 = v2 + 1;
        };
        assert!(v1 == 0, 12);
        arg3
    }

    public fun fill_best_bid_exact_in_coin_quote<T0, T1>(arg0: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::GlobalConfig, arg1: &mut OrderBook<T0, T1>, arg2: &mut 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::token::PointTokenMarket<T0>, arg3: 0x2::token::Token<T0>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : (0x2::token::Token<T0>, 0x2::coin::Coin<T1>) {
        0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::package_version::assert_domain_enabled(arg0, 0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::orderbook_domain());
        assert_valid_max_fills(arg4);
        assert!(0x2::token::value<T0>(&arg3) > 0, 2);
        let v0 = 0x2::balance::zero<T1>();
        let v1 = 0;
        loop {
            let v2 = if (0x2::token::value<T0>(&arg3) > 0) {
                if (side_count<T1>(&arg1.bids) > 0) {
                    v1 < arg4
                } else {
                    false
                }
            } else {
                false
            };
            if (v2) {
                let (v3, v4) = best_order_location<T1>(&arg1.bids);
                assert_order_has_no_point_token_market_binding<T0, T1>(arg1, v3);
                let v5 = borrow_order<T1>(&arg1.bids, v4, v3);
                let v6 = base_to_quote_amount_round_down_capped(0x2::token::value<T0>(&arg3), v5.price, arg1.decimals_t, arg1.decimals_t1, 0x2::balance::value<T1>(&v5.input));
                let (v7, v8) = if (v6 == 0) {
                    (0, 0)
                } else {
                    (v6, quote_to_base_amount_round_up(v6, v5.price, arg1.decimals_t, arg1.decimals_t1))
                };
                if (v7 == 0 || coin_quote_net_output_amount(v7, arg1.coin_quote_taker_fee_bps) == 0) {
                    break
                };
                let v9 = 0x2::token::split<T0>(&mut arg3, v8, arg5);
                let v10 = &mut arg1.bids;
                let v11 = borrow_order_mut<T1>(v10, v4, v3);
                let (v12, v13, v14, v15, v16) = settle_bid_fill_coin_quote<T0, T1>(0x2::object::id<OrderBook<T0, T1>>(arg1), v11, arg2, v9, v7, arg1.coin_quote_taker_fee_bps, v3, arg5);
                0x2::balance::join<T1>(&mut v0, v15);
                join_coin_quote_fee_balance<T0, T1>(arg1, v13, 1, 0x2::tx_context::sender(arg5), 1, v3, v7);
                join_coin_quote_fee_balance<T0, T1>(arg1, v14, 0, v16, 1, v3, v7);
                finalize_coin_bid_fill<T0, T1>(arg1, v4, v3, v12, arg5);
                v1 = v1 + 1;
            } else {
                break
            };
        };
        (arg3, 0x2::coin::from_balance<T1>(v0, arg5))
    }

    public fun fill_best_bid_exact_out_coin_quote<T0, T1>(arg0: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::GlobalConfig, arg1: &mut OrderBook<T0, T1>, arg2: &mut 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::token::PointTokenMarket<T0>, arg3: 0x2::token::Token<T0>, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : (0x2::token::Token<T0>, 0x2::coin::Coin<T1>) {
        0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::package_version::assert_domain_enabled(arg0, 0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::orderbook_domain());
        assert_valid_max_fills(arg5);
        assert!(arg4 > 0, 2);
        let v0 = arg1.coin_quote_taker_fee_bps;
        assert!(v0 < 10000, 13);
        let v1 = arg4;
        let v2 = 0x2::balance::zero<T1>();
        let v3 = 0;
        while (v1 > 0 && v3 < arg5) {
            assert!(side_count<T1>(&arg1.bids) > 0, 3);
            let (v4, v5) = best_order_location<T1>(&arg1.bids);
            assert_order_has_no_point_token_market_binding<T0, T1>(arg1, v4);
            let v6 = borrow_order<T1>(&arg1.bids, v5, v4);
            let v7 = coin_quote_net_output_amount(0x2::balance::value<T1>(&v6.input), v0);
            assert!(v7 > 0, 6);
            let v8 = min(v1, v7);
            let v9 = coin_quote_gross_for_exact_net_output(v8, v0);
            let v10 = quote_to_base_amount_round_up(v9, v6.price, arg1.decimals_t, arg1.decimals_t1);
            assert!(v10 <= 0x2::token::value<T0>(&arg3), 4);
            let v11 = 0x2::token::split<T0>(&mut arg3, v10, arg6);
            let v12 = &mut arg1.bids;
            let v13 = borrow_order_mut<T1>(v12, v5, v4);
            let (v14, v15, v16, v17, v18) = settle_bid_fill_coin_quote<T0, T1>(0x2::object::id<OrderBook<T0, T1>>(arg1), v13, arg2, v11, v9, v0, v4, arg6);
            let v19 = v17;
            assert!(0x2::balance::value<T1>(&v19) == v8, 13);
            0x2::balance::join<T1>(&mut v2, v19);
            join_coin_quote_fee_balance<T0, T1>(arg1, v15, 1, 0x2::tx_context::sender(arg6), 1, v4, v9);
            join_coin_quote_fee_balance<T0, T1>(arg1, v16, 0, v18, 1, v4, v9);
            finalize_coin_bid_fill<T0, T1>(arg1, v5, v4, v14, arg6);
            v1 = v1 - v8;
            v3 = v3 + 1;
        };
        assert!(v1 == 0, 12);
        assert!(0x2::balance::value<T1>(&v2) == arg4, 13);
        (arg3, 0x2::coin::from_balance<T1>(v2, arg6))
    }

    public fun fill_bid_exact_in_coin_quote<T0, T1>(arg0: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::GlobalConfig, arg1: &mut OrderBook<T0, T1>, arg2: &mut 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::token::PointTokenMarket<T0>, arg3: 0x2::token::Token<T0>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : (0x2::token::Token<T0>, 0x2::coin::Coin<T1>) {
        let (v0, v1, v2, v3) = fill_bid_exact_in_core<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
        0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::token::transfer_token_to<T0>(arg2, v2, v3, arg5);
        (v0, v1)
    }

    public fun fill_bid_exact_in_coin_quote_to_score<T0, T1>(arg0: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::GlobalConfig, arg1: &mut OrderBook<T0, T1>, arg2: &mut 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::token::PointTokenMarket<T0>, arg3: &mut 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::scoreboard::Scoreboard, arg4: 0x2::token::Token<T0>, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0x2::token::Token<T0>, 0x2::coin::Coin<T1>) {
        assert_score_trading_scale<T0>(arg2);
        let (v0, v1, v2, v3) = fill_bid_exact_in_core<T0, T1>(arg0, arg1, arg2, arg4, arg5, arg8);
        let v4 = v1;
        assert!(0x2::coin::value<T1>(&v4) >= arg6, 16);
        0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::token::restore_score_from_tokens_to<T0>(arg0, arg2, arg3, v2, v3, arg7);
        (v0, v4)
    }

    fun fill_bid_exact_in_core<T0, T1>(arg0: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::GlobalConfig, arg1: &mut OrderBook<T0, T1>, arg2: &mut 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::token::PointTokenMarket<T0>, arg3: 0x2::token::Token<T0>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : (0x2::token::Token<T0>, 0x2::coin::Coin<T1>, 0x2::token::Token<T0>, address) {
        0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::package_version::assert_domain_enabled(arg0, 0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::orderbook_domain());
        let v0 = 0x2::token::value<T0>(&arg3);
        assert!(v0 > 0, 2);
        let v1 = assert_order_side_and_price<T0, T1>(arg1, arg4, 1);
        assert_order_has_no_point_token_market_binding<T0, T1>(arg1, arg4);
        let v2 = borrow_order<T1>(&arg1.bids, v1, arg4);
        let v3 = base_to_quote_amount_round_down_capped(v0, v2.price, arg1.decimals_t, arg1.decimals_t1, 0x2::balance::value<T1>(&v2.input));
        assert!(v3 > 0, 6);
        let v4 = quote_to_base_amount_round_up(v3, v2.price, arg1.decimals_t, arg1.decimals_t1);
        assert!(v3 > 0, 3);
        assert!(coin_quote_net_output_amount(v3, arg1.coin_quote_taker_fee_bps) > 0, 6);
        assert!(v4 <= v0, 4);
        let v5 = 0x2::token::split<T0>(&mut arg3, v4, arg5);
        let v6 = &mut arg1.bids;
        let v7 = borrow_order_mut<T1>(v6, v1, arg4);
        let (v8, v9, v10, v11, v12, v13) = settle_bid_fill_coin_quote_result<T0, T1>(0x2::object::id<OrderBook<T0, T1>>(arg1), v7, arg2, v5, v3, arg1.coin_quote_taker_fee_bps, arg4, arg5);
        join_coin_quote_fee_balance<T0, T1>(arg1, v9, 1, 0x2::tx_context::sender(arg5), 1, arg4, v3);
        join_coin_quote_fee_balance<T0, T1>(arg1, v10, 0, v12, 1, arg4, v3);
        finalize_coin_bid_fill<T0, T1>(arg1, v1, arg4, v8, arg5);
        (arg3, 0x2::coin::from_balance<T1>(v11, arg5), v13, v12)
    }

    public fun fill_bid_exact_in_from_score<T0, T1>(arg0: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::GlobalConfig, arg1: &mut OrderBook<T0, T1>, arg2: &mut 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::token::PointTokenMarket<T0>, arg3: &mut 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::scoreboard::Scoreboard, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert_score_trading_scale<T0>(arg2);
        let v0 = 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::token::mint_amount<T0>(arg0, arg2, arg3, arg4, arg7, arg8);
        let (v1, v2) = fill_bid_exact_in_coin_quote_to_score<T0, T1>(arg0, arg1, arg2, arg3, v0, arg5, arg6, arg7, arg8);
        let v3 = v1;
        if (0x2::token::value<T0>(&v3) == 0) {
            0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::token::burn_empty_token<T0>(arg2, v3);
        } else {
            0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::token::restore_score_from_tokens<T0>(arg0, arg2, arg3, v3, arg7, arg8);
        };
        v2
    }

    public fun fill_bid_exact_out_coin_quote<T0, T1>(arg0: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::GlobalConfig, arg1: &mut OrderBook<T0, T1>, arg2: &mut 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::token::PointTokenMarket<T0>, arg3: 0x2::token::Token<T0>, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : (0x2::token::Token<T0>, 0x2::coin::Coin<T1>) {
        0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::package_version::assert_domain_enabled(arg0, 0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::orderbook_domain());
        let v0 = assert_order_side_and_price<T0, T1>(arg1, arg5, 1);
        assert_order_has_no_point_token_market_binding<T0, T1>(arg1, arg5);
        assert!(arg4 > 0, 2);
        let v1 = arg1.coin_quote_taker_fee_bps;
        let v2 = coin_quote_gross_for_exact_net_output(arg4, v1);
        let v3 = &mut arg1.bids;
        let v4 = borrow_order_mut<T1>(v3, v0, arg5);
        assert!(v2 <= 0x2::balance::value<T1>(&v4.input), 3);
        let v5 = quote_to_base_amount_round_up(v2, v4.price, arg1.decimals_t, arg1.decimals_t1);
        assert!(v5 <= 0x2::token::value<T0>(&arg3), 4);
        let v6 = 0x2::token::split<T0>(&mut arg3, v5, arg6);
        let (v7, v8, v9, v10, v11) = settle_bid_fill_coin_quote<T0, T1>(0x2::object::id<OrderBook<T0, T1>>(arg1), v4, arg2, v6, v2, v1, arg5, arg6);
        let v12 = v10;
        assert!(0x2::balance::value<T1>(&v12) == arg4, 13);
        join_coin_quote_fee_balance<T0, T1>(arg1, v8, 1, 0x2::tx_context::sender(arg6), 1, arg5, v2);
        join_coin_quote_fee_balance<T0, T1>(arg1, v9, 0, v11, 1, arg5, v2);
        finalize_coin_bid_fill<T0, T1>(arg1, v0, arg5, v7, arg6);
        (arg3, 0x2::coin::from_balance<T1>(v12, arg6))
    }

    fun finalize_ask_fill<T0, T1>(arg0: &mut OrderBook<T0, T1>, arg1: &mut 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::token::PointTokenMarket<T0>, arg2: u128, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        if (arg4 == 0) {
            remove_empty_ask_order<T0, T1>(arg0, arg2, arg3);
            return
        };
        let v0 = base_to_quote_amount_round_up(arg4, arg2, arg0.decimals_t, arg0.decimals_t1);
        if (v0 < arg0.minimum_quote_notional) {
            let v1 = 0x2::object::id<OrderBook<T0, T1>>(arg0);
            let v2 = remove_ask_order<T0, T1>(arg0, arg2, arg3);
            remove_order_point_token_market_binding<T0, T1>(arg0, arg3);
            let Order {
                id                 : v3,
                price              : v4,
                timestamp          : v5,
                input              : v6,
                maker_fee_reserve  : v7,
                original_amount    : _,
                maker_fee_bps      : _,
                maker_quote_filled : _,
                sender             : v11,
            } = v2;
            0x2::balance::destroy_zero<T0>(v7);
            let v12 = token_from_balance<T0>(arg1, v6, arg5);
            0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::token::transfer_token_to<T0>(arg1, v12, v11, arg5);
            0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::event::emit_order_dust_refunded(v1, 0, v3, v11, 0x1::type_name::with_original_ids<T0>(), 0x1::type_name::with_original_ids<T1>(), v4, v5, arg4, v0);
        };
    }

    fun finalize_ask_fill_to_score<T0, T1>(arg0: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::GlobalConfig, arg1: &mut OrderBook<T0, T1>, arg2: &mut 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::token::PointTokenMarket<T0>, arg3: &mut 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::scoreboard::Scoreboard, arg4: u128, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        if (arg6 == 0) {
            remove_empty_ask_order<T0, T1>(arg1, arg4, arg5);
            return
        };
        let v0 = base_to_quote_amount_round_up(arg6, arg4, arg1.decimals_t, arg1.decimals_t1);
        if (v0 < arg1.minimum_quote_notional) {
            let v1 = 0x2::object::id<OrderBook<T0, T1>>(arg1);
            let v2 = remove_ask_order<T0, T1>(arg1, arg4, arg5);
            remove_order_point_token_market_binding<T0, T1>(arg1, arg5);
            let Order {
                id                 : v3,
                price              : v4,
                timestamp          : v5,
                input              : v6,
                maker_fee_reserve  : v7,
                original_amount    : _,
                maker_fee_bps      : _,
                maker_quote_filled : _,
                sender             : v11,
            } = v2;
            0x2::balance::destroy_zero<T0>(v7);
            let v12 = token_from_balance<T0>(arg2, v6, arg8);
            0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::token::restore_score_from_tokens_to<T0>(arg0, arg2, arg3, v12, v11, arg7);
            0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::event::emit_order_dust_refunded(v1, 0, v3, v11, 0x1::type_name::with_original_ids<T0>(), 0x1::type_name::with_original_ids<T1>(), v4, v5, arg6, v0);
        };
    }

    fun finalize_coin_bid_fill<T0, T1>(arg0: &mut OrderBook<T0, T1>, arg1: u128, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        if (arg3 == 0) {
            remove_empty_bid_order<T0, T1>(arg0, arg1, arg2);
            return
        };
        if (arg3 < arg0.minimum_quote_notional) {
            let v0 = 0x2::object::id<OrderBook<T0, T1>>(arg0);
            let v1 = remove_bid_order<T0, T1>(arg0, arg1, arg2);
            remove_order_point_token_market_binding<T0, T1>(arg0, arg2);
            let Order {
                id                 : v2,
                price              : v3,
                timestamp          : v4,
                input              : v5,
                maker_fee_reserve  : v6,
                original_amount    : _,
                maker_fee_bps      : _,
                maker_quote_filled : _,
                sender             : v10,
            } = v1;
            let v11 = v5;
            0x2::balance::join<T1>(&mut v11, v6);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v11, arg4), v10);
            0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::event::emit_order_dust_refunded(v0, 1, v2, v10, 0x1::type_name::with_original_ids<T0>(), 0x1::type_name::with_original_ids<T1>(), v3, v4, arg3, arg3);
        };
    }

    fun insert_price_index<T0>(arg0: &mut OrderSide<T0>, arg1: u128) {
        let v0 = PriceLevelIndexEntry{dummy_field: false};
        0x337f85b36287d38cdf2bb60964187f432dd3abeb5228f8a2db4cff7a9f47a87d::linked_table::insert_front<u128, PriceLevelIndexEntry>(&mut arg0.price_index, price_insert_before<T0>(arg0, arg1), arg1, v0);
        arg0.best_price = 0x337f85b36287d38cdf2bb60964187f432dd3abeb5228f8a2db4cff7a9f47a87d::linked_table::front<u128, PriceLevelIndexEntry>(&arg0.price_index);
    }

    fun is_better_price<T0>(arg0: &OrderSide<T0>, arg1: u128, arg2: u128) : bool {
        arg0.is_bid && arg1 > arg2 || arg1 < arg2
    }

    fun join_coin_quote_fee_balance<T0, T1>(arg0: &mut OrderBook<T0, T1>, arg1: 0x2::balance::Balance<T1>, arg2: u8, arg3: address, arg4: u8, arg5: u64, arg6: u64) {
        let v0 = 0x2::balance::value<T1>(&arg1);
        if (v0 > 0) {
            0x2::balance::join<T1>(&mut arg0.coin_quote_fee_vault, arg1);
            0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::event::emit_orderbook_coin_quote_fee_accrued(0x2::object::id<OrderBook<T0, T1>>(arg0), arg4, arg5, arg2, arg3, 0x1::type_name::with_original_ids<T1>(), arg6, v0);
        } else {
            0x2::balance::destroy_zero<T1>(arg1);
        };
    }

    fun level_summary<T0>(arg0: &OrderSide<T0>, arg1: u128) : PriceLevelSummary {
        let v0 = 0x337f85b36287d38cdf2bb60964187f432dd3abeb5228f8a2db4cff7a9f47a87d::keyed_big_vector::borrow_by_key<u128, PriceLevel<T0>>(&arg0.levels, arg1);
        let v1 = 0;
        let v2 = 0x337f85b36287d38cdf2bb60964187f432dd3abeb5228f8a2db4cff7a9f47a87d::linked_table::front<u64, Order<T0>>(&v0.orders);
        while (0x1::option::is_some<u64>(&v2)) {
            let v3 = *0x1::option::borrow<u64>(&v2);
            v1 = v1 + 0x2::balance::value<T0>(&0x337f85b36287d38cdf2bb60964187f432dd3abeb5228f8a2db4cff7a9f47a87d::linked_table::borrow<u64, Order<T0>>(&v0.orders, v3).input);
            v2 = 0x337f85b36287d38cdf2bb60964187f432dd3abeb5228f8a2db4cff7a9f47a87d::linked_table::next<u64, Order<T0>>(&v0.orders, v3);
        };
        PriceLevelSummary{
            price           : arg1,
            order_count     : 0x337f85b36287d38cdf2bb60964187f432dd3abeb5228f8a2db4cff7a9f47a87d::linked_table::length<u64, Order<T0>>(&v0.orders),
            total_remaining : v1,
        }
    }

    fun maker_fee_for_fill<T0>(arg0: &mut Order<T0>, arg1: u64) : u64 {
        let v0 = arg0.maker_quote_filled;
        let v1 = 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::point_math::checked_add(v0, arg1);
        arg0.maker_quote_filled = v1;
        coin_quote_fee_amount_bps(v1, arg0.maker_fee_bps) - coin_quote_fee_amount_bps(v0, arg0.maker_fee_bps)
    }

    public fun maker_fee_role() : u8 {
        0
    }

    fun min(arg0: u64, arg1: u64) : u64 {
        if (arg0 < arg1) {
            arg0
        } else {
            arg1
        }
    }

    public fun minimum_quote_notional<T0, T1>(arg0: &OrderBook<T0, T1>) : u64 {
        arg0.minimum_quote_notional
    }

    fun new_order<T0>(arg0: 0x2::balance::Balance<T0>, arg1: u128, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) : Order<T0> {
        assert!(arg1 > 0, 1);
        let v0 = 0x2::balance::value<T0>(&arg0);
        assert!(v0 > 0, 2);
        Order<T0>{
            id                 : 0,
            price              : arg1,
            timestamp          : 0x2::clock::timestamp_ms(arg2),
            input              : arg0,
            maker_fee_reserve  : 0x2::balance::zero<T0>(),
            original_amount    : v0,
            maker_fee_bps      : 0,
            maker_quote_filled : 0,
            sender             : 0x2::tx_context::sender(arg3),
        }
    }

    fun new_order_side<T0>(arg0: bool, arg1: &mut 0x2::tx_context::TxContext) : OrderSide<T0> {
        OrderSide<T0>{
            levels      : 0x337f85b36287d38cdf2bb60964187f432dd3abeb5228f8a2db4cff7a9f47a87d::keyed_big_vector::new<u128, PriceLevel<T0>>(256, arg1),
            price_index : 0x337f85b36287d38cdf2bb60964187f432dd3abeb5228f8a2db4cff7a9f47a87d::linked_table::new<u128, PriceLevelIndexEntry>(arg1),
            best_price  : 0x1::option::none<u128>(),
            is_bid      : arg0,
            order_count : 0,
        }
    }

    public fun next_order_id<T0, T1>(arg0: &OrderBook<T0, T1>) : u64 {
        arg0.next_order_id
    }

    fun order_at<T0>(arg0: &OrderSide<T0>, arg1: u64) : &Order<T0> {
        let v0 = 0x337f85b36287d38cdf2bb60964187f432dd3abeb5228f8a2db4cff7a9f47a87d::linked_table::front<u128, PriceLevelIndexEntry>(&arg0.price_index);
        while (0x1::option::is_some<u128>(&v0)) {
            let v1 = *0x1::option::borrow<u128>(&v0);
            let v2 = 0x337f85b36287d38cdf2bb60964187f432dd3abeb5228f8a2db4cff7a9f47a87d::keyed_big_vector::borrow_by_key<u128, PriceLevel<T0>>(&arg0.levels, v1);
            let v3 = 0x337f85b36287d38cdf2bb60964187f432dd3abeb5228f8a2db4cff7a9f47a87d::linked_table::length<u64, Order<T0>>(&v2.orders);
            if (arg1 < v3) {
                return borrow_order<T0>(arg0, v1, order_id_at_level<T0>(v2, arg1))
            };
            arg1 = arg1 - v3;
            v0 = 0x337f85b36287d38cdf2bb60964187f432dd3abeb5228f8a2db4cff7a9f47a87d::linked_table::next<u128, PriceLevelIndexEntry>(&arg0.price_index, v1);
        };
        abort 5
    }

    fun order_id_at_level<T0>(arg0: &PriceLevel<T0>, arg1: u64) : u64 {
        let v0 = 0x337f85b36287d38cdf2bb60964187f432dd3abeb5228f8a2db4cff7a9f47a87d::linked_table::front<u64, Order<T0>>(&arg0.orders);
        assert!(0x1::option::is_some<u64>(&v0), 5);
        let v1 = *0x1::option::borrow<u64>(&v0);
        let v2 = 0;
        while (v2 < arg1) {
            let v3 = 0x337f85b36287d38cdf2bb60964187f432dd3abeb5228f8a2db4cff7a9f47a87d::linked_table::next<u64, Order<T0>>(&arg0.orders, v1);
            assert!(0x1::option::is_some<u64>(&v3), 5);
            v1 = *0x1::option::borrow<u64>(&v3);
            v2 = v2 + 1;
        };
        v1
    }

    fun order_id_at_side_price<T0>(arg0: &OrderSide<T0>, arg1: u128, arg2: u64) : u64 {
        order_id_at_level<T0>(0x337f85b36287d38cdf2bb60964187f432dd3abeb5228f8a2db4cff7a9f47a87d::keyed_big_vector::borrow_by_key<u128, PriceLevel<T0>>(&arg0.levels, arg1), arg2)
    }

    fun order_side<T0, T1>(arg0: &OrderBook<T0, T1>, arg1: u64) : u8 {
        let v0 = OrderLocationKey{pos0: arg1};
        assert!(0x2::dynamic_field::exists_with_type<OrderLocationKey, OrderLocation>(&arg0.id, v0), 5);
        let v1 = OrderLocationKey{pos0: arg1};
        0x2::dynamic_field::borrow<OrderLocationKey, OrderLocation>(&arg0.id, v1).side
    }

    fun order_summary<T0>(arg0: &Order<T0>) : OrderSummary {
        OrderSummary{
            id                : arg0.id,
            price             : arg0.price,
            timestamp         : arg0.timestamp,
            remaining_amount  : 0x2::balance::value<T0>(&arg0.input),
            original_amount   : arg0.original_amount,
            maker_fee_bps     : arg0.maker_fee_bps,
            maker_fee_reserve : 0x2::balance::value<T0>(&arg0.maker_fee_reserve),
            sender            : arg0.sender,
        }
    }

    public fun order_summary_maker_fee_values(arg0: &OrderSummary) : (u64, u64) {
        (arg0.maker_fee_bps, arg0.maker_fee_reserve)
    }

    public fun order_summary_values(arg0: &OrderSummary) : (u64, u128, u64, u64, u64, address) {
        (arg0.id, arg0.price, arg0.timestamp, arg0.remaining_amount, arg0.original_amount, arg0.sender)
    }

    public fun place_ask_order<T0, T1>(arg0: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::GlobalConfig, arg1: &mut OrderBook<T0, T1>, arg2: &mut 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::token::PointTokenMarket<T0>, arg3: 0x2::token::Token<T0>, arg4: u128, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : u64 {
        0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::package_version::assert_domain_enabled(arg0, 0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::orderbook_domain());
        let v0 = token_into_balance<T0>(arg3, arg2, arg6);
        let v1 = new_order<T0>(v0, arg4, arg5, arg6);
        v1.maker_fee_bps = arg1.coin_quote_maker_fee_bps;
        let v2 = place_ask_order_internal<T0, T1>(arg1, v1, arg6);
        add_order_point_token_market_binding<T0, T1, T0>(arg1, v2, arg2);
        v2
    }

    public fun place_ask_order_from_score<T0, T1>(arg0: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::GlobalConfig, arg1: &mut OrderBook<T0, T1>, arg2: &mut 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::token::PointTokenMarket<T0>, arg3: &mut 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::scoreboard::Scoreboard, arg4: u64, arg5: u128, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : u64 {
        assert_score_trading_scale<T0>(arg2);
        let v0 = 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::token::mint_amount<T0>(arg0, arg2, arg3, arg4, arg6, arg7);
        place_ask_order<T0, T1>(arg0, arg1, arg2, v0, arg5, arg6, arg7)
    }

    fun place_ask_order_internal<T0, T1>(arg0: &mut OrderBook<T0, T1>, arg1: Order<T0>, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        assert_ask_meets_minimum_notional<T0, T1>(arg0, &arg1);
        let v0 = allocate_order_id<T0, T1>(arg0);
        arg1.id = v0;
        0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::event::emit_order_placed(0x2::object::id<OrderBook<T0, T1>>(arg0), 0, v0, arg1.sender, 0x1::type_name::with_original_ids<T0>(), 0x1::type_name::with_original_ids<T1>(), arg1.price, arg1.timestamp, arg1.original_amount);
        add_order_location<T0, T1>(arg0, v0, 0, arg1.price);
        let v1 = &mut arg0.asks;
        add_order_to_side<T0>(v1, arg1, arg2);
        v0
    }

    public fun place_bid_order_coin_quote<T0, T1>(arg0: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::GlobalConfig, arg1: &mut OrderBook<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: u128, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : u64 {
        0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::package_version::assert_domain_enabled(arg0, 0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::orderbook_domain());
        let v0 = 0x2::coin::value<T1>(&arg2);
        let v1 = arg1.coin_quote_maker_fee_bps;
        let v2 = coin_quote_notional_from_gross(v0, v1);
        assert!(v2 > 0, 2);
        let v3 = coin_quote_fee_amount_bps(v2, v1);
        let v4 = v0 - 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::point_math::checked_add(v2, v3);
        let v5 = 0x2::coin::into_balance<T1>(arg2);
        if (v4 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v5, v4), arg5), 0x2::tx_context::sender(arg5));
        } else {
            0x2::balance::destroy_zero<T1>(0x2::balance::split<T1>(&mut v5, v4));
        };
        let v6 = new_order<T1>(v5, arg3, arg4, arg5);
        0x2::balance::join<T1>(&mut v6.maker_fee_reserve, 0x2::balance::split<T1>(&mut v5, v3));
        v6.maker_fee_bps = v1;
        place_bid_order_internal<T0, T1>(arg1, v6, arg5)
    }

    fun place_bid_order_internal<T0, T1>(arg0: &mut OrderBook<T0, T1>, arg1: Order<T1>, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(0x2::balance::value<T1>(&arg1.input) >= arg0.minimum_quote_notional, 15);
        let v0 = allocate_order_id<T0, T1>(arg0);
        arg1.id = v0;
        0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::event::emit_order_placed(0x2::object::id<OrderBook<T0, T1>>(arg0), 1, v0, arg1.sender, 0x1::type_name::with_original_ids<T0>(), 0x1::type_name::with_original_ids<T1>(), arg1.price, arg1.timestamp, arg1.original_amount);
        add_order_location<T0, T1>(arg0, v0, 1, arg1.price);
        let v1 = &mut arg0.bids;
        add_order_to_side<T1>(v1, arg1, arg2);
        v0
    }

    fun price_at_side_level<T0>(arg0: &OrderSide<T0>, arg1: u64) : u128 {
        let v0 = 0x337f85b36287d38cdf2bb60964187f432dd3abeb5228f8a2db4cff7a9f47a87d::linked_table::front<u128, PriceLevelIndexEntry>(&arg0.price_index);
        let v1 = 0;
        while (0x1::option::is_some<u128>(&v0)) {
            let v2 = *0x1::option::borrow<u128>(&v0);
            if (v1 == arg1) {
                return v2
            };
            v0 = 0x337f85b36287d38cdf2bb60964187f432dd3abeb5228f8a2db4cff7a9f47a87d::linked_table::next<u128, PriceLevelIndexEntry>(&arg0.price_index, v2);
            v1 = v1 + 1;
        };
        abort 5
    }

    fun price_insert_before<T0>(arg0: &OrderSide<T0>, arg1: u128) : 0x1::option::Option<u128> {
        let v0 = 0x337f85b36287d38cdf2bb60964187f432dd3abeb5228f8a2db4cff7a9f47a87d::linked_table::front<u128, PriceLevelIndexEntry>(&arg0.price_index);
        while (0x1::option::is_some<u128>(&v0)) {
            let v1 = *0x1::option::borrow<u128>(&v0);
            if (is_better_price<T0>(arg0, arg1, v1)) {
                return 0x1::option::some<u128>(v1)
            };
            v0 = 0x337f85b36287d38cdf2bb60964187f432dd3abeb5228f8a2db4cff7a9f47a87d::linked_table::next<u128, PriceLevelIndexEntry>(&arg0.price_index, v1);
        };
        0x1::option::none<u128>()
    }

    public fun price_level_summary_values(arg0: &PriceLevelSummary) : (u128, u64, u64) {
        (arg0.price, arg0.order_count, arg0.total_remaining)
    }

    fun quote_to_base_amount_round_down_capped(arg0: u64, arg1: u128, arg2: u8, arg3: u8, arg4: u64) : u64 {
        assert!(arg1 > 0, 1);
        div_floor_capped_to_u64(quote_to_base_numerator(arg0, arg2), quote_to_base_denominator(arg1, arg3), arg4)
    }

    fun quote_to_base_amount_round_up(arg0: u64, arg1: u128, arg2: u8, arg3: u8) : u64 {
        assert!(arg1 > 0, 1);
        0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::point_math::div_ceil_to_u64(quote_to_base_numerator(arg0, arg2), quote_to_base_denominator(arg1, arg3))
    }

    fun quote_to_base_denominator(arg0: u128, arg1: u8) : u256 {
        0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::point_math::checked_mul_u256((arg0 as u256), 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::point_math::decimal_scale(arg1))
    }

    fun quote_to_base_numerator(arg0: u64, arg1: u8) : u256 {
        0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::point_math::checked_mul_u256(0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::point_math::checked_mul_u256((arg0 as u256), 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::point_math::decimal_scale(arg1)), 1000000000000000000)
    }

    fun remove_ask_order<T0, T1>(arg0: &mut OrderBook<T0, T1>, arg1: u128, arg2: u64) : Order<T0> {
        let v0 = &mut arg0.asks;
        remove_order_location<T0, T1>(arg0, arg2);
        remove_order_from_side<T0>(v0, arg1, arg2)
    }

    fun remove_bid_order<T0, T1>(arg0: &mut OrderBook<T0, T1>, arg1: u128, arg2: u64) : Order<T1> {
        let v0 = &mut arg0.bids;
        remove_order_location<T0, T1>(arg0, arg2);
        remove_order_from_side<T1>(v0, arg1, arg2)
    }

    fun remove_empty_ask_order<T0, T1>(arg0: &mut OrderBook<T0, T1>, arg1: u128, arg2: u64) {
        let v0 = remove_ask_order<T0, T1>(arg0, arg1, arg2);
        remove_order_point_token_market_binding<T0, T1>(arg0, arg2);
        let Order {
            id                 : _,
            price              : _,
            timestamp          : _,
            input              : v4,
            maker_fee_reserve  : v5,
            original_amount    : _,
            maker_fee_bps      : _,
            maker_quote_filled : _,
            sender             : _,
        } = v0;
        0x2::balance::destroy_zero<T0>(v4);
        0x2::balance::destroy_zero<T0>(v5);
    }

    fun remove_empty_bid_order<T0, T1>(arg0: &mut OrderBook<T0, T1>, arg1: u128, arg2: u64) {
        let v0 = remove_bid_order<T0, T1>(arg0, arg1, arg2);
        remove_order_point_token_market_binding<T0, T1>(arg0, arg2);
        let Order {
            id                 : _,
            price              : _,
            timestamp          : _,
            input              : v4,
            maker_fee_reserve  : v5,
            original_amount    : _,
            maker_fee_bps      : _,
            maker_quote_filled : _,
            sender             : _,
        } = v0;
        0x2::balance::destroy_zero<T1>(v4);
        0x2::balance::destroy_zero<T1>(v5);
    }

    fun remove_order_from_side<T0>(arg0: &mut OrderSide<T0>, arg1: u128, arg2: u64) : Order<T0> {
        let v0 = 0x337f85b36287d38cdf2bb60964187f432dd3abeb5228f8a2db4cff7a9f47a87d::keyed_big_vector::borrow_by_key_mut<u128, PriceLevel<T0>>(&mut arg0.levels, arg1);
        arg0.order_count = arg0.order_count - 1;
        if (0x337f85b36287d38cdf2bb60964187f432dd3abeb5228f8a2db4cff7a9f47a87d::linked_table::is_empty<u64, Order<T0>>(&v0.orders)) {
            let PriceLevel {
                price  : _,
                orders : v2,
            } = 0x337f85b36287d38cdf2bb60964187f432dd3abeb5228f8a2db4cff7a9f47a87d::keyed_big_vector::swap_remove_by_key<u128, PriceLevel<T0>>(&mut arg0.levels, arg1);
            0x337f85b36287d38cdf2bb60964187f432dd3abeb5228f8a2db4cff7a9f47a87d::linked_table::destroy_empty<u64, Order<T0>>(v2);
            if (0x1::option::is_some<u128>(&arg0.best_price) && *0x1::option::borrow<u128>(&arg0.best_price) == arg1) {
                let PriceLevelIndexEntry {  } = 0x337f85b36287d38cdf2bb60964187f432dd3abeb5228f8a2db4cff7a9f47a87d::linked_table::remove<u128, PriceLevelIndexEntry>(&mut arg0.price_index, arg1);
                arg0.best_price = 0x337f85b36287d38cdf2bb60964187f432dd3abeb5228f8a2db4cff7a9f47a87d::linked_table::front<u128, PriceLevelIndexEntry>(&arg0.price_index);
            } else {
                let PriceLevelIndexEntry {  } = 0x337f85b36287d38cdf2bb60964187f432dd3abeb5228f8a2db4cff7a9f47a87d::linked_table::remove<u128, PriceLevelIndexEntry>(&mut arg0.price_index, arg1);
            };
        };
        0x337f85b36287d38cdf2bb60964187f432dd3abeb5228f8a2db4cff7a9f47a87d::linked_table::remove<u64, Order<T0>>(&mut v0.orders, arg2)
    }

    fun remove_order_location<T0, T1>(arg0: &mut OrderBook<T0, T1>, arg1: u64) {
        let v0 = OrderLocationKey{pos0: arg1};
        let OrderLocation {
            side  : _,
            price : _,
        } = 0x2::dynamic_field::remove<OrderLocationKey, OrderLocation>(&mut arg0.id, v0);
    }

    fun remove_order_point_token_market_binding<T0, T1>(arg0: &mut OrderBook<T0, T1>, arg1: u64) {
        let v0 = OrderPointTokenMarketKey{pos0: arg1};
        if (0x2::dynamic_field::exists<OrderPointTokenMarketKey>(&arg0.id, v0)) {
            let OrderPointTokenMarketBinding {  } = 0x2::dynamic_field::remove<OrderPointTokenMarketKey, OrderPointTokenMarketBinding>(&mut arg0.id, v0);
        };
    }

    public fun set_coin_quote_fee_rates<T0, T1>(arg0: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::GlobalConfig, arg1: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::admin::AdminCap, arg2: &mut OrderBook<T0, T1>, arg3: u64, arg4: u64) {
        0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::package_version::assert_version(arg0);
        assert!(arg3 <= 10000, 9);
        assert!(arg4 <= 10000, 9);
        arg2.coin_quote_maker_fee_bps = arg3;
        arg2.coin_quote_taker_fee_bps = arg4;
        0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::event::emit_orderbook_coin_quote_fee_config_updated(0x2::object::id<OrderBook<T0, T1>>(arg2), arg3, arg4);
    }

    public fun set_minimum_quote_notional<T0, T1>(arg0: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::GlobalConfig, arg1: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::admin::AdminCap, arg2: &mut OrderBook<T0, T1>, arg3: u64) {
        0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::package_version::assert_version(arg0);
        assert!(arg3 > 0, 15);
        arg2.minimum_quote_notional = arg3;
        0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::event::emit_orderbook_minimum_quote_notional_updated(0x2::object::id<OrderBook<T0, T1>>(arg2), arg3);
    }

    fun settle_ask_fill_coin_quote<T0, T1>(arg0: 0x2::object::ID, arg1: &mut Order<T0>, arg2: &mut 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::token::PointTokenMarket<T0>, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : (u64, 0x2::balance::Balance<T1>, address) {
        let (v0, v1, v2, v3) = settle_ask_fill_coin_quote_result<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::token::transfer_token_to<T0>(arg2, v3, 0x2::tx_context::sender(arg6), arg6);
        (v0, v1, v2)
    }

    fun settle_ask_fill_coin_quote_result<T0, T1>(arg0: 0x2::object::ID, arg1: &mut Order<T0>, arg2: &mut 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::token::PointTokenMarket<T0>, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : (u64, 0x2::balance::Balance<T1>, address, 0x2::token::Token<T0>) {
        let v0 = 0x2::balance::split<T0>(&mut arg1.input, arg4);
        let v1 = 0x2::balance::value<T0>(&arg1.input);
        let v2 = 0x2::coin::value<T1>(&arg3);
        let v3 = maker_fee_for_fill<T0>(arg1, v2);
        let v4 = 0x2::coin::into_balance<T1>(arg3);
        0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::token::decrease_holding_by_token_amount<T0>(arg2, arg1.sender, arg4);
        0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::token::increase_holding_by_token_amount<T0>(arg2, 0x2::tx_context::sender(arg6), arg4);
        let v5 = token_from_balance<T0>(arg2, v0, arg6);
        if (0x2::balance::value<T1>(&v4) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v4, arg6), arg1.sender);
        } else {
            0x2::balance::destroy_zero<T1>(v4);
        };
        0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::event::emit_order_filled(arg0, 0, arg5, arg1.sender, 0x2::tx_context::sender(arg6), 0x1::type_name::with_original_ids<T0>(), 0x1::type_name::with_original_ids<T1>(), arg1.price, arg1.timestamp, arg4, v2, v1);
        (v1, 0x2::balance::split<T1>(&mut v4, v3), arg1.sender, v5)
    }

    fun settle_bid_fill_coin_quote<T0, T1>(arg0: 0x2::object::ID, arg1: &mut Order<T1>, arg2: &mut 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::token::PointTokenMarket<T0>, arg3: 0x2::token::Token<T0>, arg4: u64, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : (u64, 0x2::balance::Balance<T1>, 0x2::balance::Balance<T1>, 0x2::balance::Balance<T1>, address) {
        let (v0, v1, v2, v3, v4, v5) = settle_bid_fill_coin_quote_result<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::token::transfer_token_to<T0>(arg2, v5, v4, arg7);
        (v0, v1, v2, v3, v4)
    }

    fun settle_bid_fill_coin_quote_result<T0, T1>(arg0: 0x2::object::ID, arg1: &mut Order<T1>, arg2: &mut 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::token::PointTokenMarket<T0>, arg3: 0x2::token::Token<T0>, arg4: u64, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : (u64, 0x2::balance::Balance<T1>, 0x2::balance::Balance<T1>, 0x2::balance::Balance<T1>, address, 0x2::token::Token<T0>) {
        let v0 = 0x2::balance::split<T1>(&mut arg1.input, arg4);
        let v1 = 0x2::balance::value<T1>(&arg1.input);
        let v2 = 0x2::token::value<T0>(&arg3);
        let v3 = coin_quote_fee_amount_bps(arg4, arg5);
        let v4 = if (v3 > 0) {
            0x2::balance::split<T1>(&mut v0, v3)
        } else {
            0x2::balance::zero<T1>()
        };
        let v5 = maker_fee_for_fill<T1>(arg1, arg4);
        assert!(v5 <= 0x2::balance::value<T1>(&arg1.maker_fee_reserve), 3);
        0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::token::decrease_holding_by_token_amount<T0>(arg2, 0x2::tx_context::sender(arg7), v2);
        0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::token::increase_holding_by_token_amount<T0>(arg2, arg1.sender, v2);
        0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::event::emit_order_filled(arg0, 1, arg6, arg1.sender, 0x2::tx_context::sender(arg7), 0x1::type_name::with_original_ids<T0>(), 0x1::type_name::with_original_ids<T1>(), arg1.price, arg1.timestamp, v2, arg4, v1);
        (v1, v4, 0x2::balance::split<T1>(&mut arg1.maker_fee_reserve, v5), v0, arg1.sender, arg3)
    }

    fun share_orderbook<T0, T1>(arg0: u8, arg1: u8, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 15);
        let v0 = 0x2::object::new(arg3);
        let v1 = new_order_side<T0>(false, arg3);
        let v2 = OrderBook<T0, T1>{
            id                       : v0,
            asks                     : v1,
            bids                     : new_order_side<T1>(true, arg3),
            decimals_t               : arg0,
            decimals_t1              : arg1,
            next_order_id            : 0,
            coin_quote_maker_fee_bps : 0,
            coin_quote_taker_fee_bps : 0,
            coin_quote_fee_vault     : 0x2::balance::zero<T1>(),
            minimum_quote_notional   : arg2,
        };
        let v3 = OrderbookCreated{
            orderbook_id           : 0x2::object::id<OrderBook<T0, T1>>(&v2),
            base_type              : 0x1::type_name::with_original_ids<T0>(),
            quote_type             : 0x1::type_name::with_original_ids<T1>(),
            base_decimals          : arg0,
            quote_decimals         : arg1,
            minimum_quote_notional : arg2,
        };
        0x2::event::emit<OrderbookCreated>(v3);
        0x2::transfer::share_object<OrderBook<T0, T1>>(v2);
    }

    fun side_count<T0>(arg0: &OrderSide<T0>) : u64 {
        arg0.order_count
    }

    fun side_level_count<T0>(arg0: &OrderSide<T0>) : u64 {
        0x337f85b36287d38cdf2bb60964187f432dd3abeb5228f8a2db4cff7a9f47a87d::linked_table::length<u128, PriceLevelIndexEntry>(&arg0.price_index)
    }

    fun split_coin_quote_payment<T0, T1>(arg0: &mut OrderBook<T0, T1>, arg1: &mut 0x2::coin::Coin<T1>, arg2: u64, arg3: u8, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = coin_quote_fee_amount<T0, T1>(arg0, arg2);
        let v1 = 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::point_math::checked_add(arg2, v0);
        let v2 = 0x2::coin::split<T1>(arg1, v1, arg5);
        if (v0 > 0) {
            0x2::balance::join<T1>(&mut arg0.coin_quote_fee_vault, 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v2, v0, arg5)));
            0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::event::emit_orderbook_coin_quote_fee_accrued(0x2::object::id<OrderBook<T0, T1>>(arg0), arg3, arg4, 1, 0x2::tx_context::sender(arg5), 0x1::type_name::with_original_ids<T1>(), v1, v0);
        };
        v2
    }

    public fun taker_fee_role() : u8 {
        1
    }

    fun token_from_balance<T0>(arg0: &mut 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::token::PointTokenMarket<T0>, arg1: 0x2::balance::Balance<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::token::Token<T0> {
        let (v0, v1) = 0x2::token::from_coin<T0>(0x2::coin::from_balance<T0>(arg1, arg2), arg2);
        let (_, _, _, _) = 0x2::token::confirm_with_treasury_cap<T0>(0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::token::internal_borrow_mut_treasury_cap<T0>(arg0), v1, arg2);
        v0
    }

    fun token_into_balance<T0>(arg0: 0x2::token::Token<T0>, arg1: &mut 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::token::PointTokenMarket<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let (v0, v1) = 0x2::token::to_coin<T0>(arg0, arg2);
        let (_, _, _, _) = 0x2::token::confirm_with_treasury_cap<T0>(0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::token::internal_borrow_mut_treasury_cap<T0>(arg1), v1, arg2);
        0x2::coin::into_balance<T0>(v0)
    }

    // decompiled from Move bytecode v7
}

