module 0xabc9f7cac2aedb27463e71637859072889389d7a74cdd5a1561248715a4d978d::mm_guard {
    fun assert_accounts(arg0: &vector<u64>, arg1: u64) {
        assert!(0x1::vector::length<u64>(arg0) < 50, 2);
        assert!(!0x1::vector::is_empty<u64>(arg0), 4);
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(arg0)) {
            assert!(*0x1::vector::borrow<u64>(arg0, v0) == arg1, 3);
            v0 = v0 + 1;
        };
    }

    public fun assert_makers<T0>(arg0: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::SessionHotPotato<T0>, arg1: bool, arg2: u64, arg3: u64) {
        let (v0, v1) = bounds(arg1, arg2, arg3);
        let (_, v3) = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::orderbook::inspect_orders(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::orderbook<T0>(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::clearing_house<T0>(arg0)), !arg1, v0, v1, 50);
        let v4 = v3;
        assert!(0x1::vector::length<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::orderbook::Order>(&v4) < 50, 2);
        let v5 = vector[];
        let v6 = 0;
        while (v6 < 0x1::vector::length<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::orderbook::Order>(&v4)) {
            let (v7, _, _, _, _, _) = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::orderbook::as_parts(0x1::vector::borrow<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::orderbook::Order>(&v4, v6));
            0x1::vector::push_back<u64>(&mut v5, v7);
            v6 = v6 + 1;
        };
        assert_accounts(&v5, arg3);
    }

    fun bounds(arg0: bool, arg1: u64, arg2: u64) : (u64, u64) {
        let v0 = if (arg1 > 0) {
            if (arg1 < 9223372036854775808) {
                arg2 > 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 1);
        if (arg0) {
            (18446744073709551615, arg1 - 1)
        } else {
            (0, arg1 + 1)
        }
    }

    // decompiled from Move bytecode v7
}

