module 0xf5ebdffd038d1dc3a336a91f09167c1abd855c81480907155560912c72ae5fb7::fetcher {
    struct PriceData has copy, drop, store {
        price: u64,
        depth: u64,
    }

    struct PriceRange has copy, drop, store {
        price_low: u64,
        price_high: u64,
    }

    struct FetchDeepbookStatusEvent has copy, drop, store {
        has_next_page: bool,
        next_tick_level: 0x1::option::Option<u64>,
        next_order_id: 0x1::option::Option<u64>,
        prices: vector<PriceData>,
        price_range: vector<PriceRange>,
        check_point: vector<u64>,
        tick_level: vector<u64>,
    }

    fun add_price_data_to_vec(arg0: &mut vector<PriceData>, arg1: u64, arg2: u64) {
        let v0 = PriceData{
            price : arg1,
            depth : arg2,
        };
        0x1::vector::push_back<PriceData>(arg0, v0);
    }

    fun add_price_range_to_vec(arg0: &mut vector<PriceRange>, arg1: u64, arg2: u64) {
        let v0 = PriceRange{
            price_low  : arg1,
            price_high : arg2,
        };
        0x1::vector::push_back<PriceRange>(arg0, v0);
    }

    fun calc_ask_check_point(arg0: u64, arg1: u64) : u64 {
        let v0 = arg0 / arg1 * arg1;
        if (v0 == arg0) {
            return arg0
        };
        v0 + arg1
    }

    fun calc_bid_check_point(arg0: u64, arg1: u64) : u64 {
        arg0 / arg1 * arg1
    }

    public entry fun fetch_deepbook_status_ask_side<T0, T1>(arg0: &0xdee9::clob_v2::Pool<T0, T1>, arg1: u64, arg2: u64, arg3: 0x1::option::Option<u64>, arg4: 0x1::option::Option<u64>, arg5: &0x2::clock::Clock) {
        assert!(arg1 >= 1 && arg1 <= 10, 0);
        assert!(arg2 > 0, 1);
        let v0 = 0x1::vector::empty<PriceRange>();
        let v1 = 0x1::vector::empty<PriceData>();
        let v2 = 0x1::vector::empty<u64>();
        let v3 = 0x1::vector::empty<u64>();
        let v4 = 0;
        let v5 = 0;
        let v6 = 0x1::option::none<u64>();
        let v7 = 0x1::option::none<u64>();
        let v8 = false;
        let v9 = 0;
        let v10 = v9;
        loop {
            let v11 = 0xdee9::order_query::iter_asks<T0, T1>(arg0, arg3, arg4, 0x1::option::none<u64>(), 0x1::option::none<u64>(), true);
            let v12 = 0xdee9::order_query::orders(&v11);
            let v13 = 0x1::vector::length<0xdee9::clob_v2::Order>(v12);
            if (v13 == 0) {
                break
            };
            let v14 = 0;
            while (v14 < v13) {
                let v15 = 0xdee9::order_query::tick_level(0x1::vector::borrow<0xdee9::clob_v2::Order>(v12, v14));
                0x1::vector::push_back<u64>(&mut v3, v15);
                if (v14 == 0) {
                    if (0x1::vector::length<PriceRange>(&v0) == 0) {
                        let v16 = calc_ask_check_point(v15, arg2);
                        v4 = v16;
                        0x1::vector::push_back<u64>(&mut v2, v16);
                        let v17 = &mut v0;
                        add_price_range_to_vec(v17, v15, 0);
                        v10 = v15;
                        v14 = v14 + 1;
                        continue
                    };
                };
                if (v15 > v4) {
                    0x1::vector::borrow_mut<PriceRange>(&mut v0, v5).price_high = v9;
                    let v18 = v5 + 1;
                    v5 = v18;
                    if (v18 >= arg1) {
                        if (v14 != v13 - 1) {
                            let v19 = 0x1::vector::borrow<0xdee9::clob_v2::Order>(v12, v14 + 1);
                            v8 = true;
                            v7 = 0x1::option::some<u64>(0xdee9::order_query::order_id(v19));
                            v6 = 0x1::option::some<u64>(0xdee9::order_query::tick_level(v19));
                            break
                        };
                        if (0xdee9::order_query::has_next_page(&v11)) {
                            v8 = true;
                            v7 = 0xdee9::order_query::next_order_id(&v11);
                            v6 = 0xdee9::order_query::next_tick_level(&v11);
                            break
                        };
                        break
                    };
                    let v20 = &mut v0;
                    add_price_range_to_vec(v20, v15, 0);
                    let v21 = calc_ask_check_point(v15, arg2);
                    v4 = v21;
                    0x1::vector::push_back<u64>(&mut v2, v21);
                };
                v10 = v15;
                v14 = v14 + 1;
            };
            if (v5 >= arg1) {
                break
            };
            if (!0xdee9::order_query::has_next_page(&v11)) {
                0x1::vector::borrow_mut<PriceRange>(&mut v0, v5).price_high = v10;
                break
            };
            arg3 = 0xdee9::order_query::next_tick_level(&v11);
            arg4 = 0xdee9::order_query::next_order_id(&v11);
        };
        let v22 = 0;
        while (v22 < 0x1::vector::length<PriceRange>(&v0)) {
            let v23 = 0x1::vector::borrow<PriceRange>(&v0, v22);
            let (_, v25) = 0xdee9::clob_v2::get_level2_book_status_ask_side<T0, T1>(arg0, v23.price_low, v23.price_high, arg5);
            let v26 = v25;
            if (0x1::vector::length<u64>(&v26) != 0) {
                let v27 = &mut v1;
                add_price_data_to_vec(v27, calc_ask_check_point(v23.price_low, arg2), sum_depth(&v26));
            };
            v22 = v22 + 1;
        };
        let v28 = FetchDeepbookStatusEvent{
            has_next_page   : v8,
            next_tick_level : v6,
            next_order_id   : v7,
            prices          : v1,
            price_range     : v0,
            check_point     : v2,
            tick_level      : v3,
        };
        0x2::event::emit<FetchDeepbookStatusEvent>(v28);
    }

    public entry fun fetch_deepbook_status_bid_side<T0, T1>(arg0: &0xdee9::clob_v2::Pool<T0, T1>, arg1: u64, arg2: u64, arg3: 0x1::option::Option<u64>, arg4: 0x1::option::Option<u64>, arg5: &0x2::clock::Clock) {
        assert!(arg1 >= 1 && arg1 <= 10, 0);
        assert!(arg2 > 0, 1);
        let v0 = 0x1::vector::empty<PriceRange>();
        let v1 = 0x1::vector::empty<PriceData>();
        let v2 = 0;
        let v3 = 0;
        let v4 = 0x1::option::none<u64>();
        let v5 = 0x1::option::none<u64>();
        let v6 = false;
        let v7 = 0;
        let v8 = v7;
        loop {
            let v9 = 0xdee9::order_query::iter_bids<T0, T1>(arg0, arg3, arg4, 0x1::option::none<u64>(), 0x1::option::none<u64>(), false);
            let v10 = 0xdee9::order_query::orders(&v9);
            let v11 = 0x1::vector::length<0xdee9::clob_v2::Order>(v10);
            if (v11 == 0) {
                break
            };
            let v12 = 0;
            while (v12 < v11) {
                let v13 = 0xdee9::order_query::tick_level(0x1::vector::borrow<0xdee9::clob_v2::Order>(v10, v12));
                if (v12 == 0) {
                    if (0x1::vector::length<PriceRange>(&v0) == 0) {
                        v2 = calc_bid_check_point(v13, arg2);
                        let v14 = &mut v0;
                        add_price_range_to_vec(v14, 0, v13);
                        v8 = v13;
                        v12 = v12 + 1;
                        continue
                    };
                };
                if (v13 >= v2) {
                    v8 = v13;
                } else {
                    0x1::vector::borrow_mut<PriceRange>(&mut v0, v3).price_low = v7;
                    let v15 = v3 + 1;
                    v3 = v15;
                    if (v15 >= arg1) {
                        if (v12 != v11 - 1) {
                            let v16 = 0x1::vector::borrow<0xdee9::clob_v2::Order>(v10, v12 + 1);
                            v6 = true;
                            v5 = 0x1::option::some<u64>(0xdee9::order_query::order_id(v16));
                            v4 = 0x1::option::some<u64>(0xdee9::order_query::tick_level(v16));
                            break
                        };
                        if (0xdee9::order_query::has_next_page(&v9)) {
                            v6 = true;
                            v5 = 0xdee9::order_query::next_order_id(&v9);
                            v4 = 0xdee9::order_query::next_tick_level(&v9);
                            break
                        };
                        break
                    };
                    let v17 = &mut v0;
                    add_price_range_to_vec(v17, 0, v13);
                    v2 = calc_bid_check_point(v13, arg2);
                };
                v12 = v12 + 1;
            };
            if (v3 >= arg1) {
                break
            };
            if (!0xdee9::order_query::has_next_page(&v9)) {
                0x1::vector::borrow_mut<PriceRange>(&mut v0, v3).price_low = v8;
                break
            };
            arg3 = 0xdee9::order_query::next_tick_level(&v9);
            arg4 = 0xdee9::order_query::next_order_id(&v9);
        };
        let v18 = 0;
        while (v18 < 0x1::vector::length<PriceRange>(&v0)) {
            let v19 = 0x1::vector::borrow<PriceRange>(&v0, v18);
            let (_, v21) = 0xdee9::clob_v2::get_level2_book_status_bid_side<T0, T1>(arg0, v19.price_low, v19.price_high, arg5);
            let v22 = v21;
            if (0x1::vector::length<u64>(&v22) != 0) {
                let v23 = &mut v1;
                add_price_data_to_vec(v23, calc_bid_check_point(v19.price_high, arg2), sum_depth(&v22));
            };
            v18 = v18 + 1;
        };
        let v24 = FetchDeepbookStatusEvent{
            has_next_page   : v6,
            next_tick_level : v4,
            next_order_id   : v5,
            prices          : v1,
            price_range     : v0,
            check_point     : 0x1::vector::empty<u64>(),
            tick_level      : 0x1::vector::empty<u64>(),
        };
        0x2::event::emit<FetchDeepbookStatusEvent>(v24);
    }

    fun sum_depth(arg0: &vector<u64>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(arg0)) {
            v0 = v0 + *0x1::vector::borrow<u64>(arg0, v1);
            v1 = v1 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v6
}

