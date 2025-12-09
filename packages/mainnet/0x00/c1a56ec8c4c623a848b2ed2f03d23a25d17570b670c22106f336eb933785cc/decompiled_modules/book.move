module 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::book {
    struct Book has store {
        tick_size: u64,
        lot_size: u64,
        min_size: u64,
        bids: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::big_vector::BigVector<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order>,
        asks: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::big_vector::BigVector<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order>,
        next_bid_order_id: u64,
        next_ask_order_id: u64,
    }

    public(friend) fun empty(arg0: u64, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : Book {
        Book{
            tick_size         : arg0,
            lot_size          : arg1,
            min_size          : arg2,
            bids              : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::big_vector::empty<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::max_slice_size(), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::max_fan_out(), arg3),
            asks              : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::big_vector::empty<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::max_slice_size(), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::max_fan_out(), arg3),
            next_bid_order_id : 18446744073709551615,
            next_ask_order_id : 1,
        }
    }

    public(friend) fun asks(arg0: &Book) : &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::big_vector::BigVector<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order> {
        &arg0.asks
    }

    public(friend) fun bids(arg0: &Book) : &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::big_vector::BigVector<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order> {
        &arg0.bids
    }

    fun book_side(arg0: &Book, arg1: u128) : &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::big_vector::BigVector<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order> {
        let (v0, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::utils::decode_order_id(arg1);
        if (v0) {
            &arg0.bids
        } else {
            &arg0.asks
        }
    }

    fun book_side_mut(arg0: &mut Book, arg1: u128) : &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::big_vector::BigVector<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order> {
        let (v0, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::utils::decode_order_id(arg1);
        if (v0) {
            &mut arg0.bids
        } else {
            &mut arg0.asks
        }
    }

    public(friend) fun cancel_order(arg0: &mut Book, arg1: u128) : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order {
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::big_vector::remove<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order>(book_side_mut(arg0, arg1), arg1)
    }

    public(friend) fun check_limit_order_params(arg0: &Book, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : bool {
        if (arg3 <= arg4) {
            return false
        };
        if (arg2 < arg0.min_size || arg2 % arg0.lot_size != 0) {
            return false
        };
        let v0 = if (arg1 % arg0.tick_size != 0) {
            true
        } else if (arg1 < 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::min_price()) {
            true
        } else {
            arg1 > 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::max_price()
        };
        if (v0) {
            return false
        };
        true
    }

    public(friend) fun check_market_order_params(arg0: &Book, arg1: u64) : bool {
        if (arg1 < arg0.min_size || arg1 % arg0.lot_size != 0) {
            return false
        };
        true
    }

    public(friend) fun create_order(arg0: &mut Book, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::OrderInfo, arg2: u64) {
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::validate_inputs(arg1, arg0.tick_size, arg0.min_size, arg0.lot_size, arg2);
        let v0 = get_order_id(arg0, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::is_bid(arg1));
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::set_order_id(arg1, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::utils::encode_order_id(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::is_bid(arg1), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::price(arg1), v0));
        match_against_book(arg0, arg1, arg2);
        if (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::assert_execution(arg1)) {
            return
        };
        inject_limit_order(arg0, arg1);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::set_order_inserted(arg1);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::emit_order_placed(arg1);
    }

    public(friend) fun get_base_quantity_in(arg0: &Book, arg1: u64, arg2: u64, arg3: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::deep_price::OrderDeepPrice, arg4: bool, arg5: u64) : (u64, u64, u64) {
        get_quantity_in(arg0, 0, arg1, arg2, arg3, arg4, arg5)
    }

    public(friend) fun get_level2_range_and_ticks(arg0: &Book, arg1: u64, arg2: u64, arg3: u64, arg4: bool, arg5: u64) : (vector<u64>, vector<u64>) {
        assert!(arg1 <= arg2, 3);
        assert!(arg1 >= 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::min_price() && arg1 <= 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::max_price(), 3);
        assert!(arg2 >= 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::min_price() && arg2 <= 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::max_price(), 3);
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
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::big_vector::slice_before<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order>(v3, ((arg2 as u128) << 64) + 18446744073709551615 + v2)
        } else {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::big_vector::slice_following<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order>(v3, ((arg1 as u128) << 64) + v2)
        };
        let v6 = v5;
        let v7 = v4;
        let v8 = arg3;
        let v9 = 0;
        let v10 = v9;
        let v11 = 0;
        while (!0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::big_vector::slice_is_null(&v7) && v8 > 0) {
            let v12 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::big_vector::slice_borrow<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::big_vector::borrow_slice<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order>(v3, v7), v6);
            if (arg5 <= 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::expire_timestamp(v12)) {
                let (_, v14, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::utils::decode_order_id(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::order_id(v12));
                if (arg4 && v14 < arg1 || !arg4 && v14 > arg2) {
                    break
                };
                if (v9 == 0 && (arg4 && v14 <= arg2 || !arg4 && v14 >= arg1)) {
                    v10 = v14;
                };
                if (v10 != 0 && v14 != v10) {
                    0x1::vector::push_back<u64>(&mut v0, v10);
                    0x1::vector::push_back<u64>(&mut v1, v11);
                    v10 = v14;
                    v11 = 0;
                    let v16 = v8 - 1;
                    v8 = v16;
                    if (v16 == 0) {
                        break
                    };
                };
                if (v10 != 0) {
                    let v17 = v11 + 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::quantity(v12);
                    v11 = v17 - 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::filled_quantity(v12);
                };
            };
            let (v18, v19) = if (arg4) {
                0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::big_vector::prev_slice<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order>(v3, v7, v6)
            } else {
                0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::big_vector::next_slice<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order>(v3, v7, v6)
            };
            v6 = v19;
            v7 = v18;
        };
        if (v10 != 0 && v8 > 0) {
            0x1::vector::push_back<u64>(&mut v0, v10);
            0x1::vector::push_back<u64>(&mut v1, v11);
        };
        (v0, v1)
    }

    public(friend) fun get_order(arg0: &Book, arg1: u128) : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order {
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::copy_order(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::big_vector::borrow<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order>(book_side(arg0, arg1), arg1))
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

    fun get_quantity_in(arg0: &Book, arg1: u64, arg2: u64, arg3: u64, arg4: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::deep_price::OrderDeepPrice, arg5: bool, arg6: u64) : (u64, u64, u64) {
        assert!(arg1 > 0 != arg2 > 0, 1);
        let v0 = arg1 > 0;
        let v1 = 0;
        let v2 = 0;
        let v3 = 0;
        let v4 = if (v0) {
            &arg0.asks
        } else {
            &arg0.bids
        };
        let (v5, v6) = if (v0) {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::big_vector::min_slice<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order>(v4)
        } else {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::big_vector::max_slice<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order>(v4)
        };
        let v7 = v6;
        let v8 = v5;
        let v9 = 0;
        let v10 = if (v0) {
            arg1
        } else {
            arg2
        };
        loop {
            let v11 = if (!0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::big_vector::slice_is_null(&v8)) {
                if (v2 < v10) {
                    v9 < 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::max_fills()
                } else {
                    false
                }
            } else {
                false
            };
            if (v11) {
                let v12 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::big_vector::slice_borrow<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::big_vector::borrow_slice<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order>(v4, v8), v7);
                let v13 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::price(v12);
                if (arg6 <= 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::expire_timestamp(v12)) {
                    if (v0) {
                        let v14 = 0x1::u64::min(round_up_to_lot_size(v10 - v2, arg0.lot_size), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::quantity(v12) - 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::filled_quantity(v12));
                        if (v14 > 0) {
                            v2 = v2 + v14;
                            if (arg5) {
                                v1 = v1 + 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::math::mul(v14, v13);
                            } else {
                                v1 = v1 + 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::math::mul(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::math::mul(v14, v13), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::float_scaling() + 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::math::mul(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::fee_penalty_multiplier(), arg3));
                            };
                        };
                        if (v14 == 0) {
                            break
                        };
                    } else {
                        let v15 = 0x1::u64::min(round_up_to_lot_size(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::math::div_round_up(v10 - v2, v13), arg0.lot_size), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::quantity(v12) - 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::filled_quantity(v12));
                        if (v15 > 0) {
                            v3 = v3 + v15;
                            v2 = v2 + 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::math::mul(v15, v13);
                            if (arg5) {
                                v1 = v1 + v15;
                            } else {
                                v1 = v1 + 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::math::mul(v15, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::float_scaling() + 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::math::mul(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::fee_penalty_multiplier(), arg3));
                            };
                        };
                        if (v15 == 0) {
                            break
                        };
                    };
                };
                let (v16, v17) = if (v0) {
                    0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::big_vector::next_slice<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order>(v4, v8, v7)
                } else {
                    0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::big_vector::prev_slice<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order>(v4, v8, v7)
                };
                v7 = v17;
                v8 = v16;
                v9 = v9 + 1;
            } else {
                break
            };
        };
        let v18 = if (!arg5) {
            0
        } else {
            let v19 = if (v0) {
                0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::deep_price::fee_quantity(&arg4, v2, v1, true)
            } else {
                0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::deep_price::fee_quantity(&arg4, v1, v2, false)
            };
            let v20 = v19;
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::math::mul(arg3, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balances::deep(&v20))
        };
        let v21 = v0 && v2 >= arg1 && v2 >= arg0.min_size || v2 >= arg2 && v3 >= arg0.min_size;
        if (!v21) {
            (0, 0, 0)
        } else {
            let (v25, v26) = if (v0) {
                (v2, v1)
            } else {
                (v1, v2)
            };
            (v25, v26, v18)
        }
    }

    public(friend) fun get_quantity_out(arg0: &Book, arg1: u64, arg2: u64, arg3: u64, arg4: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::deep_price::OrderDeepPrice, arg5: u64, arg6: bool, arg7: u64) : (u64, u64, u64) {
        assert!(arg1 > 0 != arg2 > 0, 1);
        let v0 = arg2 > 0;
        let v1 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::math::mul(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::fee_penalty_multiplier(), arg3);
        if (arg1 > 0) {
            let v2 = if (arg6) {
                arg1
            } else {
                0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::math::div(arg1, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::float_scaling() + v1)
            };
            if (v2 < arg0.min_size) {
                return (arg1, arg2, 0)
            };
        };
        let v3 = 0;
        let v4 = if (v0) {
            arg2
        } else {
            arg1
        };
        let v5 = v4;
        let v6 = if (v0) {
            &arg0.asks
        } else {
            &arg0.bids
        };
        let (v7, v8) = if (v0) {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::big_vector::min_slice<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order>(v6)
        } else {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::big_vector::max_slice<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order>(v6)
        };
        let v9 = v8;
        let v10 = v7;
        let v11 = 0;
        loop {
            let v12 = if (!0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::big_vector::slice_is_null(&v10)) {
                if (v5 > 0) {
                    v11 < 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::max_fills()
                } else {
                    false
                }
            } else {
                false
            };
            if (v12) {
                let v13 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::big_vector::slice_borrow<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::big_vector::borrow_slice<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order>(v6, v10), v9);
                let v14 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::price(v13);
                if (arg7 <= 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::expire_timestamp(v13)) {
                    let v15 = if (arg6) {
                        v5
                    } else {
                        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::math::div(v5, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::float_scaling() + v1)
                    };
                    let v16 = if (v0) {
                        let v17 = 0x1::u64::min(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::math::div(v15, v14), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::quantity(v13) - 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::filled_quantity(v13));
                        let v18 = v17 - v17 % arg5;
                        v3 = v3 + v18;
                        let v19 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::math::mul(v18, v14);
                        let v20 = v5 - v19;
                        v5 = v20;
                        if (!arg6) {
                            v5 = v20 - 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::math::mul(v19, v1);
                        };
                        v18
                    } else {
                        let v21 = 0x1::u64::min(v15, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::quantity(v13) - 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::filled_quantity(v13));
                        let v22 = v21 - v21 % arg5;
                        v3 = v3 + 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::math::mul(v22, v14);
                        let v23 = v5 - v22;
                        v5 = v23;
                        if (!arg6) {
                            v5 = v23 - 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::math::mul(v22, v1);
                        };
                        v22
                    };
                    if (v16 == 0) {
                        break
                    };
                };
                let (v24, v25) = if (v0) {
                    0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::big_vector::next_slice<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order>(v6, v10, v9)
                } else {
                    0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::big_vector::prev_slice<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order>(v6, v10, v9)
                };
                v9 = v25;
                v10 = v24;
                v11 = v11 + 1;
            } else {
                break
            };
        };
        let v26 = if (!arg6) {
            0
        } else {
            let v27 = if (v0) {
                0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::deep_price::fee_quantity(&arg4, v3, arg2 - v5, v0)
            } else {
                0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::deep_price::fee_quantity(&arg4, arg1 - v5, v3, v0)
            };
            let v28 = v27;
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::math::mul(arg3, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balances::deep(&v28))
        };
        if (v0) {
            if (v3 < arg0.min_size) {
                (arg1, arg2, 0)
            } else {
                (v3, v5, v26)
            }
        } else {
            (v5, v3, v26)
        }
    }

    public(friend) fun get_quote_quantity_in(arg0: &Book, arg1: u64, arg2: u64, arg3: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::deep_price::OrderDeepPrice, arg4: bool, arg5: u64) : (u64, u64, u64) {
        get_quantity_in(arg0, arg1, 0, arg2, arg3, arg4, arg5)
    }

    fun inject_limit_order(arg0: &mut Book, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::OrderInfo) {
        if (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::is_bid(arg1)) {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::big_vector::insert<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order>(&mut arg0.bids, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::order_id(arg1), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::to_order(arg1));
        } else {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::big_vector::insert<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order>(&mut arg0.asks, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::order_id(arg1), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::to_order(arg1));
        };
    }

    public(friend) fun lot_size(arg0: &Book) : u64 {
        arg0.lot_size
    }

    fun match_against_book(arg0: &mut Book, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::OrderInfo, arg2: u64) {
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::is_bid(arg1);
        let v1 = if (v0) {
            &mut arg0.asks
        } else {
            &mut arg0.bids
        };
        let (v2, v3) = if (v0) {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::big_vector::min_slice<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order>(v1)
        } else {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::big_vector::max_slice<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order>(v1)
        };
        let v4 = v3;
        let v5 = v2;
        let v6 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::max_fills();
        let v7 = 0;
        while (!0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::big_vector::slice_is_null(&v5) && v7 < v6) {
            if (!0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::match_maker(arg1, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::big_vector::slice_borrow_mut<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::big_vector::borrow_slice_mut<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order>(v1, v5), v4), arg2)) {
                break
            };
            let (v8, v9) = if (v0) {
                0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::big_vector::next_slice<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order>(v1, v5, v4)
            } else {
                0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::big_vector::prev_slice<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order>(v1, v5, v4)
            };
            v4 = v9;
            v5 = v8;
            v7 = v7 + 1;
        };
        let v10 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::fills_ref(arg1);
        let v11 = 0;
        while (v11 < 0x1::vector::length<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::fill::Fill>(v10)) {
            let v12 = 0x1::vector::borrow<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::fill::Fill>(v10, v11);
            if (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::fill::expired(v12) || 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::fill::completed(v12)) {
                0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::big_vector::remove<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order>(v1, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::fill::maker_order_id(v12));
            };
            v11 = v11 + 1;
        };
        if (v7 == v6) {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::set_fill_limit_reached(arg1);
        };
    }

    public(friend) fun mid_price(arg0: &Book, arg1: u64) : u64 {
        let (v0, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::big_vector::min_slice<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order>(&arg0.asks);
        let v2 = v1;
        let v3 = v0;
        let (v4, v5) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::big_vector::max_slice<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order>(&arg0.bids);
        let v6 = v5;
        let v7 = v4;
        let v8 = 0;
        let v9 = 0;
        while (!0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::big_vector::slice_is_null(&v3)) {
            let v10 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::big_vector::slice_borrow<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::big_vector::borrow_slice<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order>(&arg0.asks, v3), v2);
            v8 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::price(v10);
            if (arg1 <= 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::expire_timestamp(v10)) {
                break
            };
            let (v11, v12) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::big_vector::next_slice<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order>(&arg0.asks, v3, v2);
            v2 = v12;
            v3 = v11;
        };
        while (!0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::big_vector::slice_is_null(&v7)) {
            let v13 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::big_vector::slice_borrow<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::big_vector::borrow_slice<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order>(&arg0.bids, v7), v6);
            v9 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::price(v13);
            if (arg1 <= 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::expire_timestamp(v13)) {
                break
            };
            let (v14, v15) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::big_vector::prev_slice<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order>(&arg0.bids, v7, v6);
            v6 = v15;
            v7 = v14;
        };
        assert!(!0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::big_vector::slice_is_null(&v3) && !0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::big_vector::slice_is_null(&v7), 2);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::math::mul(v8 + v9, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::half())
    }

    public(friend) fun min_size(arg0: &Book) : u64 {
        arg0.min_size
    }

    public(friend) fun modify_order(arg0: &mut Book, arg1: u128, arg2: u64, arg3: u64) : (u64, &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order) {
        assert!(arg2 >= arg0.min_size, 5);
        assert!(arg2 % arg0.lot_size == 0, 6);
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::big_vector::borrow_mut<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order>(book_side_mut(arg0, arg1), arg1);
        assert!(arg2 < 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::quantity(v0), 7);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::modify(v0, arg2, arg3);
        (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::quantity(v0) - arg2, v0)
    }

    fun round_up_to_lot_size(arg0: u64, arg1: u64) : u64 {
        let v0 = arg0 % arg1;
        if (v0 == 0) {
            arg0
        } else {
            arg0 + arg1 - v0
        }
    }

    public(friend) fun set_lot_size(arg0: &mut Book, arg1: u64) {
        arg0.lot_size = arg1;
    }

    public(friend) fun set_min_size(arg0: &mut Book, arg1: u64) {
        arg0.min_size = arg1;
    }

    public(friend) fun set_tick_size(arg0: &mut Book, arg1: u64) {
        arg0.tick_size = arg1;
    }

    public(friend) fun tick_size(arg0: &Book) : u64 {
        arg0.tick_size
    }

    // decompiled from Move bytecode v6
}

