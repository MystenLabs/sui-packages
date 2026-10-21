module 0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price {
    public fun average_price_and_twap_price_from_sources_(arg0: &0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed_storage::PriceFeedStorage, arg1: &0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::config::Config, arg2: vector<u16>, arg3: u64, arg4: bool, arg5: &0x2::clock::Clock) : (u128, u128) {
        0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::config::assert_package_version(arg1);
        if (0x1::vector::length<u16>(&arg2) == 0) {
            if (arg4) {
                abort 13835059841988558849
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
            let v6 = 0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed_storage::price_feed(arg0, 0x1::vector::pop_back<u16>(&mut arg2));
            let v7 = 0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed::price(v6);
            let v8 = 0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed::twap_price(v6);
            if (v0 - 0x1::u64::min(v0, arg3) <= 0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed::timestamp_ms(v6)) {
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
            abort 13835341432929517571
        };
        (((v1 / (0x1::u64::max(v3, 1) as u256)) as u128), ((v2 / (0x1::u64::max(v4, 1) as u256)) as u128))
    }

    public fun average_reciprocal_price_and_twap_price_from_sources_(arg0: &0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed_storage::PriceFeedStorage, arg1: &0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::config::Config, arg2: vector<u16>, arg3: u64, arg4: bool, arg5: &0x2::clock::Clock) : (u128, u128) {
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

    public fun average_reciprocal_twap_price_from_sources_(arg0: &0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed_storage::PriceFeedStorage, arg1: &0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::config::Config, arg2: vector<u16>, arg3: u64, arg4: bool, arg5: &0x2::clock::Clock) : u128 {
        let v0 = average_twap_price_from_sources_(arg0, arg1, arg2, arg3, arg4, arg5);
        if (v0 == 0) {
            return 0
        };
        ((1000000000000000000000000000000000000 / (v0 as u256)) as u128)
    }

    public fun average_twap_price_from_sources_(arg0: &0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed_storage::PriceFeedStorage, arg1: &0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::config::Config, arg2: vector<u16>, arg3: u64, arg4: bool, arg5: &0x2::clock::Clock) : u128 {
        0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::config::assert_package_version(arg1);
        if (0x1::vector::length<u16>(&arg2) == 0) {
            if (arg4) {
                abort 13835059683074768897
            };
            return 0
        };
        let v0 = 0x2::clock::timestamp_ms(arg5);
        let v1 = 0;
        let v2 = 0;
        0x1::vector::reverse<u16>(&mut arg2);
        let v3 = 0;
        while (v3 < 0x1::vector::length<u16>(&arg2)) {
            let v4 = 0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed_storage::price_feed(arg0, 0x1::vector::pop_back<u16>(&mut arg2));
            let v5 = 0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed::twap_price(v4);
            if (v5 != 0 && v0 - 0x1::u64::min(v0, arg3) <= 0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed::timestamp_ms(v4)) {
                v1 = v1 + (v5 as u256);
                v2 = v2 + 1;
            };
            v3 = v3 + 1;
        };
        0x1::vector::destroy_empty<u16>(arg2);
        if (v2 == 0 && arg4) {
            abort 13835341252540891139
        };
        ((v1 / (0x1::u64::max(v2, 1) as u256)) as u128)
    }

    public fun median_of(arg0: vector<u128>) : u128 {
        let v0 = 0x1::vector::length<u128>(&arg0);
        if (v0 == 0) {
            abort 13835342536736112643
        };
        if (v0 == 1) {
            *0x1::vector::borrow<u128>(&arg0, 0)
        } else if (v0 == 2) {
            middle_of_two(*0x1::vector::borrow<u128>(&arg0, 0), *0x1::vector::borrow<u128>(&arg0, 1))
        } else {
            assert!(v0 == 3, 13835624037482758149);
            let v2 = *0x1::vector::borrow<u128>(&arg0, 0);
            let v3 = *0x1::vector::borrow<u128>(&arg0, 1);
            0x1::u128::max(0x1::u128::min(0x1::u128::max(v2, v3), *0x1::vector::borrow<u128>(&arg0, 2)), 0x1::u128::min(v2, v3))
        }
    }

    public fun median_price_and_twap_price_from_sources_(arg0: &0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed_storage::PriceFeedStorage, arg1: &0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::config::Config, arg2: vector<u16>, arg3: u64, arg4: &0x2::clock::Clock) : (u128, u128) {
        0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::config::assert_package_version(arg1);
        if (0x1::vector::length<u16>(&arg2) == 0) {
            abort 13835059360952221697
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
            let v10 = 0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed_storage::price_feed(arg0, 0x1::vector::pop_back<u16>(&mut arg2));
            let v11 = 0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed::price(v10);
            let v12 = 0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed::twap_price(v10);
            if (v0 - 0x1::u64::min(v0, arg3) <= 0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed::timestamp_ms(v10)) {
                if (v11 != 0) {
                    if (v1 == 0) {
                        v4 = v11;
                    } else if (v1 == 1) {
                        v3 = v11;
                    } else {
                        assert!(v1 == 2, 13835622401100218373);
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
                        assert!(v5 == 2, 13835622448344858629);
                        v6 = v12;
                    };
                    v5 = v5 + 1;
                };
            };
            v9 = v9 + 1;
        };
        0x1::vector::destroy_empty<u16>(arg2);
        if (v1 == 0 || v5 == 0) {
            abort 13835341003432787971
        };
        let v13 = if (v1 == 1) {
            v4
        } else if (v1 == 2) {
            middle_of_two(v4, v3)
        } else {
            0x1::u128::max(0x1::u128::min(0x1::u128::max(v4, v3), v2), 0x1::u128::min(v4, v3))
        };
        let v14 = if (v5 == 1) {
            v8
        } else if (v5 == 2) {
            middle_of_two(v8, v7)
        } else {
            0x1::u128::max(0x1::u128::min(0x1::u128::max(v8, v7), v6), 0x1::u128::min(v8, v7))
        };
        (v13, v14)
    }

    public fun median_price_from_sources_(arg0: &0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed_storage::PriceFeedStorage, arg1: &0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::config::Config, arg2: vector<u16>, arg3: u64, arg4: &0x2::clock::Clock) : u128 {
        median_of(valid_prices_from_sources(arg0, arg1, arg2, arg3, true, arg4))
    }

    public fun median_twap_price_from_sources_(arg0: &0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed_storage::PriceFeedStorage, arg1: &0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::config::Config, arg2: vector<u16>, arg3: u64, arg4: &0x2::clock::Clock) : u128 {
        0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::config::assert_package_version(arg1);
        if (0x1::vector::length<u16>(&arg2) == 0) {
            abort 13835059141908889601
        };
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let v1 = 0;
        let v2 = 0;
        let v3 = 0;
        let v4 = 0;
        0x1::vector::reverse<u16>(&mut arg2);
        let v5 = 0;
        while (v5 < 0x1::vector::length<u16>(&arg2)) {
            let v6 = 0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed_storage::price_feed(arg0, 0x1::vector::pop_back<u16>(&mut arg2));
            let v7 = 0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed::twap_price(v6);
            if (v7 != 0 && v0 - 0x1::u64::min(v0, arg3) <= 0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed::timestamp_ms(v6)) {
                if (v1 == 0) {
                    v4 = v7;
                } else if (v1 == 1) {
                    v3 = v7;
                } else {
                    assert!(v1 == 2, 13835622186351853573);
                    v2 = v7;
                };
                v1 = v1 + 1;
            };
            v5 = v5 + 1;
        };
        0x1::vector::destroy_empty<u16>(arg2);
        if (v1 == 0) {
            abort 13835340737144815619
        };
        if (v1 == 1) {
            v4
        } else if (v1 == 2) {
            middle_of_two(v4, v3)
        } else {
            0x1::u128::max(0x1::u128::min(0x1::u128::max(v4, v3), v2), 0x1::u128::min(v4, v3))
        }
    }

    fun middle_of_two(arg0: u128, arg1: u128) : u128 {
        ((((arg0 as u256) + (arg1 as u256)) / 2) as u128)
    }

    public fun newest_price_(arg0: &0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed_storage::PriceFeedStorage, arg1: &0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::config::Config, arg2: u64, arg3: bool, arg4: &0x2::clock::Clock) : u128 {
        0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::config::assert_package_version(arg1);
        if (0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed_storage::size(arg0) == 0) {
            if (arg3) {
                abort 13835060645147443201
            };
            return 0
        };
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let v1 = 18446744073709551615;
        let v2 = v1;
        let v3 = 0;
        let v4 = 0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed_storage::feeds(arg0);
        let v5 = 0;
        while (v5 < 0x1::vector::length<0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed::PriceFeed>(v4)) {
            let (v6, v7) = 0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed::price_and_timestamp_ms(0x1::vector::borrow<0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed::PriceFeed>(v4, v5));
            if (v0 - 0x1::u64::min(v0, arg2) <= v7) {
                if (v1 == 18446744073709551615 || v7 > v1) {
                    v2 = v7;
                    v3 = v6;
                };
            };
            v5 = v5 + 1;
        };
        if (v2 == 18446744073709551615 && arg3) {
            abort 13835342210318598147
        };
        v3
    }

    public fun newest_price_and_twap_price_(arg0: &0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed_storage::PriceFeedStorage, arg1: &0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::config::Config, arg2: u64, arg3: bool, arg4: &0x2::clock::Clock) : (u128, u128) {
        0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::config::assert_package_version(arg1);
        if (0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed_storage::size(arg0) == 0) {
            if (arg3) {
                abort 13835060937205219329
            };
            return (0, 0)
        };
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let v1 = 18446744073709551615;
        let v2 = v1;
        let v3 = 0;
        let v4 = 0;
        let v5 = 0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed_storage::feeds(arg0);
        let v6 = 0;
        while (v6 < 0x1::vector::length<0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed::PriceFeed>(v5)) {
            let v7 = 0x1::vector::borrow<0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed::PriceFeed>(v5, v6);
            let v8 = 0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed::timestamp_ms(v7);
            if (v0 - 0x1::u64::min(v0, arg2) <= v8) {
                if (v1 == 18446744073709551615 || v8 > v1) {
                    v2 = v8;
                    v3 = 0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed::twap_price(v7);
                    v4 = 0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed::price(v7);
                };
            };
            v6 = v6 + 1;
        };
        if (v2 == 18446744073709551615 && arg3) {
            abort 13835342510966308867
        };
        (v4, v3)
    }

    public fun newest_price_and_twap_price_from_sources_(arg0: &0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed_storage::PriceFeedStorage, arg1: &0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::config::Config, arg2: vector<u16>, arg3: u64, arg4: bool, arg5: &0x2::clock::Clock) : (u128, u128) {
        0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::config::assert_package_version(arg1);
        if (0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed_storage::size(arg0) == 0) {
            if (arg4) {
                abort 13835058914275622913
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
            let v6 = 0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed_storage::price_feed(arg0, 0x1::vector::pop_back<u16>(&mut arg2));
            let v7 = 0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed::timestamp_ms(v6);
            if (v0 - 0x1::u64::min(v0, arg3) <= v7) {
                if (v1 == 18446744073709551615 || v7 > v1) {
                    v2 = v7;
                    v3 = 0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed::twap_price(v6);
                    v4 = 0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed::price(v6);
                };
            };
            v5 = v5 + 1;
        };
        0x1::vector::destroy_empty<u16>(arg2);
        if (v2 == 18446744073709551615 && arg4) {
            abort 13835340492331679747
        };
        (v4, v3)
    }

    public fun newest_price_from_sources_(arg0: &0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed_storage::PriceFeedStorage, arg1: &0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::config::Config, arg2: vector<u16>, arg3: u64, arg4: bool, arg5: &0x2::clock::Clock) : u128 {
        0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::config::assert_package_version(arg1);
        if (0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed_storage::size(arg0) == 0) {
            if (arg4) {
                abort 13835058609332944897
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
            let (v5, v6) = 0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed::price_and_timestamp_ms(0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed_storage::price_feed(arg0, 0x1::vector::pop_back<u16>(&mut arg2)));
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
            abort 13835340174504099843
        };
        v3
    }

    public fun newest_twap_price_(arg0: &0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed_storage::PriceFeedStorage, arg1: &0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::config::Config, arg2: u64, arg3: bool, arg4: &0x2::clock::Clock) : u128 {
        0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::config::assert_package_version(arg1);
        if (0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed_storage::size(arg0) == 0) {
            if (arg3) {
                abort 13835060791176331265
            };
            return 0
        };
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let v1 = 18446744073709551615;
        let v2 = v1;
        let v3 = 0;
        let v4 = 0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed_storage::feeds(arg0);
        let v5 = 0;
        while (v5 < 0x1::vector::length<0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed::PriceFeed>(v4)) {
            let v6 = 0x1::vector::borrow<0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed::PriceFeed>(v4, v5);
            let v7 = 0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed::timestamp_ms(v6);
            if (v0 - 0x1::u64::min(v0, arg2) <= v7) {
                if (v1 == 18446744073709551615 || v7 > v1) {
                    v2 = v7;
                    v3 = 0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed::twap_price(v6);
                };
            };
            v5 = v5 + 1;
        };
        if (v2 == 18446744073709551615 && arg3) {
            abort 13835342356347486211
        };
        v3
    }

    public fun newest_twap_price_from_sources_(arg0: &0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed_storage::PriceFeedStorage, arg1: &0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::config::Config, arg2: vector<u16>, arg3: u64, arg4: bool, arg5: &0x2::clock::Clock) : u128 {
        0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::config::assert_package_version(arg1);
        if (0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed_storage::size(arg0) == 0) {
            if (arg4) {
                abort 13835058759656800257
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
            let v5 = 0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed_storage::price_feed(arg0, 0x1::vector::pop_back<u16>(&mut arg2));
            let v6 = 0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed::timestamp_ms(v5);
            if (v0 - 0x1::u64::min(v0, arg3) <= v6) {
                if (v1 == 18446744073709551615 || v6 > v1) {
                    v2 = v6;
                    v3 = 0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed::twap_price(v5);
                };
            };
            v4 = v4 + 1;
        };
        0x1::vector::destroy_empty<u16>(arg2);
        if (v2 == 18446744073709551615 && arg4) {
            abort 13835340329122922499
        };
        v3
    }

    public fun valid_prices_(arg0: &0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed_storage::PriceFeedStorage, arg1: &0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::config::Config, arg2: u64, arg3: bool, arg4: &0x2::clock::Clock) : vector<u128> {
        0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::config::assert_package_version(arg1);
        if (0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed_storage::size(arg0) == 0) {
            if (arg3) {
                abort 13835060250010451969
            };
            return vector[]
        };
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let v1 = vector[];
        let v2 = 0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed_storage::feeds(arg0);
        let v3 = 0;
        while (v3 < 0x1::vector::length<0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed::PriceFeed>(v2)) {
            let (v4, v5) = 0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed::price_and_timestamp_ms(0x1::vector::borrow<0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed::PriceFeed>(v2, v3));
            if (v4 != 0 && v0 - 0x1::u64::min(v0, arg2) <= v5) {
                0x1::vector::push_back<u128>(&mut v1, v4);
            };
            v3 = v3 + 1;
        };
        if (0x1::vector::is_empty<u128>(&v1) && arg3) {
            abort 13835341793706770435
        };
        v1
    }

    public fun valid_prices_and_twap_prices_(arg0: &0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed_storage::PriceFeedStorage, arg1: &0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::config::Config, arg2: u64, arg3: bool, arg4: &0x2::clock::Clock) : (vector<u128>, vector<u128>) {
        0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::config::assert_package_version(arg1);
        if (0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed_storage::size(arg0) == 0) {
            if (arg3) {
                abort 13835060503413522433
            };
            return (vector[], vector[])
        };
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let v1 = vector[];
        let v2 = vector[];
        let v3 = 0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed_storage::feeds(arg0);
        let v4 = 0;
        while (v4 < 0x1::vector::length<0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed::PriceFeed>(v3)) {
            let (v5, v6, v7) = 0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed::price_timestamp_ms_twap_price(0x1::vector::borrow<0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed::PriceFeed>(v3, v4));
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
            abort 13835342064289710083
        };
        (v1, v2)
    }

    public fun valid_prices_and_twap_prices_from_sources(arg0: &0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed_storage::PriceFeedStorage, arg1: &0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::config::Config, arg2: vector<u16>, arg3: u64, arg4: bool, arg5: &0x2::clock::Clock) : (vector<u128>, vector<u128>) {
        0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::config::assert_package_version(arg1);
        if (0x1::vector::length<u16>(&arg2) == 0) {
            if (arg4) {
                abort 13835058467599024129
            };
            return (vector[], vector[])
        };
        let v0 = 0x2::clock::timestamp_ms(arg5);
        let v1 = vector[];
        let v2 = vector[];
        0x1::vector::reverse<u16>(&mut arg2);
        let v3 = 0;
        while (v3 < 0x1::vector::length<u16>(&arg2)) {
            let v4 = 0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed_storage::price_feed(arg0, 0x1::vector::pop_back<u16>(&mut arg2));
            let v5 = 0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed::price(v4);
            let v6 = 0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed::twap_price(v4);
            if (v0 - 0x1::u64::min(v0, arg3) <= 0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed::timestamp_ms(v4)) {
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
            abort 13835340024180244483
        };
        (v1, v2)
    }

    public fun valid_prices_from_sources(arg0: &0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed_storage::PriceFeedStorage, arg1: &0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::config::Config, arg2: vector<u16>, arg3: u64, arg4: bool, arg5: &0x2::clock::Clock) : vector<u128> {
        0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::config::assert_package_version(arg1);
        if (0x1::vector::length<u16>(&arg2) == 0) {
            if (arg4) {
                abort 13835058201311051777
            };
            return vector[]
        };
        let v0 = 0x2::clock::timestamp_ms(arg5);
        let v1 = vector[];
        0x1::vector::reverse<u16>(&mut arg2);
        let v2 = 0;
        while (v2 < 0x1::vector::length<u16>(&arg2)) {
            let (v3, v4) = 0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed::price_and_timestamp_ms(0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed_storage::price_feed(arg0, 0x1::vector::pop_back<u16>(&mut arg2)));
            if (v3 != 0 && v0 - 0x1::u64::min(v0, arg3) <= v4) {
                0x1::vector::push_back<u128>(&mut v1, v3);
            };
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<u16>(arg2);
        if (0x1::vector::is_empty<u128>(&v1) && arg4) {
            abort 13835339745007370243
        };
        v1
    }

    public fun valid_twap_prices_(arg0: &0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed_storage::PriceFeedStorage, arg1: &0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::config::Config, arg2: u64, arg3: bool, arg4: &0x2::clock::Clock) : vector<u128> {
        0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::config::assert_package_version(arg1);
        if (0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed_storage::size(arg0) == 0) {
            if (arg3) {
                abort 13835060374564503553
            };
            return vector[]
        };
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let v1 = vector[];
        let v2 = 0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed_storage::feeds(arg0);
        let v3 = 0;
        while (v3 < 0x1::vector::length<0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed::PriceFeed>(v2)) {
            let v4 = 0x1::vector::borrow<0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed::PriceFeed>(v2, v3);
            let v5 = 0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed::twap_price(v4);
            if (v5 != 0 && v0 - 0x1::u64::min(v0, arg2) <= 0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed::timestamp_ms(v4)) {
                0x1::vector::push_back<u128>(&mut v1, v5);
            };
            v3 = v3 + 1;
        };
        if (0x1::vector::is_empty<u128>(&v1) && arg3) {
            abort 13835341922555789315
        };
        v1
    }

    public fun valid_twap_prices_from_sources(arg0: &0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed_storage::PriceFeedStorage, arg1: &0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::config::Config, arg2: vector<u16>, arg3: u64, arg4: bool, arg5: &0x2::clock::Clock) : vector<u128> {
        0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::config::assert_package_version(arg1);
        if (0x1::vector::length<u16>(&arg2) == 0) {
            if (arg4) {
                abort 13835058330160070657
            };
            return vector[]
        };
        let v0 = 0x2::clock::timestamp_ms(arg5);
        let v1 = vector[];
        0x1::vector::reverse<u16>(&mut arg2);
        let v2 = 0;
        while (v2 < 0x1::vector::length<u16>(&arg2)) {
            let v3 = 0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed_storage::price_feed(arg0, 0x1::vector::pop_back<u16>(&mut arg2));
            let v4 = 0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed::twap_price(v3);
            if (v4 != 0 && v0 - 0x1::u64::min(v0, arg3) <= 0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed::timestamp_ms(v3)) {
                0x1::vector::push_back<u128>(&mut v1, v4);
            };
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<u16>(arg2);
        if (0x1::vector::is_empty<u128>(&v1) && arg4) {
            abort 13835339882446323715
        };
        v1
    }

    // decompiled from Move bytecode v7
}

