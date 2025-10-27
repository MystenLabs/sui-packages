module 0x65db0cc750b08565dd178c6b5e66069a6485536a6e5371d3157dc2194717d666::price {
    public fun average_price(arg0: &0x65db0cc750b08565dd178c6b5e66069a6485536a6e5371d3157dc2194717d666::price_feed_storage::PriceFeedStorage, arg1: &0x65db0cc750b08565dd178c6b5e66069a6485536a6e5371d3157dc2194717d666::config::Config, arg2: u64, arg3: bool, arg4: &0x2::clock::Clock) : u256 {
        let v0 = valid_prices_from_sources(arg0, arg1, *0x65db0cc750b08565dd178c6b5e66069a6485536a6e5371d3157dc2194717d666::price_feed_storage::sources(arg0), arg2, arg3, arg4);
        let v1 = 0;
        0x1::vector::reverse<u256>(&mut v0);
        let v2 = 0;
        while (v2 < 0x1::vector::length<u256>(&v0)) {
            v1 = v1 + 0x1::vector::pop_back<u256>(&mut v0);
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<u256>(v0);
        0xc15ee4dcdc9f93d19c9c0c28dfca2c91a650747b5cebcdba67b5191bee9290b0::ifixed::div(v1, 0xc15ee4dcdc9f93d19c9c0c28dfca2c91a650747b5cebcdba67b5191bee9290b0::ifixed::from_u64(0x1::u64::max(0x1::vector::length<u256>(&v0), 1)))
    }

    public fun average_price_for_sources(arg0: &0x65db0cc750b08565dd178c6b5e66069a6485536a6e5371d3157dc2194717d666::price_feed_storage::PriceFeedStorage, arg1: &0x65db0cc750b08565dd178c6b5e66069a6485536a6e5371d3157dc2194717d666::config::Config, arg2: vector<0x2::object::ID>, arg3: u64, arg4: bool, arg5: &0x2::clock::Clock) : u256 {
        let v0 = valid_prices_from_sources(arg0, arg1, arg2, arg3, arg4, arg5);
        let v1 = 0;
        0x1::vector::reverse<u256>(&mut v0);
        let v2 = 0;
        while (v2 < 0x1::vector::length<u256>(&v0)) {
            v1 = v1 + 0x1::vector::pop_back<u256>(&mut v0);
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<u256>(v0);
        0xc15ee4dcdc9f93d19c9c0c28dfca2c91a650747b5cebcdba67b5191bee9290b0::ifixed::div(v1, 0xc15ee4dcdc9f93d19c9c0c28dfca2c91a650747b5cebcdba67b5191bee9290b0::ifixed::from_u64(0x1::u64::max(0x1::vector::length<u256>(&v0), 1)))
    }

    public fun average_reciprocal_price(arg0: &0x65db0cc750b08565dd178c6b5e66069a6485536a6e5371d3157dc2194717d666::price_feed_storage::PriceFeedStorage, arg1: &0x65db0cc750b08565dd178c6b5e66069a6485536a6e5371d3157dc2194717d666::config::Config, arg2: u64, arg3: bool, arg4: &0x2::clock::Clock) : u256 {
        let v0 = valid_prices_from_sources(arg0, arg1, *0x65db0cc750b08565dd178c6b5e66069a6485536a6e5371d3157dc2194717d666::price_feed_storage::sources(arg0), arg2, arg3, arg4);
        let v1 = 0;
        0x1::vector::reverse<u256>(&mut v0);
        let v2 = 0;
        while (v2 < 0x1::vector::length<u256>(&v0)) {
            v1 = v1 + 0x1::vector::pop_back<u256>(&mut v0);
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<u256>(v0);
        let v3 = 0xc15ee4dcdc9f93d19c9c0c28dfca2c91a650747b5cebcdba67b5191bee9290b0::ifixed::div(v1, 0xc15ee4dcdc9f93d19c9c0c28dfca2c91a650747b5cebcdba67b5191bee9290b0::ifixed::from_u64(0x1::u64::max(0x1::vector::length<u256>(&v0), 1)));
        if (v3 == 0) {
            0
        } else {
            0xc15ee4dcdc9f93d19c9c0c28dfca2c91a650747b5cebcdba67b5191bee9290b0::ifixed::div(0xc15ee4dcdc9f93d19c9c0c28dfca2c91a650747b5cebcdba67b5191bee9290b0::ifixed::from_u64(1), v3)
        }
    }

    public fun average_reciprocal_price_for_sources(arg0: &0x65db0cc750b08565dd178c6b5e66069a6485536a6e5371d3157dc2194717d666::price_feed_storage::PriceFeedStorage, arg1: &0x65db0cc750b08565dd178c6b5e66069a6485536a6e5371d3157dc2194717d666::config::Config, arg2: vector<0x2::object::ID>, arg3: u64, arg4: bool, arg5: &0x2::clock::Clock) : u256 {
        let v0 = valid_prices_from_sources(arg0, arg1, arg2, arg3, arg4, arg5);
        let v1 = 0;
        0x1::vector::reverse<u256>(&mut v0);
        let v2 = 0;
        while (v2 < 0x1::vector::length<u256>(&v0)) {
            v1 = v1 + 0x1::vector::pop_back<u256>(&mut v0);
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<u256>(v0);
        let v3 = 0xc15ee4dcdc9f93d19c9c0c28dfca2c91a650747b5cebcdba67b5191bee9290b0::ifixed::div(v1, 0xc15ee4dcdc9f93d19c9c0c28dfca2c91a650747b5cebcdba67b5191bee9290b0::ifixed::from_u64(0x1::u64::max(0x1::vector::length<u256>(&v0), 1)));
        if (v3 == 0) {
            0
        } else {
            0xc15ee4dcdc9f93d19c9c0c28dfca2c91a650747b5cebcdba67b5191bee9290b0::ifixed::div(0xc15ee4dcdc9f93d19c9c0c28dfca2c91a650747b5cebcdba67b5191bee9290b0::ifixed::from_u64(1), v3)
        }
    }

    public fun median_price(arg0: &0x65db0cc750b08565dd178c6b5e66069a6485536a6e5371d3157dc2194717d666::price_feed_storage::PriceFeedStorage, arg1: &0x65db0cc750b08565dd178c6b5e66069a6485536a6e5371d3157dc2194717d666::config::Config, arg2: u64, arg3: &0x2::clock::Clock) : u256 {
        median_price_from_sources(arg0, arg1, *0x65db0cc750b08565dd178c6b5e66069a6485536a6e5371d3157dc2194717d666::price_feed_storage::sources(arg0), arg2, arg3)
    }

    public fun median_price_from_sources(arg0: &0x65db0cc750b08565dd178c6b5e66069a6485536a6e5371d3157dc2194717d666::price_feed_storage::PriceFeedStorage, arg1: &0x65db0cc750b08565dd178c6b5e66069a6485536a6e5371d3157dc2194717d666::config::Config, arg2: vector<0x2::object::ID>, arg3: u64, arg4: &0x2::clock::Clock) : u256 {
        let v0 = valid_prices_from_sources(arg0, arg1, arg2, arg3, true, arg4);
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

    public fun newest_price(arg0: &0x65db0cc750b08565dd178c6b5e66069a6485536a6e5371d3157dc2194717d666::price_feed_storage::PriceFeedStorage, arg1: &0x65db0cc750b08565dd178c6b5e66069a6485536a6e5371d3157dc2194717d666::config::Config, arg2: u64, arg3: bool, arg4: &0x2::clock::Clock) : u256 {
        newest_price_from_sources(arg0, arg1, *0x65db0cc750b08565dd178c6b5e66069a6485536a6e5371d3157dc2194717d666::price_feed_storage::sources(arg0), arg2, arg3, arg4)
    }

    public fun newest_price_from_sources(arg0: &0x65db0cc750b08565dd178c6b5e66069a6485536a6e5371d3157dc2194717d666::price_feed_storage::PriceFeedStorage, arg1: &0x65db0cc750b08565dd178c6b5e66069a6485536a6e5371d3157dc2194717d666::config::Config, arg2: vector<0x2::object::ID>, arg3: u64, arg4: bool, arg5: &0x2::clock::Clock) : u256 {
        0x65db0cc750b08565dd178c6b5e66069a6485536a6e5371d3157dc2194717d666::config::assert_package_version(arg1);
        if (0x65db0cc750b08565dd178c6b5e66069a6485536a6e5371d3157dc2194717d666::price_feed_storage::size(arg0) == 0) {
            if (arg4) {
                abort 0
            };
            return 0
        };
        let v0 = 0x2::clock::timestamp_ms(arg5);
        let v1 = 18446744073709551615;
        let v2 = v1;
        let v3 = 0;
        0x1::vector::reverse<0x2::object::ID>(&mut arg2);
        let v4 = 0;
        while (v4 < 0x1::vector::length<0x2::object::ID>(&arg2)) {
            let (v5, v6) = 0x65db0cc750b08565dd178c6b5e66069a6485536a6e5371d3157dc2194717d666::price_feed::price_and_timestamp(0x65db0cc750b08565dd178c6b5e66069a6485536a6e5371d3157dc2194717d666::price_feed_storage::price_feed(arg0, 0x1::vector::pop_back<0x2::object::ID>(&mut arg2)));
            if (v6 > v1 || v1 == 18446744073709551615 && v6 >= v0 - 0x1::u64::min(v0, arg3)) {
                v2 = v6;
                v3 = v5;
            };
            v4 = v4 + 1;
        };
        0x1::vector::destroy_empty<0x2::object::ID>(arg2);
        if (v2 == 18446744073709551615 && arg4) {
            abort 1
        };
        v3
    }

    public fun valid_prices_from_sources(arg0: &0x65db0cc750b08565dd178c6b5e66069a6485536a6e5371d3157dc2194717d666::price_feed_storage::PriceFeedStorage, arg1: &0x65db0cc750b08565dd178c6b5e66069a6485536a6e5371d3157dc2194717d666::config::Config, arg2: vector<0x2::object::ID>, arg3: u64, arg4: bool, arg5: &0x2::clock::Clock) : vector<u256> {
        0x65db0cc750b08565dd178c6b5e66069a6485536a6e5371d3157dc2194717d666::config::assert_package_version(arg1);
        if (0x1::vector::length<0x2::object::ID>(&arg2) == 0 && arg4) {
            abort 0
        };
        let v0 = 0x2::clock::timestamp_ms(arg5);
        let v1 = vector[];
        0x1::vector::reverse<0x2::object::ID>(&mut arg2);
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x2::object::ID>(&arg2)) {
            let (v3, v4) = 0x65db0cc750b08565dd178c6b5e66069a6485536a6e5371d3157dc2194717d666::price_feed::price_and_timestamp(0x65db0cc750b08565dd178c6b5e66069a6485536a6e5371d3157dc2194717d666::price_feed_storage::price_feed(arg0, 0x1::vector::pop_back<0x2::object::ID>(&mut arg2)));
            if (v3 != 0 && v3 < 0xc15ee4dcdc9f93d19c9c0c28dfca2c91a650747b5cebcdba67b5191bee9290b0::ifixed::max_value() && v4 >= v0 - 0x1::u64::min(v0, arg3) && v4 <= 0x2::clock::timestamp_ms(arg5)) {
                0x1::vector::push_back<u256>(&mut v1, v3);
            };
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<0x2::object::ID>(arg2);
        if (0x1::vector::is_empty<u256>(&v1) && arg4) {
            abort 1
        };
        v1
    }

    // decompiled from Move bytecode v6
}

