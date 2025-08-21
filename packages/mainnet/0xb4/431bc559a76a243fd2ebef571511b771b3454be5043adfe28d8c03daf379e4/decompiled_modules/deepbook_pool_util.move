module 0xb4431bc559a76a243fd2ebef571511b771b3454be5043adfe28d8c03daf379e4::deepbook_pool_util {
    struct OrderView has copy, drop, store {
        price: u64,
        quantity: u64,
        filled_quantity: u64,
        expire_timestamp: u64,
    }

    struct BookView has copy, drop, store {
        asks: vector<OrderView>,
        bids: vector<OrderView>,
        tick_size: u64,
        lot_size: u64,
        min_size: u64,
    }

    struct DeepbookPoolEvent has copy, drop, store {
        pool_address: 0x2::object::ID,
        taker_fee: u64,
        maker_fee: u64,
        whitelisted: bool,
        book: BookView,
    }

    public fun best_ask<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: u64) : (0x1::option::Option<u64>, 0x1::option::Option<u128>) {
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_query::iter_orders<T0, T1>(arg0, 0x1::option::none<u128>(), 0x1::option::none<u128>(), 0x1::option::some<u64>(arg1), 1, false);
        let v1 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_query::orders(&v0);
        if (0x1::vector::length<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order>(v1) == 0) {
            (0x1::option::none<u64>(), 0x1::option::none<u128>())
        } else {
            let v4 = 0x1::vector::borrow<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order>(v1, 0);
            (0x1::option::some<u64>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::price(v4)), 0x1::option::some<u128>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::order_id(v4)))
        }
    }

    public fun best_bid<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: u64) : (0x1::option::Option<u64>, 0x1::option::Option<u128>) {
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_query::iter_orders<T0, T1>(arg0, 0x1::option::none<u128>(), 0x1::option::none<u128>(), 0x1::option::some<u64>(arg1), 1, true);
        let v1 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_query::orders(&v0);
        if (0x1::vector::length<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order>(v1) == 0) {
            (0x1::option::none<u64>(), 0x1::option::none<u128>())
        } else {
            let v4 = 0x1::vector::borrow<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order>(v1, 0);
            (0x1::option::some<u64>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::price(v4)), 0x1::option::some<u128>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::order_id(v4)))
        }
    }

    fun collect_asks<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: u64, arg2: 0x1::option::Option<u64>, arg3: 0x1::option::Option<u128>, arg4: u64, arg5: u64) : vector<OrderView> {
        if (!0x1::option::is_some<u128>(&arg3)) {
            return 0x1::vector::empty<OrderView>()
        };
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_query::iter_orders<T0, T1>(arg0, 0x1::option::some<u128>(*0x1::option::borrow<u128>(&arg3)), 0x1::option::none<u128>(), 0x1::option::some<u64>(arg1), arg5, false);
        let v1 = 0x1::vector::empty<OrderView>();
        let v2 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_query::orders(&v0);
        let v3 = 0x1::option::is_some<u64>(&arg2);
        let v4 = if (v3) {
            *0x1::option::borrow<u64>(&arg2)
        } else {
            0
        };
        let v5 = 0;
        while (v5 < 0x1::vector::length<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order>(v2)) {
            let v6 = 0x1::vector::borrow<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order>(v2, 0);
            if (v3 && !within_plus_pct(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::price(v6), v4, 1000)) {
                break
            };
            0x1::vector::push_back<OrderView>(&mut v1, to_view(v6));
            if (0x1::vector::length<OrderView>(&v1) >= arg5) {
                break
            };
            v5 = v5 + 1;
        };
        v1
    }

    fun collect_bids<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: u64, arg2: 0x1::option::Option<u64>, arg3: 0x1::option::Option<u128>, arg4: u64, arg5: u64) : vector<OrderView> {
        if (!0x1::option::is_some<u128>(&arg3)) {
            return 0x1::vector::empty<OrderView>()
        };
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_query::iter_orders<T0, T1>(arg0, 0x1::option::some<u128>(*0x1::option::borrow<u128>(&arg3)), 0x1::option::none<u128>(), 0x1::option::some<u64>(arg1), arg5, true);
        let v1 = 0x1::vector::empty<OrderView>();
        let v2 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_query::orders(&v0);
        let v3 = 0x1::option::is_some<u64>(&arg2);
        let v4 = if (v3) {
            *0x1::option::borrow<u64>(&arg2)
        } else {
            0
        };
        let v5 = 0;
        while (v5 < 0x1::vector::length<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order>(v2)) {
            let v6 = 0x1::vector::borrow<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order>(v2, 0);
            if (v3 && !within_minus_pct(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::price(v6), v4, 1000)) {
                break
            };
            0x1::vector::push_back<OrderView>(&mut v1, to_view(v6));
            if (0x1::vector::length<OrderView>(&v1) >= arg5) {
                break
            };
            v5 = v5 + 1;
        };
        v1
    }

    public fun get_pool_snapshot<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_trade_params<T0, T1>(arg0);
        let (v3, v4, v5) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<T0, T1>(arg0);
        let v6 = 0x2::clock::timestamp_ms(arg1);
        let (v7, v8) = best_bid<T0, T1>(arg0, v6);
        let v9 = v7;
        let (v10, v11) = best_ask<T0, T1>(arg0, v6);
        let v12 = v10;
        let v13 = if (0x1::option::is_some<u64>(&v9) && 0x1::option::is_some<u64>(&v12)) {
            0x1::option::some<u64>((*0x1::option::borrow<u64>(&v9) + *0x1::option::borrow<u64>(&v12)) / 2)
        } else if (0x1::option::is_some<u64>(&v9)) {
            v9
        } else {
            v12
        };
        let v14 = BookView{
            asks      : collect_asks<T0, T1>(arg0, v6, v13, v11, v3, 100),
            bids      : collect_bids<T0, T1>(arg0, v6, v13, v8, v3, 100),
            tick_size : v3,
            lot_size  : v4,
            min_size  : v5,
        };
        let v15 = DeepbookPoolEvent{
            pool_address : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg0),
            taker_fee    : v0,
            maker_fee    : v1,
            whitelisted  : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::whitelisted<T0, T1>(arg0),
            book         : v14,
        };
        0x2::event::emit<DeepbookPoolEvent>(v15);
    }

    fun to_view(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order) : OrderView {
        OrderView{
            price            : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::price(arg0),
            quantity         : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::quantity(arg0),
            filled_quantity  : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::filled_quantity(arg0),
            expire_timestamp : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::expire_timestamp(arg0),
        }
    }

    fun within_minus_pct(arg0: u64, arg1: u64, arg2: u64) : bool {
        (arg0 as u128) * (10000 as u128) >= (arg1 as u128) * ((10000 - arg2) as u128)
    }

    fun within_plus_pct(arg0: u64, arg1: u64, arg2: u64) : bool {
        (arg0 as u128) * (10000 as u128) <= (arg1 as u128) * ((10000 + arg2) as u128)
    }

    // decompiled from Move bytecode v6
}

