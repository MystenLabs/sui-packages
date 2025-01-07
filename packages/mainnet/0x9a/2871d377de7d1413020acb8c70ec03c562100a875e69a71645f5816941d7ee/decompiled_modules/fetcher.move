module 0x9a2871d377de7d1413020acb8c70ec03c562100a875e69a71645f5816941d7ee::fetcher {
    struct PriceData has copy, drop, store {
        price: u64,
        depth: u64,
    }

    struct FetchDeepbookStatusEvent has copy, drop, store {
        prices: vector<PriceData>,
    }

    struct TestEvent has copy, drop, store {
        price_vec_len: u64,
        depth_vec_len: u64,
    }

    struct FetchDeepbookStatusEvent2 has copy, drop, store {
        price: u64,
        price_high: u64,
        price_lower: u64,
        price_vec_len: u64,
        depth_vec_len: u64,
        prices: vector<PriceData>,
    }

    public entry fun fetch_deepbook_status_ask_side<T0, T1>(arg0: &0xdee9::clob_v2::Pool<T0, T1>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock) {
        assert!(arg1 >= 1 && arg1 <= 10, 0);
        assert!(arg2 > 0, 1);
        let (_, v1) = 0xdee9::clob_v2::get_market_price<T0, T1>(arg0);
        let v2 = v1;
        let v3 = 0x1::vector::empty<PriceData>();
        let v4 = 0;
        let v5 = 0;
        let v6 = 0;
        if (0x1::option::is_some<u64>(&v2)) {
            v4 = *0x1::option::borrow<u64>(&v2);
            let v7 = *0x1::option::borrow_mut<u64>(&mut v2) / arg2 * arg2 - arg2;
            let v8 = v7 + arg2;
            let v9 = v8;
            v5 = v8;
            v6 = v7;
            let v10 = 0;
            while (v10 < arg1) {
                let (v11, v12) = 0xdee9::clob_v2::get_level2_book_status_ask_side<T0, T1>(arg0, v7, v9, arg3);
                let v13 = v12;
                let v14 = v11;
                if (0x1::vector::length<u64>(&v14) == 0 || 0x1::vector::length<u64>(&v13) == 0) {
                    v7 = v9 + 1;
                    v9 = v9 + arg2;
                    continue
                };
                let v15 = 0;
                let v16 = 0;
                while (v16 < 0x1::vector::length<u64>(&v13)) {
                    v15 = v15 + *0x1::vector::borrow<u64>(&v13, v16);
                    v16 = v16 + 1;
                };
                let v17 = PriceData{
                    price : v9,
                    depth : v15,
                };
                0x1::vector::push_back<PriceData>(&mut v3, v17);
                v7 = v9 + 1;
                v9 = v9 + arg2;
                v10 = v10 + 1;
            };
        };
        let v18 = FetchDeepbookStatusEvent2{
            price         : v4,
            price_high    : v5,
            price_lower   : v6,
            price_vec_len : 0,
            depth_vec_len : 0,
            prices        : v3,
        };
        0x2::event::emit<FetchDeepbookStatusEvent2>(v18);
    }

    public entry fun fetch_deepbook_status_bid_side<T0, T1>(arg0: &0xdee9::clob_v2::Pool<T0, T1>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock) {
        assert!(arg1 >= 1 && arg1 <= 10, 0);
        assert!(arg2 > 0, 1);
        let (v0, _) = 0xdee9::clob_v2::get_market_price<T0, T1>(arg0);
        let v2 = v0;
        let v3 = 0x1::vector::empty<PriceData>();
        let v4 = 0;
        let v5 = 0;
        let v6 = 0;
        let v7 = 0;
        let v8 = 0;
        if (0x1::option::is_some<u64>(&v2)) {
            v4 = *0x1::option::borrow<u64>(&v2);
            let v9 = *0x1::option::borrow_mut<u64>(&mut v2) / arg2 * arg2 + arg2;
            v5 = v9;
            let v10 = v9 - arg2;
            let v11 = v10;
            v6 = v10;
            let v12 = 0;
            while (v12 < arg1) {
                let (v13, v14) = 0xdee9::clob_v2::get_level2_book_status_bid_side<T0, T1>(arg0, v11, v9, arg3);
                let v15 = v14;
                let v16 = v13;
                if (0x1::vector::length<u64>(&v16) == 0 || 0x1::vector::length<u64>(&v15) == 0) {
                    v9 = v11 - 1;
                    v11 = v11 - arg2;
                    continue
                };
                v7 = 0x1::vector::length<u64>(&v16);
                v8 = 0x1::vector::length<u64>(&v15);
                let v17 = 0;
                let v18 = 0;
                while (v18 < 0x1::vector::length<u64>(&v15)) {
                    v17 = v17 + *0x1::vector::borrow<u64>(&v15, v18);
                    v18 = v18 + 1;
                };
                let v19 = PriceData{
                    price : v11,
                    depth : v17,
                };
                0x1::vector::push_back<PriceData>(&mut v3, v19);
                v9 = v11 - 1;
                v11 = v11 - arg2;
                v12 = v12 + 1;
            };
        };
        let v20 = FetchDeepbookStatusEvent2{
            price         : v4,
            price_high    : v5,
            price_lower   : v6,
            price_vec_len : v7,
            depth_vec_len : v8,
            prices        : v3,
        };
        0x2::event::emit<FetchDeepbookStatusEvent2>(v20);
    }

    public entry fun test<T0, T1>(arg0: &0xdee9::clob_v2::Pool<T0, T1>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock) {
        let (v0, v1) = 0xdee9::clob_v2::get_level2_book_status_bid_side<T0, T1>(arg0, 0, 100000000000, arg3);
        let v2 = v1;
        let v3 = v0;
        let v4 = TestEvent{
            price_vec_len : 0x1::vector::length<u64>(&v3),
            depth_vec_len : 0x1::vector::length<u64>(&v2),
        };
        0x2::event::emit<TestEvent>(v4);
    }

    // decompiled from Move bytecode v6
}

