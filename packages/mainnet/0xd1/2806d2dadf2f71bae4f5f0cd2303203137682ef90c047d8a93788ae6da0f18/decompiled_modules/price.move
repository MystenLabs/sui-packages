module 0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price {
    public fun average_price_and_twap_price_from_sources_(arg0: &0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::PriceFeedStorage, arg1: &0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::config::Config, arg2: vector<u16>, arg3: u64, arg4: bool, arg5: &0x2::clock::Clock) : (u128, u128) {
        0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::config::assert_package_version(arg1);
        if (0x1::vector::length<u16>(&arg2) == 0) {
            if (arg4) {
                abort 13835060988744826881
            };
            return (0, 0)
        };
        let v0 = 0x2::clock::timestamp_ms(arg5);
        let v1 = 0;
        let v2 = 0;
        let v3 = 0;
        let v4 = 0;
        0x1::vector::reverse<u16>(&mut arg2);
        let v5 = 0;
        while (v5 < 0x1::vector::length<u16>(&arg2)) {
            let v6 = 0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::price_feed(arg0, 0x1::vector::pop_back<u16>(&mut arg2));
            let v7 = 0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed::price(v6);
            let v8 = 0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed::twap_price(v6);
            if (v0 - 0x1::u64::min(v0, arg3) <= 0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed::timestamp_ms(v6)) {
                if (v7 != 0) {
                    v1 = v1 + (v7 as u256);
                    v3 = v3 + 1;
                };
                if (v8 != 0) {
                    v2 = v2 + (v8 as u256);
                    v4 = v4 + 1;
                };
            };
            v5 = v5 + 1;
        };
        0x1::vector::destroy_empty<u16>(arg2);
        if ((v3 == 0 || v4 == 0) && arg4) {
            abort 13835342592570687491
        };
        (((v1 / (0x1::u64::max(v3, 1) as u256)) as u128), ((v2 / (0x1::u64::max(v4, 1) as u256)) as u128))
    }

    public fun average_reciprocal_price_and_twap_price_from_sources_(arg0: &0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::PriceFeedStorage, arg1: &0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::config::Config, arg2: vector<u16>, arg3: u64, arg4: bool, arg5: &0x2::clock::Clock) : (u128, u128) {
        let (v0, v1) = average_price_and_twap_price_from_sources_(arg0, arg1, arg2, arg3, arg4, arg5);
        let v2 = if (v0 == 0) {
            0
        } else {
            ((1000000000000000000000000000000000000 / (v0 as u256)) as u128)
        };
        let v3 = if (v1 == 0) {
            0
        } else {
            ((1000000000000000000000000000000000000 / (v1 as u256)) as u128)
        };
        (v2, v3)
    }

    public fun average_reciprocal_twap_price_from_sources_(arg0: &0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::PriceFeedStorage, arg1: &0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::config::Config, arg2: vector<u16>, arg3: u64, arg4: bool, arg5: &0x2::clock::Clock) : u128 {
        let v0 = average_twap_price_from_sources_(arg0, arg1, arg2, arg3, arg4, arg5);
        if (v0 == 0) {
            return 0
        };
        ((1000000000000000000000000000000000000 / (v0 as u256)) as u128)
    }

    public fun average_twap_price_from_sources_(arg0: &0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::PriceFeedStorage, arg1: &0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::config::Config, arg2: vector<u16>, arg3: u64, arg4: bool, arg5: &0x2::clock::Clock) : u128 {
        0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::config::assert_package_version(arg1);
        if (0x1::vector::length<u16>(&arg2) == 0) {
            if (arg4) {
                abort 13835060821241102337
            };
            return 0
        };
        let v0 = 0x2::clock::timestamp_ms(arg5);
        let v1 = 0;
        let v2 = 0;
        0x1::vector::reverse<u16>(&mut arg2);
        let v3 = 0;
        while (v3 < 0x1::vector::length<u16>(&arg2)) {
            let v4 = 0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::price_feed(arg0, 0x1::vector::pop_back<u16>(&mut arg2));
            let v5 = 0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed::twap_price(v4);
            if (v5 != 0 && v0 - 0x1::u64::min(v0, arg3) <= 0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed::timestamp_ms(v4)) {
                v1 = v1 + (v5 as u256);
                v2 = v2 + 1;
            };
            v3 = v3 + 1;
        };
        0x1::vector::destroy_empty<u16>(arg2);
        if (v2 == 0 && arg4) {
            abort 13835342386412257283
        };
        ((v1 / (0x1::u64::max(v2, 1) as u256)) as u128)
    }

    public fun median_of(arg0: vector<u128>) : u128 {
        let v0 = 0x1::vector::length<u128>(&arg0);
        if (v0 == 0) {
            abort 13835343653427609603
        };
        if (v0 == 1) {
            *0x1::vector::borrow<u128>(&arg0, 0)
        } else if (v0 == 2) {
            0x1::u128::max(*0x1::vector::borrow<u128>(&arg0, 0), *0x1::vector::borrow<u128>(&arg0, 1))
        } else {
            assert!(v0 == 3, 13835625167059156997);
            let v2 = *0x1::vector::borrow<u128>(&arg0, 0);
            let v3 = *0x1::vector::borrow<u128>(&arg0, 1);
            0x1::u128::max(0x1::u128::min(0x1::u128::max(v2, v3), *0x1::vector::borrow<u128>(&arg0, 2)), 0x1::u128::min(v2, v3))
        }
    }

    public fun median_price_and_twap_price_from_sources_(arg0: &0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::PriceFeedStorage, arg1: &0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::config::Config, arg2: vector<u16>, arg3: u64, arg4: &0x2::clock::Clock) : (u128, u128) {
        0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::config::assert_package_version(arg1);
        if (0x1::vector::length<u16>(&arg2) == 0) {
            abort 13835060494823587841
        };
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let v1 = 0;
        let v2 = 0;
        let v3 = 0;
        let v4 = 0;
        let v5 = 0;
        let v6 = 0;
        let v7 = 0;
        let v8 = 0;
        0x1::vector::reverse<u16>(&mut arg2);
        let v9 = 0;
        while (v9 < 0x1::vector::length<u16>(&arg2)) {
            let v10 = 0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::price_feed(arg0, 0x1::vector::pop_back<u16>(&mut arg2));
            let v11 = 0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed::price(v10);
            let v12 = 0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed::twap_price(v10);
            if (v0 - 0x1::u64::min(v0, arg3) <= 0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed::timestamp_ms(v10)) {
                if (v11 != 0) {
                    if (v1 == 0) {
                        v4 = v11;
                    } else if (v1 == 1) {
                        v3 = v11;
                    } else {
                        assert!(v1 == 2, 13835623547856486405);
                        v2 = v11;
                    };
                    v1 = v1 + 1;
                };
                if (v12 != 0) {
                    if (v5 == 0) {
                        v8 = v12;
                    } else if (v5 == 1) {
                        v7 = v12;
                    } else {
                        assert!(v5 == 2, 13835623603691061253);
                        v6 = v12;
                    };
                    v5 = v5 + 1;
                };
            };
            v9 = v9 + 1;
        };
        0x1::vector::destroy_empty<u16>(arg2);
        if (v1 == 0 || v5 == 0) {
            abort 13835342158778990595
        };
        let v13 = if (v1 == 1) {
            v4
        } else if (v1 == 2) {
            0x1::u128::max(v4, v3)
        } else {
            0x1::u128::max(0x1::u128::min(0x1::u128::max(v4, v3), v2), 0x1::u128::min(v4, v3))
        };
        let v14 = if (v5 == 1) {
            v8
        } else if (v5 == 2) {
            0x1::u128::max(v8, v7)
        } else {
            0x1::u128::max(0x1::u128::min(0x1::u128::max(v8, v7), v6), 0x1::u128::min(v8, v7))
        };
        (v13, v14)
    }

    public fun median_price_from_sources_(arg0: &0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::PriceFeedStorage, arg1: &0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::config::Config, arg2: vector<u16>, arg3: u64, arg4: &0x2::clock::Clock) : u128 {
        median_of(valid_prices_from_sources(arg0, arg1, arg2, arg3, true, arg4))
    }

    public fun median_twap_price_from_sources_(arg0: &0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::PriceFeedStorage, arg1: &0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::config::Config, arg2: vector<u16>, arg3: u64, arg4: &0x2::clock::Clock) : u128 {
        0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::config::assert_package_version(arg1);
        if (0x1::vector::length<u16>(&arg2) == 0) {
            abort 13835060254305419265
        };
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let v1 = 0;
        let v2 = 0;
        let v3 = 0;
        let v4 = 0;
        0x1::vector::reverse<u16>(&mut arg2);
        let v5 = 0;
        while (v5 < 0x1::vector::length<u16>(&arg2)) {
            let v6 = 0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::price_feed(arg0, 0x1::vector::pop_back<u16>(&mut arg2));
            let v7 = 0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed::twap_price(v6);
            if (v7 != 0 && v0 - 0x1::u64::min(v0, arg3) <= 0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed::timestamp_ms(v6)) {
                if (v1 == 0) {
                    v4 = v7;
                } else if (v1 == 1) {
                    v3 = v7;
                } else {
                    assert!(v1 == 2, 13835623290158448645);
                    v2 = v7;
                };
                v1 = v1 + 1;
            };
            v5 = v5 + 1;
        };
        0x1::vector::destroy_empty<u16>(arg2);
        if (v1 == 0) {
            abort 13835341845246377987
        };
        if (v1 == 1) {
            v4
        } else if (v1 == 2) {
            0x1::u128::max(v4, v3)
        } else {
            0x1::u128::max(0x1::u128::min(0x1::u128::max(v4, v3), v2), 0x1::u128::min(v4, v3))
        }
    }

    public fun newest_price_(arg0: &0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::PriceFeedStorage, arg1: &0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::config::Config, arg2: u64, arg3: bool, arg4: &0x2::clock::Clock) : u128 {
        0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::config::assert_package_version(arg1);
        if (0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::size(arg0) == 0) {
            if (arg3) {
                abort 13835061800493645825
            };
            return 0
        };
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let v1 = 18446744073709551615;
        let v2 = v1;
        let v3 = 0;
        let v4 = 0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::feeds(arg0);
        let v5 = 0;
        while (v5 < 0x1::vector::length<0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed::PriceFeed>(v4)) {
            let (v6, v7) = 0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed::price_and_timestamp_ms(0x1::vector::borrow<0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed::PriceFeed>(v4, v5));
            if (v0 - 0x1::u64::min(v0, arg2) <= v7) {
                if (v1 == 18446744073709551615 || v7 > v1) {
                    v2 = v7;
                    v3 = v6;
                };
            };
            v5 = v5 + 1;
        };
        if (v2 == 18446744073709551615 && arg3) {
            abort 13835343331305062403
        };
        v3
    }

    public fun newest_price_and_twap_price_(arg0: &0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::PriceFeedStorage, arg1: &0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::config::Config, arg2: u64, arg3: bool, arg4: &0x2::clock::Clock) : (u128, u128) {
        0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::config::assert_package_version(arg1);
        if (0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::size(arg0) == 0) {
            if (arg3) {
                abort 13835062049601748993
            };
            return (0, 0)
        };
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let v1 = 18446744073709551615;
        let v2 = v1;
        let v3 = 0;
        let v4 = 0;
        let v5 = 0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::feeds(arg0);
        let v6 = 0;
        while (v6 < 0x1::vector::length<0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed::PriceFeed>(v5)) {
            let v7 = 0x1::vector::borrow<0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed::PriceFeed>(v5, v6);
            let v8 = 0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed::timestamp_ms(v7);
            if (v0 - 0x1::u64::min(v0, arg2) <= v8) {
                if (v1 == 18446744073709551615 || v8 > v1) {
                    v2 = v8;
                    v3 = 0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed::twap_price(v7);
                    v4 = 0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed::price(v7);
                };
            };
            v6 = v6 + 1;
        };
        if (v2 == 18446744073709551615 && arg3) {
            abort 13835343589003100163
        };
        (v4, v3)
    }

    public fun newest_price_and_twap_price_from_sources_(arg0: &0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::PriceFeedStorage, arg1: &0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::config::Config, arg2: vector<u16>, arg3: u64, arg4: bool, arg5: &0x2::clock::Clock) : (u128, u128) {
        0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::config::assert_package_version(arg1);
        if (0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::size(arg0) == 0) {
            if (arg4) {
                abort 13835059867758362625
            };
            return (0, 0)
        };
        let v0 = 0x2::clock::timestamp_ms(arg5);
        let v1 = 18446744073709551615;
        let v2 = v1;
        let v3 = 0;
        let v4 = 0;
        0x1::vector::reverse<u16>(&mut arg2);
        let v5 = 0;
        while (v5 < 0x1::vector::length<u16>(&arg2)) {
            let v6 = 0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::price_feed(arg0, 0x1::vector::pop_back<u16>(&mut arg2));
            let v7 = 0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed::timestamp_ms(v6);
            if (v0 - 0x1::u64::min(v0, arg3) <= v7) {
                if (v1 == 18446744073709551615 || v7 > v1) {
                    v2 = v7;
                    v3 = 0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed::twap_price(v6);
                    v4 = 0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed::price(v6);
                };
            };
            v5 = v5 + 1;
        };
        0x1::vector::destroy_empty<u16>(arg2);
        if (v2 == 18446744073709551615 && arg4) {
            abort 13835341428634550275
        };
        (v4, v3)
    }

    public fun newest_price_from_sources_(arg0: &0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::PriceFeedStorage, arg1: &0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::config::Config, arg2: vector<u16>, arg3: u64, arg4: bool, arg5: &0x2::clock::Clock) : u128 {
        0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::config::assert_package_version(arg1);
        if (0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::size(arg0) == 0) {
            if (arg4) {
                abort 13835059433966665729
            };
            return 0
        };
        let v0 = 0x2::clock::timestamp_ms(arg5);
        let v1 = 18446744073709551615;
        let v2 = v1;
        let v3 = 0;
        0x1::vector::reverse<u16>(&mut arg2);
        let v4 = 0;
        while (v4 < 0x1::vector::length<u16>(&arg2)) {
            let (v5, v6) = 0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed::price_and_timestamp_ms(0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::price_feed(arg0, 0x1::vector::pop_back<u16>(&mut arg2)));
            if (v0 - 0x1::u64::min(v0, arg3) <= v6) {
                if (v1 == 18446744073709551615 || v6 > v1) {
                    v2 = v6;
                    v3 = v5;
                };
            };
            v4 = v4 + 1;
        };
        0x1::vector::destroy_empty<u16>(arg2);
        if (v2 == 18446744073709551615 && arg4) {
            abort 13835340981957951491
        };
        v3
    }

    public fun newest_twap_price_(arg0: &0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::PriceFeedStorage, arg1: &0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::config::Config, arg2: u64, arg3: bool, arg4: &0x2::clock::Clock) : u128 {
        0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::config::assert_package_version(arg1);
        if (0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::size(arg0) == 0) {
            if (arg3) {
                abort 13835061925047697409
            };
            return 0
        };
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let v1 = 18446744073709551615;
        let v2 = v1;
        let v3 = 0;
        let v4 = 0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::feeds(arg0);
        let v5 = 0;
        while (v5 < 0x1::vector::length<0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed::PriceFeed>(v4)) {
            let v6 = 0x1::vector::borrow<0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed::PriceFeed>(v4, v5);
            let v7 = 0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed::timestamp_ms(v6);
            if (v0 - 0x1::u64::min(v0, arg2) <= v7) {
                if (v1 == 18446744073709551615 || v7 > v1) {
                    v2 = v7;
                    v3 = 0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed::twap_price(v6);
                };
            };
            v5 = v5 + 1;
        };
        if (v2 == 18446744073709551615 && arg3) {
            abort 13835343455859113987
        };
        v3
    }

    public fun newest_twap_price_from_sources_(arg0: &0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::PriceFeedStorage, arg1: &0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::config::Config, arg2: vector<u16>, arg3: u64, arg4: bool, arg5: &0x2::clock::Clock) : u128 {
        0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::config::assert_package_version(arg1);
        if (0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::size(arg0) == 0) {
            if (arg4) {
                abort 13835059648715030529
            };
            return 0
        };
        let v0 = 0x2::clock::timestamp_ms(arg5);
        let v1 = 18446744073709551615;
        let v2 = v1;
        let v3 = 0;
        0x1::vector::reverse<u16>(&mut arg2);
        let v4 = 0;
        while (v4 < 0x1::vector::length<u16>(&arg2)) {
            let v5 = 0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::price_feed(arg0, 0x1::vector::pop_back<u16>(&mut arg2));
            let v6 = 0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed::timestamp_ms(v5);
            if (v0 - 0x1::u64::min(v0, arg3) <= v6) {
                if (v1 == 18446744073709551615 || v6 > v1) {
                    v2 = v6;
                    v3 = 0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed::twap_price(v5);
                };
            };
            v4 = v4 + 1;
        };
        0x1::vector::destroy_empty<u16>(arg2);
        if (v2 == 18446744073709551615 && arg4) {
            abort 13835341201001283587
        };
        v3
    }

    public fun valid_prices_(arg0: &0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::PriceFeedStorage, arg1: &0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::config::Config, arg2: u64, arg3: bool, arg4: &0x2::clock::Clock) : vector<u128> {
        0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::config::assert_package_version(arg1);
        if (0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::size(arg0) == 0) {
            if (arg3) {
                abort 13835061422536523777
            };
            return vector[]
        };
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let v1 = vector[];
        let v2 = 0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::feeds(arg0);
        let v3 = 0;
        while (v3 < 0x1::vector::length<0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed::PriceFeed>(v2)) {
            let (v4, v5) = 0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed::price_and_timestamp_ms(0x1::vector::borrow<0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed::PriceFeed>(v2, v3));
            if (v4 != 0 && v0 - 0x1::u64::min(v0, arg2) <= v5) {
                0x1::vector::push_back<u128>(&mut v1, v4);
            };
            v3 = v3 + 1;
        };
        if (0x1::vector::is_empty<u128>(&v1) && arg3) {
            abort 13835342949052973059
        };
        v1
    }

    public fun valid_prices_and_twap_prices_(arg0: &0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::PriceFeedStorage, arg1: &0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::config::Config, arg2: u64, arg3: bool, arg4: &0x2::clock::Clock) : (vector<u128>, vector<u128>) {
        0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::config::assert_package_version(arg1);
        if (0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::size(arg0) == 0) {
            if (arg3) {
                abort 13835061667349659649
            };
            return (vector[], vector[])
        };
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let v1 = vector[];
        let v2 = vector[];
        let v3 = 0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::feeds(arg0);
        let v4 = 0;
        while (v4 < 0x1::vector::length<0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed::PriceFeed>(v3)) {
            let (v5, v6, v7) = 0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed::price_timestamp_ms_twap_price(0x1::vector::borrow<0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed::PriceFeed>(v3, v4));
            if (v0 - 0x1::u64::min(v0, arg2) <= v6) {
                if (v5 != 0) {
                    0x1::vector::push_back<u128>(&mut v1, v5);
                };
                if (v7 != 0) {
                    0x1::vector::push_back<u128>(&mut v2, v7);
                };
            };
            v4 = v4 + 1;
        };
        if ((0x1::vector::is_empty<u128>(&v1) || 0x1::vector::is_empty<u128>(&v2)) && arg3) {
            abort 13835343206751010819
        };
        (v1, v2)
    }

    public fun valid_prices_and_twap_prices_from_sources(arg0: &0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::PriceFeedStorage, arg1: &0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::config::Config, arg2: vector<u16>, arg3: u64, arg4: bool, arg5: &0x2::clock::Clock) : (vector<u128>, vector<u128>) {
        0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::config::assert_package_version(arg1);
        if (0x1::vector::length<u16>(&arg2) == 0) {
            if (arg4) {
                abort 13835059197743464449
            };
            return (vector[], vector[])
        };
        let v0 = 0x2::clock::timestamp_ms(arg5);
        let v1 = vector[];
        let v2 = vector[];
        0x1::vector::reverse<u16>(&mut arg2);
        let v3 = 0;
        while (v3 < 0x1::vector::length<u16>(&arg2)) {
            let v4 = 0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::price_feed(arg0, 0x1::vector::pop_back<u16>(&mut arg2));
            let v5 = 0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed::price(v4);
            let v6 = 0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed::twap_price(v4);
            if (v0 - 0x1::u64::min(v0, arg3) <= 0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed::timestamp_ms(v4)) {
                if (v5 != 0) {
                    0x1::vector::push_back<u128>(&mut v1, v5);
                };
                if (v6 != 0) {
                    0x1::vector::push_back<u128>(&mut v2, v6);
                };
            };
            v3 = v3 + 1;
        };
        0x1::vector::destroy_empty<u16>(arg2);
        if ((0x1::vector::is_empty<u128>(&v1) || 0x1::vector::is_empty<u128>(&v2)) && arg4) {
            abort 13835340767209586691
        };
        (v1, v2)
    }

    public fun valid_prices_from_sources(arg0: &0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::PriceFeedStorage, arg1: &0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::config::Config, arg2: vector<u16>, arg3: u64, arg4: bool, arg5: &0x2::clock::Clock) : vector<u128> {
        0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::config::assert_package_version(arg1);
        if (0x1::vector::length<u16>(&arg2) == 0) {
            if (arg4) {
                abort 13835058763951767553
            };
            return vector[]
        };
        let v0 = 0x2::clock::timestamp_ms(arg5);
        let v1 = vector[];
        0x1::vector::reverse<u16>(&mut arg2);
        let v2 = 0;
        while (v2 < 0x1::vector::length<u16>(&arg2)) {
            let (v3, v4) = 0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed::price_and_timestamp_ms(0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::price_feed(arg0, 0x1::vector::pop_back<u16>(&mut arg2)));
            if (v3 != 0 && v0 - 0x1::u64::min(v0, arg3) <= v4) {
                0x1::vector::push_back<u128>(&mut v1, v3);
            };
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<u16>(arg2);
        if (0x1::vector::is_empty<u128>(&v1) && arg4) {
            abort 13835340320532987907
        };
        v1
    }

    public fun valid_twap_prices_(arg0: &0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::PriceFeedStorage, arg1: &0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::config::Config, arg2: u64, arg3: bool, arg4: &0x2::clock::Clock) : vector<u128> {
        0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::config::assert_package_version(arg1);
        if (0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::size(arg0) == 0) {
            if (arg3) {
                abort 13835061542795608065
            };
            return vector[]
        };
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let v1 = vector[];
        let v2 = 0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::feeds(arg0);
        let v3 = 0;
        while (v3 < 0x1::vector::length<0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed::PriceFeed>(v2)) {
            let v4 = 0x1::vector::borrow<0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed::PriceFeed>(v2, v3);
            let v5 = 0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed::twap_price(v4);
            if (v5 != 0 && v0 - 0x1::u64::min(v0, arg2) <= 0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed::timestamp_ms(v4)) {
                0x1::vector::push_back<u128>(&mut v1, v5);
            };
            v3 = v3 + 1;
        };
        if (0x1::vector::is_empty<u128>(&v1) && arg3) {
            abort 13835343073607024643
        };
        v1
    }

    public fun valid_twap_prices_from_sources(arg0: &0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::PriceFeedStorage, arg1: &0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::config::Config, arg2: vector<u16>, arg3: u64, arg4: bool, arg5: &0x2::clock::Clock) : vector<u128> {
        0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::config::assert_package_version(arg1);
        if (0x1::vector::length<u16>(&arg2) == 0) {
            if (arg4) {
                abort 13835058987290066945
            };
            return vector[]
        };
        let v0 = 0x2::clock::timestamp_ms(arg5);
        let v1 = vector[];
        0x1::vector::reverse<u16>(&mut arg2);
        let v2 = 0;
        while (v2 < 0x1::vector::length<u16>(&arg2)) {
            let v3 = 0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::price_feed(arg0, 0x1::vector::pop_back<u16>(&mut arg2));
            let v4 = 0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed::twap_price(v3);
            if (v4 != 0 && v0 - 0x1::u64::min(v0, arg3) <= 0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed::timestamp_ms(v3)) {
                0x1::vector::push_back<u128>(&mut v1, v4);
            };
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<u16>(arg2);
        if (0x1::vector::is_empty<u128>(&v1) && arg4) {
            abort 13835340539576320003
        };
        v1
    }

    // decompiled from Move bytecode v7
}

