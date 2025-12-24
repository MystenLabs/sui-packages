module 0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::tpsl {
    struct TakeProfitStopLoss has drop, store {
        trigger_below: vector<ConditionalOrder>,
        trigger_above: vector<ConditionalOrder>,
    }

    struct ConditionalOrder has copy, drop, store {
        conditional_order_id: u64,
        condition: Condition,
        pending_order: PendingOrder,
    }

    struct Condition has copy, drop, store {
        trigger_below_price: bool,
        trigger_price: u64,
    }

    struct PendingOrder has copy, drop, store {
        is_limit_order: bool,
        client_order_id: u64,
        order_type: 0x1::option::Option<u8>,
        self_matching_option: u8,
        price: 0x1::option::Option<u64>,
        quantity: u64,
        is_bid: bool,
        pay_with_deep: bool,
        expire_timestamp: 0x1::option::Option<u64>,
    }

    struct ConditionalOrderAdded has copy, drop {
        manager_id: 0x2::object::ID,
        conditional_order_id: u64,
        conditional_order: ConditionalOrder,
        timestamp: u64,
    }

    struct ConditionalOrderCancelled has copy, drop {
        manager_id: 0x2::object::ID,
        conditional_order_id: u64,
        conditional_order: ConditionalOrder,
        timestamp: u64,
    }

    struct ConditionalOrderExecuted has copy, drop {
        manager_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        conditional_order_id: u64,
        conditional_order: ConditionalOrder,
        timestamp: u64,
    }

    struct ConditionalOrderInsufficientFunds has copy, drop {
        manager_id: 0x2::object::ID,
        conditional_order_id: u64,
        conditional_order: ConditionalOrder,
        timestamp: u64,
    }

    public(friend) fun add_conditional_order<T0, T1>(arg0: &mut TakeProfitStopLoss, arg1: &0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::pool::Pool<T0, T1>, arg2: 0x2::object::ID, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::margin_registry::MarginRegistry, arg6: u64, arg7: Condition, arg8: PendingOrder, arg9: &0x2::clock::Clock) {
        if (is_limit_order(&arg8)) {
            assert!(0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::pool::check_limit_order_params<T0, T1>(arg1, *0x1::option::borrow<u64>(&arg8.price), arg8.quantity, *0x1::option::borrow<u64>(&arg8.expire_timestamp), arg9), 6);
        } else {
            assert!(0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::pool::check_market_order_params<T0, T1>(arg1, arg8.quantity), 6);
        };
        let v0 = 0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::oracle::calculate_price<T0, T1>(arg5, arg3, arg4, arg9);
        let v1 = arg7.trigger_below_price;
        let v2 = arg7.trigger_price;
        assert!(v1 && v2 <= v0 || !v1 && v2 >= v0, 1);
        assert!(num_conditional_orders(arg0) < 0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::margin_constants::max_conditional_orders(), 3);
        let v3 = get_conditional_order(arg0, arg6);
        assert!(0x1::option::is_none<ConditionalOrder>(&v3), 5);
        let v4 = ConditionalOrder{
            conditional_order_id : arg6,
            condition            : arg7,
            pending_order        : arg8,
        };
        if (v1) {
            0x1::vector::push_back<ConditionalOrder>(&mut arg0.trigger_below, v4);
            let v5 = &mut arg0.trigger_below;
            let v6 = 0x1::vector::length<ConditionalOrder>(v5);
            if (v6 < 2) {
            } else {
                let v7 = 1;
                while (v7 < v6) {
                    while (v7 > 0 && !(0x1::vector::borrow<ConditionalOrder>(v5, v7 - 1).condition.trigger_price >= 0x1::vector::borrow<ConditionalOrder>(v5, v7).condition.trigger_price)) {
                        0x1::vector::swap<ConditionalOrder>(v5, v7, v7 - 1);
                        v7 = v7 - 1;
                    };
                    v7 = v7 + 1;
                };
            };
        } else {
            0x1::vector::push_back<ConditionalOrder>(&mut arg0.trigger_above, v4);
            let v8 = &mut arg0.trigger_above;
            let v9 = 0x1::vector::length<ConditionalOrder>(v8);
            if (v9 < 2) {
            } else {
                let v10 = 1;
                while (v10 < v9) {
                    while (v10 > 0 && !(0x1::vector::borrow<ConditionalOrder>(v8, v10 - 1).condition.trigger_price <= 0x1::vector::borrow<ConditionalOrder>(v8, v10).condition.trigger_price)) {
                        0x1::vector::swap<ConditionalOrder>(v8, v10, v10 - 1);
                        v10 = v10 - 1;
                    };
                    v10 = v10 + 1;
                };
            };
        };
        let v11 = ConditionalOrderAdded{
            manager_id           : arg2,
            conditional_order_id : arg6,
            conditional_order    : v4,
            timestamp            : 0x2::clock::timestamp_ms(arg9),
        };
        0x2::event::emit<ConditionalOrderAdded>(v11);
    }

    public(friend) fun cancel_all_conditional_orders(arg0: &mut TakeProfitStopLoss, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = arg0.trigger_below;
        0x1::vector::reverse<ConditionalOrder>(&mut v1);
        let v2 = 0;
        while (v2 < 0x1::vector::length<ConditionalOrder>(&v1)) {
            let v3 = 0x1::vector::pop_back<ConditionalOrder>(&mut v1);
            let v4 = ConditionalOrderCancelled{
                manager_id           : arg1,
                conditional_order_id : v3.conditional_order_id,
                conditional_order    : v3,
                timestamp            : v0,
            };
            0x2::event::emit<ConditionalOrderCancelled>(v4);
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<ConditionalOrder>(v1);
        let v5 = arg0.trigger_above;
        0x1::vector::reverse<ConditionalOrder>(&mut v5);
        let v6 = 0;
        while (v6 < 0x1::vector::length<ConditionalOrder>(&v5)) {
            let v7 = 0x1::vector::pop_back<ConditionalOrder>(&mut v5);
            let v8 = ConditionalOrderCancelled{
                manager_id           : arg1,
                conditional_order_id : v7.conditional_order_id,
                conditional_order    : v7,
                timestamp            : v0,
            };
            0x2::event::emit<ConditionalOrderCancelled>(v8);
            v6 = v6 + 1;
        };
        0x1::vector::destroy_empty<ConditionalOrder>(v5);
        arg0.trigger_below = 0x1::vector::empty<ConditionalOrder>();
        arg0.trigger_above = 0x1::vector::empty<ConditionalOrder>();
    }

    public(friend) fun cancel_conditional_order(arg0: &mut TakeProfitStopLoss, arg1: 0x2::object::ID, arg2: u64, arg3: &0x2::clock::Clock) {
        let v0 = find_and_remove_order(arg0, arg2);
        assert!(0x1::option::is_some<ConditionalOrder>(&v0), 2);
        let v1 = ConditionalOrderCancelled{
            manager_id           : arg1,
            conditional_order_id : arg2,
            conditional_order    : 0x1::option::destroy_some<ConditionalOrder>(v0),
            timestamp            : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<ConditionalOrderCancelled>(v1);
    }

    public fun client_order_id(arg0: &PendingOrder) : u64 {
        arg0.client_order_id
    }

    public fun condition(arg0: &ConditionalOrder) : Condition {
        arg0.condition
    }

    public fun conditional_order_id(arg0: &ConditionalOrder) : u64 {
        arg0.conditional_order_id
    }

    public(friend) fun emit_insufficient_funds_event(arg0: &TakeProfitStopLoss, arg1: 0x2::object::ID, arg2: u64, arg3: &0x2::clock::Clock) {
        let v0 = get_conditional_order(arg0, arg2);
        if (0x1::option::is_some<ConditionalOrder>(&v0)) {
            let v1 = ConditionalOrderInsufficientFunds{
                manager_id           : arg1,
                conditional_order_id : arg2,
                conditional_order    : 0x1::option::destroy_some<ConditionalOrder>(v0),
                timestamp            : 0x2::clock::timestamp_ms(arg3),
            };
            0x2::event::emit<ConditionalOrderInsufficientFunds>(v1);
        };
    }

    public fun expire_timestamp(arg0: &PendingOrder) : 0x1::option::Option<u64> {
        arg0.expire_timestamp
    }

    fun find_and_remove_order(arg0: &mut TakeProfitStopLoss, arg1: u64) : 0x1::option::Option<ConditionalOrder> {
        let v0 = 0;
        while (v0 < 0x1::vector::length<ConditionalOrder>(&arg0.trigger_below)) {
            if (0x1::vector::borrow<ConditionalOrder>(&arg0.trigger_below, v0).conditional_order_id == arg1) {
                return 0x1::option::some<ConditionalOrder>(0x1::vector::remove<ConditionalOrder>(&mut arg0.trigger_below, v0))
            };
            v0 = v0 + 1;
        };
        v0 = 0;
        while (v0 < 0x1::vector::length<ConditionalOrder>(&arg0.trigger_above)) {
            if (0x1::vector::borrow<ConditionalOrder>(&arg0.trigger_above, v0).conditional_order_id == arg1) {
                return 0x1::option::some<ConditionalOrder>(0x1::vector::remove<ConditionalOrder>(&mut arg0.trigger_above, v0))
            };
            v0 = v0 + 1;
        };
        0x1::option::none<ConditionalOrder>()
    }

    public fun get_conditional_order(arg0: &TakeProfitStopLoss, arg1: u64) : 0x1::option::Option<ConditionalOrder> {
        let v0 = 0;
        while (v0 < 0x1::vector::length<ConditionalOrder>(&arg0.trigger_below)) {
            let v1 = 0x1::vector::borrow<ConditionalOrder>(&arg0.trigger_below, v0);
            if (v1.conditional_order_id == arg1) {
                return 0x1::option::some<ConditionalOrder>(*v1)
            };
            v0 = v0 + 1;
        };
        v0 = 0;
        while (v0 < 0x1::vector::length<ConditionalOrder>(&arg0.trigger_above)) {
            let v2 = 0x1::vector::borrow<ConditionalOrder>(&arg0.trigger_above, v0);
            if (v2.conditional_order_id == arg1) {
                return 0x1::option::some<ConditionalOrder>(*v2)
            };
            v0 = v0 + 1;
        };
        0x1::option::none<ConditionalOrder>()
    }

    public fun is_bid(arg0: &PendingOrder) : bool {
        arg0.is_bid
    }

    public fun is_limit_order(arg0: &PendingOrder) : bool {
        arg0.is_limit_order
    }

    public(friend) fun new() : TakeProfitStopLoss {
        TakeProfitStopLoss{
            trigger_below : 0x1::vector::empty<ConditionalOrder>(),
            trigger_above : 0x1::vector::empty<ConditionalOrder>(),
        }
    }

    public fun new_condition(arg0: bool, arg1: u64) : Condition {
        Condition{
            trigger_below_price : arg0,
            trigger_price       : arg1,
        }
    }

    public fun new_pending_limit_order(arg0: u64, arg1: u8, arg2: u8, arg3: u64, arg4: u64, arg5: bool, arg6: bool, arg7: u64) : PendingOrder {
        assert!(arg1 == 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::constants::no_restriction() || arg1 == 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::constants::immediate_or_cancel(), 4);
        PendingOrder{
            is_limit_order       : true,
            client_order_id      : arg0,
            order_type           : 0x1::option::some<u8>(arg1),
            self_matching_option : arg2,
            price                : 0x1::option::some<u64>(arg3),
            quantity             : arg4,
            is_bid               : arg5,
            pay_with_deep        : arg6,
            expire_timestamp     : 0x1::option::some<u64>(arg7),
        }
    }

    public fun new_pending_market_order(arg0: u64, arg1: u8, arg2: u64, arg3: bool, arg4: bool) : PendingOrder {
        PendingOrder{
            is_limit_order       : false,
            client_order_id      : arg0,
            order_type           : 0x1::option::none<u8>(),
            self_matching_option : arg1,
            price                : 0x1::option::none<u64>(),
            quantity             : arg2,
            is_bid               : arg3,
            pay_with_deep        : arg4,
            expire_timestamp     : 0x1::option::none<u64>(),
        }
    }

    public fun num_conditional_orders(arg0: &TakeProfitStopLoss) : u64 {
        ((0x1::vector::length<ConditionalOrder>(&arg0.trigger_below) + 0x1::vector::length<ConditionalOrder>(&arg0.trigger_above)) as u64)
    }

    public fun order_type(arg0: &PendingOrder) : 0x1::option::Option<u8> {
        arg0.order_type
    }

    public fun pay_with_deep(arg0: &PendingOrder) : bool {
        arg0.pay_with_deep
    }

    public fun pending_order(arg0: &ConditionalOrder) : PendingOrder {
        arg0.pending_order
    }

    public fun price(arg0: &PendingOrder) : 0x1::option::Option<u64> {
        arg0.price
    }

    public fun quantity(arg0: &PendingOrder) : u64 {
        arg0.quantity
    }

    public(friend) fun remove_executed_conditional_order(arg0: &mut TakeProfitStopLoss, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: u64, arg4: &0x2::clock::Clock) {
        let v0 = find_and_remove_order(arg0, arg3);
        assert!(0x1::option::is_some<ConditionalOrder>(&v0), 2);
        let v1 = ConditionalOrderExecuted{
            manager_id           : arg1,
            pool_id              : arg2,
            conditional_order_id : arg3,
            conditional_order    : 0x1::option::destroy_some<ConditionalOrder>(v0),
            timestamp            : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<ConditionalOrderExecuted>(v1);
    }

    public(friend) fun remove_executed_conditional_orders(arg0: &mut TakeProfitStopLoss, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: vector<u64>, arg4: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let v1 = 0x1::vector::empty<ConditionalOrder>();
        let v2 = 0x1::vector::empty<ConditionalOrder>();
        let v3 = arg0.trigger_below;
        0x1::vector::reverse<ConditionalOrder>(&mut v3);
        let v4 = 0;
        while (v4 < 0x1::vector::length<ConditionalOrder>(&v3)) {
            let v5 = 0x1::vector::pop_back<ConditionalOrder>(&mut v3);
            if (0x1::vector::contains<u64>(&arg3, &v5.conditional_order_id)) {
                0x1::vector::push_back<ConditionalOrder>(&mut v1, v5);
            } else {
                0x1::vector::push_back<ConditionalOrder>(&mut v2, v5);
            };
            v4 = v4 + 1;
        };
        0x1::vector::destroy_empty<ConditionalOrder>(v3);
        arg0.trigger_below = v2;
        let v6 = 0x1::vector::empty<ConditionalOrder>();
        let v7 = 0x1::vector::empty<ConditionalOrder>();
        let v8 = arg0.trigger_above;
        0x1::vector::reverse<ConditionalOrder>(&mut v8);
        let v9 = 0;
        while (v9 < 0x1::vector::length<ConditionalOrder>(&v8)) {
            let v10 = 0x1::vector::pop_back<ConditionalOrder>(&mut v8);
            if (0x1::vector::contains<u64>(&arg3, &v10.conditional_order_id)) {
                0x1::vector::push_back<ConditionalOrder>(&mut v6, v10);
            } else {
                0x1::vector::push_back<ConditionalOrder>(&mut v7, v10);
            };
            v9 = v9 + 1;
        };
        0x1::vector::destroy_empty<ConditionalOrder>(v8);
        arg0.trigger_above = v7;
        0x1::vector::reverse<ConditionalOrder>(&mut v1);
        let v11 = 0;
        while (v11 < 0x1::vector::length<ConditionalOrder>(&v1)) {
            let v12 = 0x1::vector::pop_back<ConditionalOrder>(&mut v1);
            let v13 = ConditionalOrderExecuted{
                manager_id           : arg1,
                pool_id              : arg2,
                conditional_order_id : v12.conditional_order_id,
                conditional_order    : v12,
                timestamp            : v0,
            };
            0x2::event::emit<ConditionalOrderExecuted>(v13);
            v11 = v11 + 1;
        };
        0x1::vector::destroy_empty<ConditionalOrder>(v1);
        0x1::vector::reverse<ConditionalOrder>(&mut v6);
        let v14 = 0;
        while (v14 < 0x1::vector::length<ConditionalOrder>(&v6)) {
            let v15 = 0x1::vector::pop_back<ConditionalOrder>(&mut v6);
            let v16 = ConditionalOrderExecuted{
                manager_id           : arg1,
                pool_id              : arg2,
                conditional_order_id : v15.conditional_order_id,
                conditional_order    : v15,
                timestamp            : v0,
            };
            0x2::event::emit<ConditionalOrderExecuted>(v16);
            v14 = v14 + 1;
        };
        0x1::vector::destroy_empty<ConditionalOrder>(v6);
    }

    public fun self_matching_option(arg0: &PendingOrder) : u8 {
        arg0.self_matching_option
    }

    public(friend) fun trigger_above(arg0: &TakeProfitStopLoss) : &vector<ConditionalOrder> {
        &arg0.trigger_above
    }

    public fun trigger_above_orders(arg0: &TakeProfitStopLoss) : &vector<ConditionalOrder> {
        &arg0.trigger_above
    }

    public(friend) fun trigger_below(arg0: &TakeProfitStopLoss) : &vector<ConditionalOrder> {
        &arg0.trigger_below
    }

    public fun trigger_below_orders(arg0: &TakeProfitStopLoss) : &vector<ConditionalOrder> {
        &arg0.trigger_below
    }

    public fun trigger_below_price(arg0: &Condition) : bool {
        arg0.trigger_below_price
    }

    public fun trigger_price(arg0: &Condition) : u64 {
        arg0.trigger_price
    }

    // decompiled from Move bytecode v6
}

