module 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::book {
    struct Book has store {
        tick_size: u64,
        lot_size: u64,
        min_size: u64,
        bids: 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::big_vector::BigVector<0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order::Order>,
        asks: 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::big_vector::BigVector<0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order::Order>,
        next_bid_order_id: u64,
        next_ask_order_id: u64,
    }

    public(friend) fun empty(arg0: u64, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : Book {
        Book{
            tick_size         : arg0,
            lot_size          : arg1,
            min_size          : arg2,
            bids              : 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::big_vector::empty<0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order::Order>(0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::constants::max_slice_size(), 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::constants::max_fan_out(), arg3),
            asks              : 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::big_vector::empty<0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order::Order>(0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::constants::max_slice_size(), 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::constants::max_fan_out(), arg3),
            next_bid_order_id : 18446744073709551615,
            next_ask_order_id : 1,
        }
    }

    public(friend) fun asks(arg0: &Book) : &0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::big_vector::BigVector<0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order::Order> {
        &arg0.asks
    }

    public(friend) fun bids(arg0: &Book) : &0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::big_vector::BigVector<0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order::Order> {
        &arg0.bids
    }

    fun book_side(arg0: &Book, arg1: u128) : &0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::big_vector::BigVector<0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order::Order> {
        let (v0, _, _) = 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::utils::decode_order_id(arg1);
        if (v0) {
            &arg0.bids
        } else {
            &arg0.asks
        }
    }

    fun book_side_mut(arg0: &mut Book, arg1: u128) : &mut 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::big_vector::BigVector<0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order::Order> {
        let (v0, _, _) = 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::utils::decode_order_id(arg1);
        if (v0) {
            &mut arg0.bids
        } else {
            &mut arg0.asks
        }
    }

    public(friend) fun cancel_order(arg0: &mut Book, arg1: u128) : 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order::Order {
        0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::big_vector::remove<0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order::Order>(book_side_mut(arg0, arg1), arg1)
    }

    public(friend) fun create_order(arg0: &mut Book, arg1: &mut 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order_info::OrderInfo, arg2: u64) {
        0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order_info::validate_inputs(arg1, arg0.tick_size, arg0.min_size, arg0.lot_size, arg2);
        let v0 = get_order_id(arg0, 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order_info::is_bid(arg1));
        0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order_info::set_order_id(arg1, 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::utils::encode_order_id(0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order_info::is_bid(arg1), 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order_info::price(arg1), v0));
        match_against_book(arg0, arg1, arg2);
        if (0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order_info::assert_execution(arg1)) {
            return
        };
        inject_limit_order(arg0, arg1);
        0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order_info::set_order_inserted(arg1);
        0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order_info::emit_order_placed(arg1);
    }

    public(friend) fun get_level2_range_and_ticks(arg0: &Book, arg1: u64, arg2: u64, arg3: u64, arg4: bool, arg5: u64) : (vector<u64>, vector<u64>) {
        assert!(arg1 <= arg2, 3);
        assert!(arg1 >= 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::constants::min_price() && arg1 <= 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::constants::max_price(), 3);
        assert!(arg2 >= 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::constants::min_price() && arg2 <= 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::constants::max_price(), 3);
        assert!(arg3 > 0, 4);
        let v0 = vector[];
        let v1 = vector[];
        let v2 = if (arg4) {
            0
        } else {
            170141183460469231731687303715884105728
        };
        let v3 = if (arg4) {
            &arg0.bids
        } else {
            &arg0.asks
        };
        let (v4, v5) = if (arg4) {
            0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::big_vector::slice_before<0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order::Order>(v3, ((arg2 as u128) << 64) + 18446744073709551615 + v2)
        } else {
            0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::big_vector::slice_following<0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order::Order>(v3, ((arg1 as u128) << 64) + v2)
        };
        let v6 = v5;
        let v7 = v4;
        let v8 = 0;
        let v9 = v8;
        let v10 = 0;
        while (!0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::big_vector::slice_is_null(&v7) && arg3 > 0) {
            let v11 = 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::big_vector::slice_borrow<0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order::Order>(0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::big_vector::borrow_slice<0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order::Order>(v3, v7), v6);
            if (arg5 <= 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order::expire_timestamp(v11)) {
                let (_, v13, _) = 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::utils::decode_order_id(0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order::order_id(v11));
                if (arg4 && v13 < arg1 || !arg4 && v13 > arg2) {
                    break
                };
                if (v8 == 0 && (arg4 && v13 <= arg2 || !arg4 && v13 >= arg1)) {
                    v9 = v13;
                };
                if (v9 != 0 && v13 != v9) {
                    0x1::vector::push_back<u64>(&mut v0, v9);
                    0x1::vector::push_back<u64>(&mut v1, v10);
                    v9 = v13;
                    v10 = 0;
                    arg3 = arg3 - 1;
                };
                if (v9 != 0) {
                    let v15 = v10 + 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order::quantity(v11);
                    v10 = v15 - 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order::filled_quantity(v11);
                };
            };
            let (v16, v17) = if (arg4) {
                0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::big_vector::prev_slice<0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order::Order>(v3, v7, v6)
            } else {
                0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::big_vector::next_slice<0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order::Order>(v3, v7, v6)
            };
            v6 = v17;
            v7 = v16;
        };
        if (v9 != 0) {
            0x1::vector::push_back<u64>(&mut v0, v9);
            0x1::vector::push_back<u64>(&mut v1, v10);
        };
        (v0, v1)
    }

    public(friend) fun get_order(arg0: &Book, arg1: u128) : 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order::Order {
        0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order::copy_order(0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::big_vector::borrow<0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order::Order>(book_side(arg0, arg1), arg1))
    }

    fun get_order_id(arg0: &mut Book, arg1: bool) : u64 {
        if (arg1) {
            arg0.next_bid_order_id = arg0.next_bid_order_id - 1;
            arg0.next_bid_order_id
        } else {
            arg0.next_ask_order_id = arg0.next_ask_order_id + 1;
            arg0.next_ask_order_id
        }
    }

    public(friend) fun get_quantity_out(arg0: &Book, arg1: u64, arg2: u64, arg3: u64, arg4: 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::deep_price::OrderDeepPrice, arg5: u64, arg6: u64) : (u64, u64, u64) {
        let v0 = if (arg1 > 0 || arg2 > 0) {
            let v1 = arg1 > 0 && arg2 > 0;
            !v1
        } else {
            false
        };
        assert!(v0, 1);
        let v2 = arg2 > 0;
        let v3 = 0;
        let v4 = if (v2) {
            arg2
        } else {
            arg1
        };
        let v5 = v4;
        let v6 = if (v2) {
            &arg0.asks
        } else {
            &arg0.bids
        };
        let (v7, v8) = if (v2) {
            0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::big_vector::min_slice<0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order::Order>(v6)
        } else {
            0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::big_vector::max_slice<0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order::Order>(v6)
        };
        let v9 = v8;
        let v10 = v7;
        while (!0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::big_vector::slice_is_null(&v10) && v5 > 0) {
            let v11 = 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::big_vector::slice_borrow<0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order::Order>(0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::big_vector::borrow_slice<0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order::Order>(v6, v10), v9);
            let v12 = 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order::price(v11);
            if (arg6 <= 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order::expire_timestamp(v11)) {
                let v13 = if (v2) {
                    let v14 = 0x1::u64::min(0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::math::div(v5, v12), 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order::quantity(v11) - 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order::filled_quantity(v11));
                    let v15 = v14 - v14 % arg5;
                    v3 = v3 + v15;
                    v5 = v5 - 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::math::mul(v15, v12);
                    v15
                } else {
                    let v16 = 0x1::u64::min(v5, 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order::quantity(v11) - 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order::filled_quantity(v11));
                    let v17 = v16 - v16 % arg5;
                    v3 = v3 + 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::math::mul(v17, v12);
                    v5 = v5 - v17;
                    v17
                };
                if (v13 == 0) {
                    break
                };
            };
            let (v18, v19) = if (v2) {
                let (v20, v21) = 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::big_vector::next_slice<0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order::Order>(v6, v10, v9);
                (v21, v20)
            } else {
                let (v22, v23) = 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::big_vector::prev_slice<0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order::Order>(v6, v10, v9);
                (v23, v22)
            };
            v9 = v18;
            v10 = v19;
        };
        let v24 = if (v2) {
            0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::deep_price::deep_quantity(&arg4, v3, arg2 - v5)
        } else {
            0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::deep_price::deep_quantity(&arg4, arg1 - v5, v3)
        };
        let (v25, v26) = if (v2) {
            (v3, v5)
        } else {
            (v5, v3)
        };
        (v25, v26, 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::math::mul(arg3, v24))
    }

    fun inject_limit_order(arg0: &mut Book, arg1: &0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order_info::OrderInfo) {
        if (0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order_info::is_bid(arg1)) {
            0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::big_vector::insert<0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order::Order>(&mut arg0.bids, 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order_info::order_id(arg1), 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order_info::to_order(arg1));
        } else {
            0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::big_vector::insert<0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order::Order>(&mut arg0.asks, 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order_info::order_id(arg1), 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order_info::to_order(arg1));
        };
    }

    public(friend) fun lot_size(arg0: &Book) : u64 {
        arg0.lot_size
    }

    fun match_against_book(arg0: &mut Book, arg1: &mut 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order_info::OrderInfo, arg2: u64) {
        let v0 = 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order_info::is_bid(arg1);
        let v1 = if (v0) {
            &mut arg0.asks
        } else {
            &mut arg0.bids
        };
        let (v2, v3) = if (v0) {
            0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::big_vector::min_slice<0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order::Order>(v1)
        } else {
            0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::big_vector::max_slice<0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order::Order>(v1)
        };
        let v4 = v3;
        let v5 = v2;
        while (!0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::big_vector::slice_is_null(&v5) && 0x1::vector::length<0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::fill::Fill>(0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order_info::fills_ref(arg1)) < 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::constants::max_fills()) {
            if (!0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order_info::match_maker(arg1, 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::big_vector::slice_borrow_mut<0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order::Order>(0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::big_vector::borrow_slice_mut<0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order::Order>(v1, v5), v4), arg2)) {
                break
            };
            let (v6, v7) = if (v0) {
                0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::big_vector::next_slice<0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order::Order>(v1, v5, v4)
            } else {
                0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::big_vector::prev_slice<0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order::Order>(v1, v5, v4)
            };
            v4 = v7;
            v5 = v6;
        };
        let v8 = 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order_info::fills_ref(arg1);
        let v9 = 0;
        while (v9 < 0x1::vector::length<0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::fill::Fill>(v8)) {
            let v10 = 0x1::vector::borrow<0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::fill::Fill>(v8, v9);
            if (0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::fill::expired(v10) || 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::fill::completed(v10)) {
                0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::big_vector::remove<0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order::Order>(v1, 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::fill::maker_order_id(v10));
            };
            v9 = v9 + 1;
        };
        if (0x1::vector::length<0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::fill::Fill>(0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order_info::fills_ref(arg1)) == 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::constants::max_fills()) {
            0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order_info::set_fill_limit_reached(arg1);
        };
    }

    public(friend) fun mid_price(arg0: &Book, arg1: u64) : u64 {
        let (v0, v1) = 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::big_vector::min_slice<0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order::Order>(&arg0.asks);
        let v2 = v1;
        let v3 = v0;
        let (v4, v5) = 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::big_vector::max_slice<0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order::Order>(&arg0.bids);
        let v6 = v5;
        let v7 = v4;
        let v8 = 0;
        let v9 = 0;
        while (!0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::big_vector::slice_is_null(&v3)) {
            let v10 = 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::big_vector::slice_borrow<0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order::Order>(0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::big_vector::borrow_slice<0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order::Order>(&arg0.asks, v3), v2);
            v8 = 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order::price(v10);
            if (arg1 <= 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order::expire_timestamp(v10)) {
                break
            };
            let (v11, v12) = 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::big_vector::next_slice<0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order::Order>(&arg0.asks, v3, v2);
            v2 = v12;
            v3 = v11;
        };
        while (!0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::big_vector::slice_is_null(&v7)) {
            let v13 = 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::big_vector::slice_borrow<0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order::Order>(0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::big_vector::borrow_slice<0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order::Order>(&arg0.bids, v7), v6);
            v9 = 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order::price(v13);
            if (arg1 <= 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order::expire_timestamp(v13)) {
                break
            };
            let (v14, v15) = 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::big_vector::prev_slice<0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order::Order>(&arg0.bids, v7, v6);
            v6 = v15;
            v7 = v14;
        };
        assert!(!0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::big_vector::slice_is_null(&v3) && !0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::big_vector::slice_is_null(&v7), 2);
        0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::math::mul(v8 + v9, 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::constants::half())
    }

    public(friend) fun min_size(arg0: &Book) : u64 {
        arg0.min_size
    }

    public(friend) fun modify_order(arg0: &mut Book, arg1: u128, arg2: u64, arg3: u64) : (u64, &0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order::Order) {
        assert!(arg2 >= arg0.min_size, 5);
        assert!(arg2 % arg0.lot_size == 0, 6);
        let v0 = 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::big_vector::borrow_mut<0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order::Order>(book_side_mut(arg0, arg1), arg1);
        assert!(arg2 < 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order::quantity(v0), 7);
        0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order::modify(v0, arg2, arg3);
        (0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order::quantity(v0) - arg2, v0)
    }

    public(friend) fun tick_size(arg0: &Book) : u64 {
        arg0.tick_size
    }

    // decompiled from Move bytecode v6
}

