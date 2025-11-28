module 0x823642674a8ea1b44355c320af2992081cf3b75221b336abe7a7b32f09b34574::price {
    public fun median_price_from_sources_above_confidence(arg0: &0x823642674a8ea1b44355c320af2992081cf3b75221b336abe7a7b32f09b34574::price_feed_storage::PriceFeedStorage, arg1: &0x823642674a8ea1b44355c320af2992081cf3b75221b336abe7a7b32f09b34574::config::Config, arg2: vector<0x2::object::ID>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock) : u256 {
        let v0 = valid_prices_from_sources_above_confidence(arg0, arg1, arg2, arg3, arg4, true, arg5);
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

    public fun newest_price_from_sources_above_confidence(arg0: &0x823642674a8ea1b44355c320af2992081cf3b75221b336abe7a7b32f09b34574::price_feed_storage::PriceFeedStorage, arg1: &0x823642674a8ea1b44355c320af2992081cf3b75221b336abe7a7b32f09b34574::config::Config, arg2: vector<0x2::object::ID>, arg3: u64, arg4: u64, arg5: bool, arg6: &0x2::clock::Clock) : u256 {
        0x823642674a8ea1b44355c320af2992081cf3b75221b336abe7a7b32f09b34574::config::assert_package_version(arg1);
        if (0x823642674a8ea1b44355c320af2992081cf3b75221b336abe7a7b32f09b34574::price_feed_storage::size(arg0) == 0) {
            if (arg5) {
                abort 0
            };
            return 0
        };
        if (arg3 > 10000) {
            if (arg5) {
                abort 3
            };
            return 0
        };
        let v0 = 0x2::clock::timestamp_ms(arg6);
        let v1 = 18446744073709551615;
        let v2 = v1;
        let v3 = 0;
        0x1::vector::reverse<0x2::object::ID>(&mut arg2);
        let v4 = 0;
        while (v4 < 0x1::vector::length<0x2::object::ID>(&arg2)) {
            let (v5, v6, _, v8) = 0x823642674a8ea1b44355c320af2992081cf3b75221b336abe7a7b32f09b34574::price_feed::as_parts(0x823642674a8ea1b44355c320af2992081cf3b75221b336abe7a7b32f09b34574::price_feed_storage::price_feed(arg0, 0x1::vector::pop_back<0x2::object::ID>(&mut arg2)));
            let v9 = if (v0 - 0x1::u64::min(v0, arg4) <= v8 && v8 <= 0x2::clock::timestamp_ms(arg6)) {
                if (v1 == 18446744073709551615 || v8 > v1) {
                    v6 >= arg3 * 100000000000000
                } else {
                    false
                }
            } else {
                false
            };
            if (v9) {
                v2 = v8;
                v3 = v5;
            };
            v4 = v4 + 1;
        };
        0x1::vector::destroy_empty<0x2::object::ID>(arg2);
        if (v2 == 18446744073709551615 && arg5) {
            abort 1
        };
        v3
    }

    public fun valid_prices_from_sources_above_confidence(arg0: &0x823642674a8ea1b44355c320af2992081cf3b75221b336abe7a7b32f09b34574::price_feed_storage::PriceFeedStorage, arg1: &0x823642674a8ea1b44355c320af2992081cf3b75221b336abe7a7b32f09b34574::config::Config, arg2: vector<0x2::object::ID>, arg3: u64, arg4: u64, arg5: bool, arg6: &0x2::clock::Clock) : vector<u256> {
        0x823642674a8ea1b44355c320af2992081cf3b75221b336abe7a7b32f09b34574::config::assert_package_version(arg1);
        if (0x1::vector::length<0x2::object::ID>(&arg2) == 0 && arg5) {
            abort 0
        };
        if (arg3 > 10000) {
            if (arg5) {
                abort 3
            };
            return vector[]
        };
        let v0 = 0x2::clock::timestamp_ms(arg6);
        let v1 = vector[];
        0x1::vector::reverse<0x2::object::ID>(&mut arg2);
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x2::object::ID>(&arg2)) {
            let (v3, v4, _, v6) = 0x823642674a8ea1b44355c320af2992081cf3b75221b336abe7a7b32f09b34574::price_feed::as_parts(0x823642674a8ea1b44355c320af2992081cf3b75221b336abe7a7b32f09b34574::price_feed_storage::price_feed(arg0, 0x1::vector::pop_back<0x2::object::ID>(&mut arg2)));
            let v7 = if (v3 != 0 && v3 < 0xc15ee4dcdc9f93d19c9c0c28dfca2c91a650747b5cebcdba67b5191bee9290b0::ifixed::max_value()) {
                if (v4 >= arg3 * 100000000000000) {
                    v0 - 0x1::u64::min(v0, arg4) <= v6 && v6 <= 0x2::clock::timestamp_ms(arg6)
                } else {
                    false
                }
            } else {
                false
            };
            if (v7) {
                0x1::vector::push_back<u256>(&mut v1, v3);
            };
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<0x2::object::ID>(arg2);
        if (0x1::vector::is_empty<u256>(&v1) && arg5) {
            abort 1
        };
        v1
    }

    // decompiled from Move bytecode v6
}

