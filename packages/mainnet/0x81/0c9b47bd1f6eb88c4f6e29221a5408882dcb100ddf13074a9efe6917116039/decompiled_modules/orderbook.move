module 0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::orderbook {
    struct Order<phantom T0> has store {
        id: u64,
        price: u64,
        timestamp: u64,
        input: 0x2::balance::Balance<T0>,
        original_amount: u64,
        sender: address,
    }

    struct OrderBook<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        asks: vector<Order<T0>>,
        bids: vector<Order<T1>>,
        decimals_t: u8,
        decimals_t1: u8,
        next_order_id: u64,
    }

    fun allocate_order_id<T0, T1>(arg0: &mut OrderBook<T0, T1>) : u64 {
        let v0 = arg0.next_order_id;
        arg0.next_order_id = v0 + 1;
        v0
    }

    public fun ask_count<T0, T1>(arg0: &OrderBook<T0, T1>) : u64 {
        0x1::vector::length<Order<T0>>(&arg0.asks)
    }

    public fun ask_order_id_at<T0, T1>(arg0: &OrderBook<T0, T1>, arg1: u64) : u64 {
        0x1::vector::borrow<Order<T0>>(&arg0.asks, arg1).id
    }

    public fun ask_remaining_at<T0, T1>(arg0: &OrderBook<T0, T1>, arg1: u64) : u64 {
        0x2::balance::value<T0>(&0x1::vector::borrow<Order<T0>>(&arg0.asks, arg1).input)
    }

    public fun ask_remaining_by_order_id<T0, T1>(arg0: &OrderBook<T0, T1>, arg1: u64) : u64 {
        ask_remaining_at<T0, T1>(arg0, find_order_index<T0>(&arg0.asks, arg1))
    }

    fun assert_registry_match<T0>(arg0: &0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::token::TokenHoldingRegistry<T0>, arg1: &0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::token::TreasuryCapStore<T0>) {
        assert!(0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::token::token_holding_registry_project_id<T0>(arg0) == 0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::token::treasury_cap_store_project_id<T0>(arg1), 7);
    }

    fun base_to_quote_amount_round_down(arg0: u64, arg1: u64, arg2: u8) : u64 {
        assert!(arg1 > 0, 1);
        0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::point_math::mul_div_floor_to_u64((arg0 as u256), (arg1 as u256), 0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::point_math::decimal_scale(arg2))
    }

    fun base_to_quote_amount_round_up(arg0: u64, arg1: u64, arg2: u8) : u64 {
        assert!(arg1 > 0, 1);
        0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::point_math::mul_div_ceil_to_u64((arg0 as u256), (arg1 as u256), 0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::point_math::decimal_scale(arg2))
    }

    public fun best_ask<T0, T1>(arg0: &OrderBook<T0, T1>) : (u64, u64, u64) {
        let v0 = 0x1::vector::borrow<Order<T0>>(&arg0.asks, best_ask_location<T0, T1>(arg0));
        (v0.id, v0.price, 0x2::balance::value<T0>(&v0.input))
    }

    fun best_ask_location<T0, T1>(arg0: &OrderBook<T0, T1>) : u64 {
        let v0 = 0x1::vector::length<Order<T0>>(&arg0.asks);
        assert!(v0 > 0, 5);
        let v1 = 0;
        let v2 = 1;
        while (v2 < v0) {
            let v3 = 0x1::vector::borrow<Order<T0>>(&arg0.asks, v2);
            let v4 = 0x1::vector::borrow<Order<T0>>(&arg0.asks, v1);
            if (v3.price < v4.price) {
            } else if (v3.price == v4.price) {
            };
            v2 = v2 + 1;
        };
        v1
    }

    public fun best_bid<T0, T1>(arg0: &OrderBook<T0, T1>) : (u64, u64, u64) {
        let v0 = 0x1::vector::borrow<Order<T1>>(&arg0.bids, best_bid_location<T0, T1>(arg0));
        (v0.id, v0.price, 0x2::balance::value<T1>(&v0.input))
    }

    fun best_bid_location<T0, T1>(arg0: &OrderBook<T0, T1>) : u64 {
        let v0 = 0x1::vector::length<Order<T1>>(&arg0.bids);
        assert!(v0 > 0, 5);
        let v1 = 0;
        let v2 = 1;
        while (v2 < v0) {
            let v3 = 0x1::vector::borrow<Order<T1>>(&arg0.bids, v2);
            let v4 = 0x1::vector::borrow<Order<T1>>(&arg0.bids, v1);
            if (v3.price > v4.price) {
            } else if (v3.price == v4.price) {
            };
            v2 = v2 + 1;
        };
        v1
    }

    public fun bid_count<T0, T1>(arg0: &OrderBook<T0, T1>) : u64 {
        0x1::vector::length<Order<T1>>(&arg0.bids)
    }

    public fun bid_order_id_at<T0, T1>(arg0: &OrderBook<T0, T1>, arg1: u64) : u64 {
        0x1::vector::borrow<Order<T1>>(&arg0.bids, arg1).id
    }

    public fun bid_remaining_at<T0, T1>(arg0: &OrderBook<T0, T1>, arg1: u64) : u64 {
        0x2::balance::value<T1>(&0x1::vector::borrow<Order<T1>>(&arg0.bids, arg1).input)
    }

    public fun bid_remaining_by_order_id<T0, T1>(arg0: &OrderBook<T0, T1>, arg1: u64) : u64 {
        bid_remaining_at<T0, T1>(arg0, find_order_index<T1>(&arg0.bids, arg1))
    }

    public fun cancel_ask_order<T0, T1>(arg0: &0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::global_config::GlobalConfig, arg1: &mut OrderBook<T0, T1>, arg2: &mut 0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::token::TreasuryCapStore<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::global_config::assert_domain_enabled(arg0, 0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::global_config::orderbook_domain());
        let Order {
            id              : v0,
            price           : v1,
            timestamp       : v2,
            input           : v3,
            original_amount : _,
            sender          : v5,
        } = 0x1::vector::swap_remove<Order<T0>>(&mut arg1.asks, find_order_index<T0>(&arg1.asks, arg3));
        let v6 = v3;
        assert!(v5 == 0x2::tx_context::sender(arg4), 0);
        let v7 = token_from_balance<T0>(arg2, v6, arg4);
        transfer_token_to<T0>(arg2, v7, v5, arg4);
        0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::event::emit_order_cancelled(0x2::object::id<OrderBook<T0, T1>>(arg1), 0, v0, v5, 0x1::type_name::with_original_ids<T0>(), 0x1::type_name::with_original_ids<T1>(), v1, v2, 0x2::balance::value<T0>(&v6));
    }

    public fun cancel_bid_order<T0, T1>(arg0: &0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::global_config::GlobalConfig, arg1: &mut OrderBook<T0, T1>, arg2: &mut 0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::token::TreasuryCapStore<T1>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::global_config::assert_domain_enabled(arg0, 0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::global_config::orderbook_domain());
        let Order {
            id              : v0,
            price           : v1,
            timestamp       : v2,
            input           : v3,
            original_amount : _,
            sender          : v5,
        } = 0x1::vector::swap_remove<Order<T1>>(&mut arg1.bids, find_order_index<T1>(&arg1.bids, arg3));
        let v6 = v3;
        assert!(v5 == 0x2::tx_context::sender(arg4), 0);
        let v7 = token_from_balance<T1>(arg2, v6, arg4);
        transfer_token_to<T1>(arg2, v7, v5, arg4);
        0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::event::emit_order_cancelled(0x2::object::id<OrderBook<T0, T1>>(arg1), 1, v0, v5, 0x1::type_name::with_original_ids<T0>(), 0x1::type_name::with_original_ids<T1>(), v1, v2, 0x2::balance::value<T1>(&v6));
    }

    public fun create_ask_order<T0>(arg0: &0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::global_config::GlobalConfig, arg1: 0x2::token::Token<T0>, arg2: &mut 0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::token::TreasuryCapStore<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : Order<T0> {
        0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::global_config::assert_domain_enabled(arg0, 0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::global_config::orderbook_domain());
        let v0 = token_into_balance<T0>(arg1, arg2, arg5);
        new_order<T0>(v0, arg3, arg4, arg5)
    }

    public fun create_bid_order<T0>(arg0: &0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::global_config::GlobalConfig, arg1: 0x2::token::Token<T0>, arg2: &mut 0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::token::TreasuryCapStore<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : Order<T0> {
        0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::global_config::assert_domain_enabled(arg0, 0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::global_config::orderbook_domain());
        let v0 = token_into_balance<T0>(arg1, arg2, arg5);
        new_order<T0>(v0, arg3, arg4, arg5)
    }

    public fun create_orderbook<T0, T1>(arg0: &0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::global_config::GlobalConfig, arg1: &0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::system::ProtocolAdminCap, arg2: &0x2::coin::CoinMetadata<T0>, arg3: &0x2::coin::CoinMetadata<T1>, arg4: &mut 0x2::tx_context::TxContext) {
        0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::global_config::assert_domain_enabled(arg0, 0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::global_config::orderbook_domain());
        let v0 = OrderBook<T0, T1>{
            id            : 0x2::object::new(arg4),
            asks          : 0x1::vector::empty<Order<T0>>(),
            bids          : 0x1::vector::empty<Order<T1>>(),
            decimals_t    : 0x2::coin::get_decimals<T0>(arg2),
            decimals_t1   : 0x2::coin::get_decimals<T1>(arg3),
            next_order_id : 0,
        };
        0x2::transfer::share_object<OrderBook<T0, T1>>(v0);
    }

    public fun fill_ask_exact_in<T0, T1>(arg0: &0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::global_config::GlobalConfig, arg1: &mut OrderBook<T0, T1>, arg2: &mut 0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::token::TokenHoldingRegistry<T0>, arg3: &mut 0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::token::TokenHoldingRegistry<T1>, arg4: &mut 0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::token::TreasuryCapStore<T0>, arg5: &mut 0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::token::TreasuryCapStore<T1>, arg6: 0x2::token::Token<T1>, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : 0x2::token::Token<T1> {
        0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::global_config::assert_domain_enabled(arg0, 0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::global_config::orderbook_domain());
        let v0 = 0x2::token::value<T1>(&arg6);
        assert!(v0 > 0, 2);
        let v1 = find_order_index<T0>(&arg1.asks, arg7);
        let v2 = 0x1::vector::borrow<Order<T0>>(&arg1.asks, v1);
        let v3 = quote_to_base_amount_round_down(v0, v2.price, arg1.decimals_t);
        assert!(v3 > 0, 6);
        let v4 = min(v3, 0x2::balance::value<T0>(&v2.input));
        let v5 = base_to_quote_amount_round_up(v4, v2.price, arg1.decimals_t);
        assert!(v4 > 0, 3);
        assert!(v5 <= v0, 4);
        let v6 = 0x2::token::split<T1>(&mut arg6, v5, arg8);
        let v7 = 0x1::vector::borrow_mut<Order<T0>>(&mut arg1.asks, v1);
        if (settle_ask_fill<T0, T1>(0x2::object::id<OrderBook<T0, T1>>(arg1), v7, arg2, arg3, arg4, arg5, v6, v4, arg7, arg8) == 0) {
            let v8 = &mut arg1.asks;
            remove_empty_order<T0>(v8, v1);
        };
        arg6
    }

    public fun fill_ask_exact_out<T0, T1>(arg0: &0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::global_config::GlobalConfig, arg1: &mut OrderBook<T0, T1>, arg2: &mut 0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::token::TokenHoldingRegistry<T0>, arg3: &mut 0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::token::TokenHoldingRegistry<T1>, arg4: &mut 0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::token::TreasuryCapStore<T0>, arg5: &mut 0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::token::TreasuryCapStore<T1>, arg6: 0x2::token::Token<T1>, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) : 0x2::token::Token<T1> {
        0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::global_config::assert_domain_enabled(arg0, 0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::global_config::orderbook_domain());
        let v0 = find_order_index<T0>(&arg1.asks, arg8);
        let v1 = 0x1::vector::borrow_mut<Order<T0>>(&mut arg1.asks, v0);
        assert!(arg7 > 0, 2);
        assert!(arg7 <= 0x2::balance::value<T0>(&v1.input), 3);
        let v2 = base_to_quote_amount_round_up(arg7, v1.price, arg1.decimals_t);
        assert!(v2 <= 0x2::token::value<T1>(&arg6), 4);
        let v3 = 0x2::token::split<T1>(&mut arg6, v2, arg9);
        if (settle_ask_fill<T0, T1>(0x2::object::id<OrderBook<T0, T1>>(arg1), v1, arg2, arg3, arg4, arg5, v3, arg7, arg8, arg9) == 0) {
            let v4 = &mut arg1.asks;
            remove_empty_order<T0>(v4, v0);
        };
        arg6
    }

    public fun fill_best_ask_exact_in<T0, T1>(arg0: &0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::global_config::GlobalConfig, arg1: &mut OrderBook<T0, T1>, arg2: &mut 0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::token::TokenHoldingRegistry<T0>, arg3: &mut 0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::token::TokenHoldingRegistry<T1>, arg4: &mut 0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::token::TreasuryCapStore<T0>, arg5: &mut 0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::token::TreasuryCapStore<T1>, arg6: 0x2::token::Token<T1>, arg7: &mut 0x2::tx_context::TxContext) : 0x2::token::Token<T1> {
        0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::global_config::assert_domain_enabled(arg0, 0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::global_config::orderbook_domain());
        assert!(0x2::token::value<T1>(&arg6) > 0, 2);
        while (0x2::token::value<T1>(&arg6) > 0 && 0x1::vector::length<Order<T0>>(&arg1.asks) > 0) {
            let v0 = best_ask_location<T0, T1>(arg1);
            let v1 = 0x1::vector::borrow<Order<T0>>(&arg1.asks, v0);
            let v2 = quote_to_base_amount_round_down(0x2::token::value<T1>(&arg6), v1.price, arg1.decimals_t);
            let (v3, v4, v5) = if (v2 == 0) {
                (0, 0, v1.id)
            } else {
                let v6 = min(v2, 0x2::balance::value<T0>(&v1.input));
                (v6, base_to_quote_amount_round_up(v6, v1.price, arg1.decimals_t), v1.id)
            };
            if (v3 == 0) {
                return arg6
            };
            let v7 = 0x2::token::split<T1>(&mut arg6, v4, arg7);
            let v8 = 0x1::vector::borrow_mut<Order<T0>>(&mut arg1.asks, v0);
            if (settle_ask_fill<T0, T1>(0x2::object::id<OrderBook<T0, T1>>(arg1), v8, arg2, arg3, arg4, arg5, v7, v3, v5, arg7) == 0) {
                let v9 = &mut arg1.asks;
                remove_empty_order<T0>(v9, v0);
            };
        };
        arg6
    }

    public fun fill_best_ask_exact_out<T0, T1>(arg0: &0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::global_config::GlobalConfig, arg1: &mut OrderBook<T0, T1>, arg2: &mut 0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::token::TokenHoldingRegistry<T0>, arg3: &mut 0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::token::TokenHoldingRegistry<T1>, arg4: &mut 0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::token::TreasuryCapStore<T0>, arg5: &mut 0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::token::TreasuryCapStore<T1>, arg6: 0x2::token::Token<T1>, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : 0x2::token::Token<T1> {
        0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::global_config::assert_domain_enabled(arg0, 0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::global_config::orderbook_domain());
        assert!(arg7 > 0, 2);
        while (arg7 > 0) {
            assert!(0x1::vector::length<Order<T0>>(&arg1.asks) > 0, 3);
            let v0 = best_ask_location<T0, T1>(arg1);
            let v1 = 0x1::vector::borrow<Order<T0>>(&arg1.asks, v0);
            let v2 = min(arg7, 0x2::balance::value<T0>(&v1.input));
            let v3 = base_to_quote_amount_round_up(v2, v1.price, arg1.decimals_t);
            assert!(v3 <= 0x2::token::value<T1>(&arg6), 4);
            let v4 = 0x2::token::split<T1>(&mut arg6, v3, arg8);
            let v5 = 0x1::vector::borrow_mut<Order<T0>>(&mut arg1.asks, v0);
            if (settle_ask_fill<T0, T1>(0x2::object::id<OrderBook<T0, T1>>(arg1), v5, arg2, arg3, arg4, arg5, v4, v2, v1.id, arg8) == 0) {
                let v6 = &mut arg1.asks;
                remove_empty_order<T0>(v6, v0);
            };
            arg7 = arg7 - v2;
        };
        arg6
    }

    public fun fill_best_bid_exact_in<T0, T1>(arg0: &0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::global_config::GlobalConfig, arg1: &mut OrderBook<T0, T1>, arg2: &mut 0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::token::TokenHoldingRegistry<T0>, arg3: &mut 0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::token::TokenHoldingRegistry<T1>, arg4: &mut 0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::token::TreasuryCapStore<T0>, arg5: &mut 0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::token::TreasuryCapStore<T1>, arg6: 0x2::token::Token<T0>, arg7: &mut 0x2::tx_context::TxContext) : 0x2::token::Token<T0> {
        0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::global_config::assert_domain_enabled(arg0, 0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::global_config::orderbook_domain());
        assert!(0x2::token::value<T0>(&arg6) > 0, 2);
        while (0x2::token::value<T0>(&arg6) > 0 && 0x1::vector::length<Order<T1>>(&arg1.bids) > 0) {
            let v0 = best_bid_location<T0, T1>(arg1);
            let v1 = 0x1::vector::borrow<Order<T1>>(&arg1.bids, v0);
            let v2 = base_to_quote_amount_round_down(0x2::token::value<T0>(&arg6), v1.price, arg1.decimals_t);
            let (v3, v4, v5) = if (v2 == 0) {
                (0, 0, v1.id)
            } else {
                let v6 = min(v2, 0x2::balance::value<T1>(&v1.input));
                (v6, quote_to_base_amount_round_up(v6, v1.price, arg1.decimals_t), v1.id)
            };
            if (v3 == 0) {
                return arg6
            };
            let v7 = 0x2::token::split<T0>(&mut arg6, v4, arg7);
            let v8 = 0x1::vector::borrow_mut<Order<T1>>(&mut arg1.bids, v0);
            if (settle_bid_fill<T0, T1>(0x2::object::id<OrderBook<T0, T1>>(arg1), v8, arg2, arg3, arg4, arg5, v7, v3, v5, arg7) == 0) {
                let v9 = &mut arg1.bids;
                remove_empty_order<T1>(v9, v0);
            };
        };
        arg6
    }

    public fun fill_best_bid_exact_out<T0, T1>(arg0: &0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::global_config::GlobalConfig, arg1: &mut OrderBook<T0, T1>, arg2: &mut 0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::token::TokenHoldingRegistry<T0>, arg3: &mut 0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::token::TokenHoldingRegistry<T1>, arg4: &mut 0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::token::TreasuryCapStore<T0>, arg5: &mut 0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::token::TreasuryCapStore<T1>, arg6: 0x2::token::Token<T0>, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : 0x2::token::Token<T0> {
        0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::global_config::assert_domain_enabled(arg0, 0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::global_config::orderbook_domain());
        assert!(arg7 > 0, 2);
        while (arg7 > 0) {
            assert!(0x1::vector::length<Order<T1>>(&arg1.bids) > 0, 3);
            let v0 = best_bid_location<T0, T1>(arg1);
            let v1 = 0x1::vector::borrow<Order<T1>>(&arg1.bids, v0);
            let v2 = min(arg7, 0x2::balance::value<T1>(&v1.input));
            let v3 = quote_to_base_amount_round_up(v2, v1.price, arg1.decimals_t);
            assert!(v3 <= 0x2::token::value<T0>(&arg6), 4);
            let v4 = 0x2::token::split<T0>(&mut arg6, v3, arg8);
            let v5 = 0x1::vector::borrow_mut<Order<T1>>(&mut arg1.bids, v0);
            if (settle_bid_fill<T0, T1>(0x2::object::id<OrderBook<T0, T1>>(arg1), v5, arg2, arg3, arg4, arg5, v4, v2, v1.id, arg8) == 0) {
                let v6 = &mut arg1.bids;
                remove_empty_order<T1>(v6, v0);
            };
            arg7 = arg7 - v2;
        };
        arg6
    }

    public fun fill_bid_exact_in<T0, T1>(arg0: &0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::global_config::GlobalConfig, arg1: &mut OrderBook<T0, T1>, arg2: &mut 0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::token::TokenHoldingRegistry<T0>, arg3: &mut 0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::token::TokenHoldingRegistry<T1>, arg4: &mut 0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::token::TreasuryCapStore<T0>, arg5: &mut 0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::token::TreasuryCapStore<T1>, arg6: 0x2::token::Token<T0>, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : 0x2::token::Token<T0> {
        0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::global_config::assert_domain_enabled(arg0, 0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::global_config::orderbook_domain());
        let v0 = 0x2::token::value<T0>(&arg6);
        assert!(v0 > 0, 2);
        let v1 = find_order_index<T1>(&arg1.bids, arg7);
        let v2 = 0x1::vector::borrow<Order<T1>>(&arg1.bids, v1);
        let v3 = base_to_quote_amount_round_down(v0, v2.price, arg1.decimals_t);
        assert!(v3 > 0, 6);
        let v4 = min(v3, 0x2::balance::value<T1>(&v2.input));
        let v5 = quote_to_base_amount_round_up(v4, v2.price, arg1.decimals_t);
        assert!(v4 > 0, 3);
        assert!(v5 <= v0, 4);
        let v6 = 0x2::token::split<T0>(&mut arg6, v5, arg8);
        let v7 = 0x1::vector::borrow_mut<Order<T1>>(&mut arg1.bids, v1);
        if (settle_bid_fill<T0, T1>(0x2::object::id<OrderBook<T0, T1>>(arg1), v7, arg2, arg3, arg4, arg5, v6, v4, arg7, arg8) == 0) {
            let v8 = &mut arg1.bids;
            remove_empty_order<T1>(v8, v1);
        };
        arg6
    }

    public fun fill_bid_exact_out<T0, T1>(arg0: &0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::global_config::GlobalConfig, arg1: &mut OrderBook<T0, T1>, arg2: &mut 0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::token::TokenHoldingRegistry<T0>, arg3: &mut 0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::token::TokenHoldingRegistry<T1>, arg4: &mut 0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::token::TreasuryCapStore<T0>, arg5: &mut 0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::token::TreasuryCapStore<T1>, arg6: 0x2::token::Token<T0>, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) : 0x2::token::Token<T0> {
        0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::global_config::assert_domain_enabled(arg0, 0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::global_config::orderbook_domain());
        let v0 = find_order_index<T1>(&arg1.bids, arg8);
        let v1 = 0x1::vector::borrow_mut<Order<T1>>(&mut arg1.bids, v0);
        assert!(arg7 > 0, 2);
        assert!(arg7 <= 0x2::balance::value<T1>(&v1.input), 3);
        let v2 = quote_to_base_amount_round_up(arg7, v1.price, arg1.decimals_t);
        assert!(v2 <= 0x2::token::value<T0>(&arg6), 4);
        let v3 = 0x2::token::split<T0>(&mut arg6, v2, arg9);
        if (settle_bid_fill<T0, T1>(0x2::object::id<OrderBook<T0, T1>>(arg1), v1, arg2, arg3, arg4, arg5, v3, arg7, arg8, arg9) == 0) {
            let v4 = &mut arg1.bids;
            remove_empty_order<T1>(v4, v0);
        };
        arg6
    }

    fun find_order_index<T0>(arg0: &vector<Order<T0>>, arg1: u64) : u64 {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Order<T0>>(arg0)) {
            if (0x1::vector::borrow<Order<T0>>(arg0, v0).id == arg1) {
                return v0
            };
            v0 = v0 + 1;
        };
        abort 5
    }

    fun min(arg0: u64, arg1: u64) : u64 {
        if (arg0 < arg1) {
            arg0
        } else {
            arg1
        }
    }

    fun new_order<T0>(arg0: 0x2::balance::Balance<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) : Order<T0> {
        assert!(arg1 > 0, 1);
        let v0 = 0x2::balance::value<T0>(&arg0);
        assert!(v0 > 0, 2);
        Order<T0>{
            id              : 0,
            price           : arg1,
            timestamp       : 0x2::clock::timestamp_ms(arg2),
            input           : arg0,
            original_amount : v0,
            sender          : 0x2::tx_context::sender(arg3),
        }
    }

    public fun next_order_id<T0, T1>(arg0: &OrderBook<T0, T1>) : u64 {
        arg0.next_order_id
    }

    public fun place_ask_order<T0, T1>(arg0: &0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::global_config::GlobalConfig, arg1: &mut OrderBook<T0, T1>, arg2: Order<T0>) : u64 {
        0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::global_config::assert_domain_enabled(arg0, 0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::global_config::orderbook_domain());
        let v0 = allocate_order_id<T0, T1>(arg1);
        arg2.id = v0;
        0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::event::emit_order_placed(0x2::object::id<OrderBook<T0, T1>>(arg1), 0, v0, arg2.sender, 0x1::type_name::with_original_ids<T0>(), 0x1::type_name::with_original_ids<T1>(), arg2.price, arg2.timestamp, arg2.original_amount);
        0x1::vector::push_back<Order<T0>>(&mut arg1.asks, arg2);
        v0
    }

    public fun place_bid_order<T0, T1>(arg0: &0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::global_config::GlobalConfig, arg1: &mut OrderBook<T0, T1>, arg2: Order<T1>) : u64 {
        0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::global_config::assert_domain_enabled(arg0, 0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::global_config::orderbook_domain());
        let v0 = allocate_order_id<T0, T1>(arg1);
        arg2.id = v0;
        0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::event::emit_order_placed(0x2::object::id<OrderBook<T0, T1>>(arg1), 1, v0, arg2.sender, 0x1::type_name::with_original_ids<T0>(), 0x1::type_name::with_original_ids<T1>(), arg2.price, arg2.timestamp, arg2.original_amount);
        0x1::vector::push_back<Order<T1>>(&mut arg1.bids, arg2);
        v0
    }

    fun quote_to_base_amount_round_down(arg0: u64, arg1: u64, arg2: u8) : u64 {
        assert!(arg1 > 0, 1);
        0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::point_math::mul_div_floor_to_u64((arg0 as u256), 0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::point_math::decimal_scale(arg2), (arg1 as u256))
    }

    fun quote_to_base_amount_round_up(arg0: u64, arg1: u64, arg2: u8) : u64 {
        assert!(arg1 > 0, 1);
        0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::point_math::mul_div_ceil_to_u64((arg0 as u256), 0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::point_math::decimal_scale(arg2), (arg1 as u256))
    }

    fun remove_empty_order<T0>(arg0: &mut vector<Order<T0>>, arg1: u64) {
        let Order {
            id              : _,
            price           : _,
            timestamp       : _,
            input           : v3,
            original_amount : _,
            sender          : _,
        } = 0x1::vector::swap_remove<Order<T0>>(arg0, arg1);
        0x2::balance::destroy_zero<T0>(v3);
    }

    fun settle_ask_fill<T0, T1>(arg0: 0x2::object::ID, arg1: &mut Order<T0>, arg2: &mut 0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::token::TokenHoldingRegistry<T0>, arg3: &mut 0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::token::TokenHoldingRegistry<T1>, arg4: &mut 0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::token::TreasuryCapStore<T0>, arg5: &mut 0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::token::TreasuryCapStore<T1>, arg6: 0x2::token::Token<T1>, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) : u64 {
        assert_registry_match<T0>(arg2, arg4);
        assert_registry_match<T1>(arg3, arg5);
        let v0 = 0x2::balance::value<T0>(&arg1.input);
        let v1 = 0x2::token::value<T1>(&arg6);
        0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::token::decrease_holding_by_token_amount<T0>(arg2, arg1.sender, arg7);
        0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::token::increase_holding_by_token_amount<T0>(arg2, 0x2::tx_context::sender(arg9), arg7);
        0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::token::decrease_holding_by_token_amount<T1>(arg3, 0x2::tx_context::sender(arg9), v1);
        0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::token::increase_holding_by_token_amount<T1>(arg3, arg1.sender, v1);
        let v2 = token_from_balance<T0>(arg4, 0x2::balance::split<T0>(&mut arg1.input, arg7), arg9);
        transfer_token_to<T1>(arg5, arg6, arg1.sender, arg9);
        let v3 = 0x2::tx_context::sender(arg9);
        transfer_token_to<T0>(arg4, v2, v3, arg9);
        0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::event::emit_order_filled(arg0, 0, arg8, arg1.sender, 0x2::tx_context::sender(arg9), 0x1::type_name::with_original_ids<T0>(), 0x1::type_name::with_original_ids<T1>(), arg1.price, arg1.timestamp, arg7, v1, v0);
        v0
    }

    fun settle_bid_fill<T0, T1>(arg0: 0x2::object::ID, arg1: &mut Order<T1>, arg2: &mut 0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::token::TokenHoldingRegistry<T0>, arg3: &mut 0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::token::TokenHoldingRegistry<T1>, arg4: &mut 0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::token::TreasuryCapStore<T0>, arg5: &mut 0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::token::TreasuryCapStore<T1>, arg6: 0x2::token::Token<T0>, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) : u64 {
        assert_registry_match<T0>(arg2, arg4);
        assert_registry_match<T1>(arg3, arg5);
        let v0 = 0x2::balance::value<T1>(&arg1.input);
        let v1 = 0x2::token::value<T0>(&arg6);
        0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::token::decrease_holding_by_token_amount<T1>(arg3, arg1.sender, arg7);
        0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::token::increase_holding_by_token_amount<T1>(arg3, 0x2::tx_context::sender(arg9), arg7);
        0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::token::decrease_holding_by_token_amount<T0>(arg2, 0x2::tx_context::sender(arg9), v1);
        0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::token::increase_holding_by_token_amount<T0>(arg2, arg1.sender, v1);
        let v2 = token_from_balance<T1>(arg5, 0x2::balance::split<T1>(&mut arg1.input, arg7), arg9);
        transfer_token_to<T0>(arg4, arg6, arg1.sender, arg9);
        let v3 = 0x2::tx_context::sender(arg9);
        transfer_token_to<T1>(arg5, v2, v3, arg9);
        0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::event::emit_order_filled(arg0, 1, arg8, arg1.sender, 0x2::tx_context::sender(arg9), 0x1::type_name::with_original_ids<T0>(), 0x1::type_name::with_original_ids<T1>(), arg1.price, arg1.timestamp, v1, arg7, v0);
        v0
    }

    fun token_from_balance<T0>(arg0: &mut 0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::token::TreasuryCapStore<T0>, arg1: 0x2::balance::Balance<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::token::Token<T0> {
        let (v0, v1) = 0x2::token::from_coin<T0>(0x2::coin::from_balance<T0>(arg1, arg2), arg2);
        let (_, _, _, _) = 0x2::token::confirm_with_treasury_cap<T0>(0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::token::internal_borrow_mut_treasury_cap<T0>(arg0), v1, arg2);
        v0
    }

    fun token_into_balance<T0>(arg0: 0x2::token::Token<T0>, arg1: &mut 0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::token::TreasuryCapStore<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let (v0, v1) = 0x2::token::to_coin<T0>(arg0, arg2);
        let (_, _, _, _) = 0x2::token::confirm_with_treasury_cap<T0>(0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::token::internal_borrow_mut_treasury_cap<T0>(arg1), v1, arg2);
        0x2::coin::into_balance<T0>(v0)
    }

    fun transfer_token_to<T0>(arg0: &mut 0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::token::TreasuryCapStore<T0>, arg1: 0x2::token::Token<T0>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let (_, _, _, _) = 0x2::token::confirm_with_treasury_cap<T0>(0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::token::internal_borrow_mut_treasury_cap<T0>(arg0), 0x2::token::transfer<T0>(arg1, arg2, arg3), arg3);
    }

    // decompiled from Move bytecode v7
}

