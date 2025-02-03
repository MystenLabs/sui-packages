module 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order_info {
    struct OrderInfo has copy, drop, store {
        pool_id: 0x2::object::ID,
        order_id: u128,
        balance_manager_id: 0x2::object::ID,
        client_order_id: u64,
        trader: address,
        order_type: u8,
        self_matching_option: u8,
        price: u64,
        is_bid: bool,
        original_quantity: u64,
        order_deep_price: 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::deep_price::OrderDeepPrice,
        expire_timestamp: u64,
        executed_quantity: u64,
        cumulative_quote_quantity: u64,
        fills: vector<0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::fill::Fill>,
        fee_is_deep: bool,
        paid_fees: u64,
        maker_fees: u64,
        epoch: u64,
        status: u8,
        market_order: bool,
        fill_limit_reached: bool,
        order_inserted: bool,
        timestamp: u64,
    }

    struct OrderFilled has copy, drop, store {
        pool_id: 0x2::object::ID,
        maker_order_id: u128,
        taker_order_id: u128,
        maker_client_order_id: u64,
        taker_client_order_id: u64,
        price: u64,
        taker_is_bid: bool,
        taker_fee: u64,
        taker_fee_is_deep: bool,
        maker_fee: u64,
        maker_fee_is_deep: bool,
        base_quantity: u64,
        quote_quantity: u64,
        maker_balance_manager_id: 0x2::object::ID,
        taker_balance_manager_id: 0x2::object::ID,
        timestamp: u64,
    }

    struct OrderPlaced has copy, drop, store {
        balance_manager_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        order_id: u128,
        client_order_id: u64,
        trader: address,
        price: u64,
        is_bid: bool,
        placed_quantity: u64,
        expire_timestamp: u64,
        timestamp: u64,
    }

    struct OrderExpired has copy, drop, store {
        balance_manager_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        order_id: u128,
        client_order_id: u64,
        trader: address,
        price: u64,
        is_bid: bool,
        original_quantity: u64,
        base_asset_quantity_canceled: u64,
        timestamp: u64,
    }

    public(friend) fun new(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: address, arg4: u8, arg5: u8, arg6: u64, arg7: u64, arg8: bool, arg9: bool, arg10: u64, arg11: u64, arg12: 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::deep_price::OrderDeepPrice, arg13: bool, arg14: u64) : OrderInfo {
        OrderInfo{
            pool_id                   : arg0,
            order_id                  : 0,
            balance_manager_id        : arg1,
            client_order_id           : arg2,
            trader                    : arg3,
            order_type                : arg4,
            self_matching_option      : arg5,
            price                     : arg6,
            is_bid                    : arg8,
            original_quantity         : arg7,
            order_deep_price          : arg12,
            expire_timestamp          : arg11,
            executed_quantity         : 0,
            cumulative_quote_quantity : 0,
            fills                     : 0x1::vector::empty<0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::fill::Fill>(),
            fee_is_deep               : arg9,
            paid_fees                 : 0,
            maker_fees                : 0,
            epoch                     : arg10,
            status                    : 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::constants::live(),
            market_order              : arg13,
            fill_limit_reached        : false,
            order_inserted            : false,
            timestamp                 : arg14,
        }
    }

    public fun balance_manager_id(arg0: &OrderInfo) : 0x2::object::ID {
        arg0.balance_manager_id
    }

    public fun price(arg0: &OrderInfo) : u64 {
        arg0.price
    }

    public(friend) fun add_fill(arg0: &mut OrderInfo, arg1: 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::fill::Fill) {
        0x1::vector::push_back<0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::fill::Fill>(&mut arg0.fills, arg1);
    }

    public(friend) fun assert_execution(arg0: &mut OrderInfo) : bool {
        if (arg0.order_type == 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::constants::post_only()) {
            assert!(arg0.executed_quantity == 0, 5);
        };
        if (arg0.order_type == 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::constants::fill_or_kill()) {
            assert!(arg0.executed_quantity == arg0.original_quantity, 6);
        };
        if (arg0.order_type == 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::constants::immediate_or_cancel()) {
            if (remaining_quantity(arg0) > 0) {
                arg0.status = 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::constants::canceled();
            } else {
                arg0.status = 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::constants::filled();
            };
            return true
        };
        if (remaining_quantity(arg0) == 0) {
            arg0.status = 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::constants::filled();
            return true
        };
        if (arg0.fill_limit_reached) {
            return true
        };
        false
    }

    public(friend) fun calculate_partial_fill_balances(arg0: &mut OrderInfo, arg1: u64, arg2: u64) : (0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balances::Balances, 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balances::Balances) {
        let v0 = 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::math::mul(arg1, 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::deep_price::deep_quantity(&arg0.order_deep_price, arg0.executed_quantity, arg0.cumulative_quote_quantity));
        arg0.paid_fees = v0;
        let v1 = &mut arg0.fills;
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::fill::Fill>(v1)) {
            let v3 = 0x1::vector::borrow_mut<0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::fill::Fill>(v1, v2);
            if (!0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::fill::expired(v3)) {
                let v4 = 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::math::mul(arg1, 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::deep_price::deep_quantity(&arg0.order_deep_price, 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::fill::base_quantity(v3), 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::fill::quote_quantity(v3)));
                if (v4 > 0) {
                    0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::fill::set_fill_taker_fee(v3, v4);
                };
            };
            v2 = v2 + 1;
        };
        let v5 = 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balances::new(0, 0, 0);
        let v6 = 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balances::new(0, 0, 0);
        0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balances::add_deep(&mut v6, v0);
        if (arg0.is_bid) {
            0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balances::add_base(&mut v5, arg0.executed_quantity);
            0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balances::add_quote(&mut v6, arg0.cumulative_quote_quantity);
        } else {
            0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balances::add_quote(&mut v5, arg0.cumulative_quote_quantity);
            0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balances::add_base(&mut v6, arg0.executed_quantity);
        };
        let v7 = remaining_quantity(arg0);
        if (order_inserted(arg0)) {
            let v8 = 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::math::mul(arg2, 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::deep_price::deep_quantity(&arg0.order_deep_price, v7, 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::math::mul(v7, price(arg0))));
            arg0.maker_fees = v8;
            0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balances::add_deep(&mut v6, v8);
            if (arg0.is_bid) {
                0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balances::add_quote(&mut v6, 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::math::mul(v7, price(arg0)));
            } else {
                0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balances::add_base(&mut v6, v7);
            };
        };
        (v5, v6)
    }

    public(friend) fun can_match(arg0: &OrderInfo, arg1: &0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order::Order) : bool {
        let v0 = 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order::price(arg1);
        arg0.original_quantity - arg0.executed_quantity > 0 && (arg0.is_bid && arg0.price >= v0 || !arg0.is_bid && arg0.price <= v0)
    }

    public fun client_order_id(arg0: &OrderInfo) : u64 {
        arg0.client_order_id
    }

    public fun cumulative_quote_quantity(arg0: &OrderInfo) : u64 {
        arg0.cumulative_quote_quantity
    }

    fun emit_order_canceled_maker_from_fill(arg0: &OrderInfo, arg1: &0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::fill::Fill, arg2: u64) {
        0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order::emit_cancel_maker(0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::fill::balance_manager_id(arg1), arg0.pool_id, 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::fill::maker_order_id(arg1), 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::fill::maker_client_order_id(arg1), trader(arg0), 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::fill::execution_price(arg1), !is_bid(arg0), 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::fill::original_maker_quantity(arg1), 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::fill::base_quantity(arg1), arg2);
    }

    public(friend) fun emit_order_info(arg0: &OrderInfo) {
        0x2::event::emit<OrderInfo>(*arg0);
    }

    public(friend) fun emit_order_placed(arg0: &OrderInfo) {
        let v0 = OrderPlaced{
            balance_manager_id : arg0.balance_manager_id,
            pool_id            : arg0.pool_id,
            order_id           : arg0.order_id,
            client_order_id    : arg0.client_order_id,
            trader             : arg0.trader,
            price              : arg0.price,
            is_bid             : arg0.is_bid,
            placed_quantity    : remaining_quantity(arg0),
            expire_timestamp   : arg0.expire_timestamp,
            timestamp          : arg0.timestamp,
        };
        0x2::event::emit<OrderPlaced>(v0);
    }

    public(friend) fun emit_orders_filled(arg0: &OrderInfo, arg1: u64) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::fill::Fill>(&arg0.fills)) {
            let v1 = 0x1::vector::borrow<0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::fill::Fill>(&arg0.fills, v0);
            if (!0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::fill::expired(v1)) {
                0x2::event::emit<OrderFilled>(order_filled_from_fill(arg0, v1, arg1));
            } else if (balance_manager_id(arg0) == 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::fill::balance_manager_id(v1)) {
                emit_order_canceled_maker_from_fill(arg0, v1, arg1);
            } else {
                0x2::event::emit<OrderExpired>(order_expired_from_fill(arg0, v1, arg1));
            };
            v0 = v0 + 1;
        };
    }

    public fun epoch(arg0: &OrderInfo) : u64 {
        arg0.epoch
    }

    public fun executed_quantity(arg0: &OrderInfo) : u64 {
        arg0.executed_quantity
    }

    public fun expire_timestamp(arg0: &OrderInfo) : u64 {
        arg0.expire_timestamp
    }

    public fun fee_is_deep(arg0: &OrderInfo) : bool {
        arg0.fee_is_deep
    }

    public fun fill_limit_reached(arg0: &OrderInfo) : bool {
        arg0.fill_limit_reached
    }

    public fun fills(arg0: &OrderInfo) : vector<0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::fill::Fill> {
        arg0.fills
    }

    public(friend) fun fills_ref(arg0: &mut OrderInfo) : &mut vector<0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::fill::Fill> {
        &mut arg0.fills
    }

    public fun is_bid(arg0: &OrderInfo) : bool {
        arg0.is_bid
    }

    public fun maker_fees(arg0: &OrderInfo) : u64 {
        arg0.maker_fees
    }

    public(friend) fun market_order(arg0: &OrderInfo) : bool {
        arg0.market_order
    }

    public(friend) fun match_maker(arg0: &mut OrderInfo, arg1: &mut 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order::Order, arg2: u64) : bool {
        if (!can_match(arg0, arg1)) {
            return false
        };
        if (self_matching_option(arg0) == 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::constants::cancel_taker()) {
            assert!(0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order::balance_manager_id(arg1) != balance_manager_id(arg0), 8);
        };
        let v0 = self_matching_option(arg0) == 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::constants::cancel_maker() && 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order::balance_manager_id(arg1) == balance_manager_id(arg0);
        let v1 = 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order::generate_fill(arg1, arg2, remaining_quantity(arg0), arg0.is_bid, v0, arg0.fee_is_deep);
        0x1::vector::push_back<0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::fill::Fill>(&mut arg0.fills, v1);
        if (0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::fill::expired(&v1)) {
            return true
        };
        arg0.executed_quantity = arg0.executed_quantity + 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::fill::base_quantity(&v1);
        arg0.cumulative_quote_quantity = arg0.cumulative_quote_quantity + 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::fill::quote_quantity(&v1);
        arg0.status = 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::constants::partially_filled();
        if (remaining_quantity(arg0) == 0) {
            arg0.status = 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::constants::filled();
        };
        true
    }

    public fun order_deep_price(arg0: &OrderInfo) : 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::deep_price::OrderDeepPrice {
        arg0.order_deep_price
    }

    fun order_expired_from_fill(arg0: &OrderInfo, arg1: &0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::fill::Fill, arg2: u64) : OrderExpired {
        OrderExpired{
            balance_manager_id           : 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::fill::balance_manager_id(arg1),
            pool_id                      : arg0.pool_id,
            order_id                     : 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::fill::maker_order_id(arg1),
            client_order_id              : 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::fill::maker_client_order_id(arg1),
            trader                       : trader(arg0),
            price                        : 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::fill::execution_price(arg1),
            is_bid                       : !is_bid(arg0),
            original_quantity            : 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::fill::original_maker_quantity(arg1),
            base_asset_quantity_canceled : 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::fill::base_quantity(arg1),
            timestamp                    : arg2,
        }
    }

    fun order_filled_from_fill(arg0: &OrderInfo, arg1: &0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::fill::Fill, arg2: u64) : OrderFilled {
        OrderFilled{
            pool_id                  : arg0.pool_id,
            maker_order_id           : 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::fill::maker_order_id(arg1),
            taker_order_id           : arg0.order_id,
            maker_client_order_id    : 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::fill::maker_client_order_id(arg1),
            taker_client_order_id    : arg0.client_order_id,
            price                    : 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::fill::execution_price(arg1),
            taker_is_bid             : arg0.is_bid,
            taker_fee                : 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::fill::taker_fee(arg1),
            taker_fee_is_deep        : 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::fill::taker_fee_is_deep(arg1),
            maker_fee                : 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::fill::maker_fee(arg1),
            maker_fee_is_deep        : 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::fill::maker_fee_is_deep(arg1),
            base_quantity            : 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::fill::base_quantity(arg1),
            quote_quantity           : 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::fill::quote_quantity(arg1),
            maker_balance_manager_id : 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::fill::balance_manager_id(arg1),
            taker_balance_manager_id : arg0.balance_manager_id,
            timestamp                : arg2,
        }
    }

    public fun order_id(arg0: &OrderInfo) : u128 {
        arg0.order_id
    }

    public fun order_inserted(arg0: &OrderInfo) : bool {
        arg0.order_inserted
    }

    public fun order_type(arg0: &OrderInfo) : u8 {
        arg0.order_type
    }

    public fun original_quantity(arg0: &OrderInfo) : u64 {
        arg0.original_quantity
    }

    public fun paid_fees(arg0: &OrderInfo) : u64 {
        arg0.paid_fees
    }

    public fun pool_id(arg0: &OrderInfo) : 0x2::object::ID {
        arg0.pool_id
    }

    public(friend) fun remaining_quantity(arg0: &OrderInfo) : u64 {
        arg0.original_quantity - arg0.executed_quantity
    }

    public fun self_matching_option(arg0: &OrderInfo) : u8 {
        arg0.self_matching_option
    }

    public(friend) fun set_fill_limit_reached(arg0: &mut OrderInfo) {
        arg0.fill_limit_reached = true;
    }

    public(friend) fun set_order_id(arg0: &mut OrderInfo, arg1: u128) {
        arg0.order_id = arg1;
    }

    public(friend) fun set_order_inserted(arg0: &mut OrderInfo) {
        arg0.order_inserted = true;
    }

    public(friend) fun set_paid_fees(arg0: &mut OrderInfo, arg1: u64) {
        arg0.paid_fees = arg1;
    }

    public fun status(arg0: &OrderInfo) : u8 {
        arg0.status
    }

    public(friend) fun to_order(arg0: &OrderInfo) : 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order::Order {
        0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order::new(arg0.order_id, arg0.balance_manager_id, arg0.client_order_id, arg0.original_quantity, arg0.executed_quantity, arg0.fee_is_deep, arg0.order_deep_price, arg0.epoch, arg0.status, arg0.expire_timestamp)
    }

    public fun trader(arg0: &OrderInfo) : address {
        arg0.trader
    }

    public(friend) fun validate_inputs(arg0: &OrderInfo, arg1: u64, arg2: u64, arg3: u64, arg4: u64) {
        assert!(arg0.original_quantity >= arg2, 1);
        assert!(arg0.original_quantity % arg3 == 0, 2);
        assert!(arg4 <= arg0.expire_timestamp, 3);
        assert!(arg0.order_type >= 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::constants::no_restriction() && arg0.order_type <= 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::constants::max_restriction(), 4);
        if (arg0.market_order) {
            assert!(arg0.order_type != 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::constants::post_only(), 7);
            return
        };
        assert!(arg0.price >= 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::constants::min_price() && arg0.price <= 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::constants::max_price(), 0);
        assert!(arg0.price % arg1 == 0, 0);
    }

    // decompiled from Move bytecode v6
}

