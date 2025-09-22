module 0xc402aa9e740a3e409a56c0718c3b34bb63e8836e4e478781af698ff4265ecc76::price {
    public fun average_price(arg0: &0xc402aa9e740a3e409a56c0718c3b34bb63e8836e4e478781af698ff4265ecc76::price_feed_storage::PriceFeedStorage, arg1: u64, arg2: bool, arg3: &0x2::clock::Clock) : u256 {
        let v0 = valid_prices_from_sources(arg0, *0xc402aa9e740a3e409a56c0718c3b34bb63e8836e4e478781af698ff4265ecc76::price_feed_storage::sources(arg0), arg1, arg2, arg3);
        let v1 = 0;
        0x1::vector::reverse<u256>(&mut v0);
        let v2 = 0;
        while (v2 < 0x1::vector::length<u256>(&v0)) {
            v1 = v1 + 0x1::vector::pop_back<u256>(&mut v0);
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<u256>(v0);
        0x59d346d409154e137b47dd6f05c7882f5ccd4ef8a7800239d622ac74083b271::ifixed::div(v1, 0x59d346d409154e137b47dd6f05c7882f5ccd4ef8a7800239d622ac74083b271::ifixed::from_u64(0x1::u64::max(0x1::vector::length<u256>(&v0), 1)))
    }

    public fun average_price_for_sources(arg0: &0xc402aa9e740a3e409a56c0718c3b34bb63e8836e4e478781af698ff4265ecc76::price_feed_storage::PriceFeedStorage, arg1: vector<0x2::object::ID>, arg2: u64, arg3: bool, arg4: &0x2::clock::Clock) : u256 {
        let v0 = valid_prices_from_sources(arg0, arg1, arg2, arg3, arg4);
        let v1 = 0;
        0x1::vector::reverse<u256>(&mut v0);
        let v2 = 0;
        while (v2 < 0x1::vector::length<u256>(&v0)) {
            v1 = v1 + 0x1::vector::pop_back<u256>(&mut v0);
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<u256>(v0);
        0x59d346d409154e137b47dd6f05c7882f5ccd4ef8a7800239d622ac74083b271::ifixed::div(v1, 0x59d346d409154e137b47dd6f05c7882f5ccd4ef8a7800239d622ac74083b271::ifixed::from_u64(0x1::u64::max(0x1::vector::length<u256>(&v0), 1)))
    }

    public fun average_reciprocal_price(arg0: &0xc402aa9e740a3e409a56c0718c3b34bb63e8836e4e478781af698ff4265ecc76::price_feed_storage::PriceFeedStorage, arg1: u64, arg2: bool, arg3: &0x2::clock::Clock) : u256 {
        let v0 = valid_prices_from_sources(arg0, *0xc402aa9e740a3e409a56c0718c3b34bb63e8836e4e478781af698ff4265ecc76::price_feed_storage::sources(arg0), arg1, arg2, arg3);
        let v1 = 0;
        0x1::vector::reverse<u256>(&mut v0);
        let v2 = 0;
        while (v2 < 0x1::vector::length<u256>(&v0)) {
            v1 = v1 + 0x1::vector::pop_back<u256>(&mut v0);
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<u256>(v0);
        let v3 = 0x59d346d409154e137b47dd6f05c7882f5ccd4ef8a7800239d622ac74083b271::ifixed::div(v1, 0x59d346d409154e137b47dd6f05c7882f5ccd4ef8a7800239d622ac74083b271::ifixed::from_u64(0x1::u64::max(0x1::vector::length<u256>(&v0), 1)));
        if (v3 == 0) {
            0
        } else {
            0x59d346d409154e137b47dd6f05c7882f5ccd4ef8a7800239d622ac74083b271::ifixed::div(0x59d346d409154e137b47dd6f05c7882f5ccd4ef8a7800239d622ac74083b271::ifixed::from_u64(1), v3)
        }
    }

    public fun average_reciprocal_price_for_sources(arg0: &0xc402aa9e740a3e409a56c0718c3b34bb63e8836e4e478781af698ff4265ecc76::price_feed_storage::PriceFeedStorage, arg1: vector<0x2::object::ID>, arg2: u64, arg3: bool, arg4: &0x2::clock::Clock) : u256 {
        let v0 = valid_prices_from_sources(arg0, arg1, arg2, arg3, arg4);
        let v1 = 0;
        0x1::vector::reverse<u256>(&mut v0);
        let v2 = 0;
        while (v2 < 0x1::vector::length<u256>(&v0)) {
            v1 = v1 + 0x1::vector::pop_back<u256>(&mut v0);
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<u256>(v0);
        let v3 = 0x59d346d409154e137b47dd6f05c7882f5ccd4ef8a7800239d622ac74083b271::ifixed::div(v1, 0x59d346d409154e137b47dd6f05c7882f5ccd4ef8a7800239d622ac74083b271::ifixed::from_u64(0x1::u64::max(0x1::vector::length<u256>(&v0), 1)));
        if (v3 == 0) {
            0
        } else {
            0x59d346d409154e137b47dd6f05c7882f5ccd4ef8a7800239d622ac74083b271::ifixed::div(0x59d346d409154e137b47dd6f05c7882f5ccd4ef8a7800239d622ac74083b271::ifixed::from_u64(1), v3)
        }
    }

    public fun median_price(arg0: &0xc402aa9e740a3e409a56c0718c3b34bb63e8836e4e478781af698ff4265ecc76::price_feed_storage::PriceFeedStorage, arg1: u64, arg2: &0x2::clock::Clock) : u256 {
        let v0 = valid_prices_from_sources(arg0, *0xc402aa9e740a3e409a56c0718c3b34bb63e8836e4e478781af698ff4265ecc76::price_feed_storage::sources(arg0), arg1, true, arg2);
        let v1 = 0x1::vector::length<u256>(&v0);
        if (v1 == 1) {
            *0x1::vector::borrow<u256>(&v0, 0)
        } else if (v1 == 2) {
            0x1::u256::max(*0x1::vector::borrow<u256>(&v0, 0), *0x1::vector::borrow<u256>(&v0, 1))
        } else {
            assert!(v1 == 3, 2);
            let v3 = *0x1::vector::borrow<u256>(&v0, 0);
            let v4 = *0x1::vector::borrow<u256>(&v0, 1);
            0x1::u256::max(0x1::u256::min(0x1::u256::max(v3, v4), *0x1::vector::borrow<u256>(&v0, 2)), 0x1::u256::min(v3, v4))
        }
    }

    public fun newest_price(arg0: &0xc402aa9e740a3e409a56c0718c3b34bb63e8836e4e478781af698ff4265ecc76::price_feed_storage::PriceFeedStorage, arg1: u64, arg2: bool, arg3: &0x2::clock::Clock) : u256 {
        if (0xc402aa9e740a3e409a56c0718c3b34bb63e8836e4e478781af698ff4265ecc76::price_feed_storage::size(arg0) == 0) {
            if (arg2) {
                abort 0
            };
            return 0
        };
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = 0;
        let v2 = 0;
        let v3 = 0;
        let v4 = *0xc402aa9e740a3e409a56c0718c3b34bb63e8836e4e478781af698ff4265ecc76::price_feed_storage::sources(arg0);
        0x1::vector::reverse<0x2::object::ID>(&mut v4);
        let v5 = 0;
        while (v5 < 0x1::vector::length<0x2::object::ID>(&v4)) {
            let (v6, v7) = 0xc402aa9e740a3e409a56c0718c3b34bb63e8836e4e478781af698ff4265ecc76::price_feed::price_and_timestamp(0xc402aa9e740a3e409a56c0718c3b34bb63e8836e4e478781af698ff4265ecc76::price_feed_storage::price_feed(arg0, 0x1::vector::pop_back<0x2::object::ID>(&mut v4)));
            if (v7 > v2 || v2 == 0 && v7 >= v0 - 0x1::u64::min(v0, arg1)) {
                v1 = v1 + 1;
            };
            v3 = v6;
            v5 = v5 + 1;
        };
        0x1::vector::destroy_empty<0x2::object::ID>(v4);
        if (v1 == 0 && arg2) {
            abort 1
        };
        v3
    }

    public fun valid_prices_from_sources(arg0: &0xc402aa9e740a3e409a56c0718c3b34bb63e8836e4e478781af698ff4265ecc76::price_feed_storage::PriceFeedStorage, arg1: vector<0x2::object::ID>, arg2: u64, arg3: bool, arg4: &0x2::clock::Clock) : vector<u256> {
        if (0x1::vector::length<0x2::object::ID>(&arg1) == 0 && arg3) {
            abort 0
        };
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let v1 = vector[];
        0x1::vector::reverse<0x2::object::ID>(&mut arg1);
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x2::object::ID>(&arg1)) {
            let (v3, v4) = 0xc402aa9e740a3e409a56c0718c3b34bb63e8836e4e478781af698ff4265ecc76::price_feed::price_and_timestamp(0xc402aa9e740a3e409a56c0718c3b34bb63e8836e4e478781af698ff4265ecc76::price_feed_storage::price_feed(arg0, 0x1::vector::pop_back<0x2::object::ID>(&mut arg1)));
            if (v3 != 0 && v3 < 0x59d346d409154e137b47dd6f05c7882f5ccd4ef8a7800239d622ac74083b271::ifixed::max_value() && v4 >= v0 - 0x1::u64::min(v0, arg2) && v4 <= 0x2::clock::timestamp_ms(arg4)) {
                0x1::vector::push_back<u256>(&mut v1, v3);
            };
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<0x2::object::ID>(arg1);
        if (0x1::vector::is_empty<u256>(&v1) && arg3) {
            abort 1
        };
        v1
    }

    // decompiled from Move bytecode v6
}

