module 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::apportionment_queue {
    struct ApportionmentQueue<T0> has drop {
        entries: vector<Entry<T0>>,
    }

    struct Entry<T0> has drop {
        priority: 0x1::uq64_64::UQ64_64,
        tie_breaker: u64,
        value: T0,
    }

    fun bubble_down<T0>(arg0: &mut vector<Entry<T0>>) {
        let v0 = 0x1::vector::length<Entry<T0>>(arg0);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = v1 * 2 + 1;
            let v3 = v2 + 1;
            let v4 = v1;
            if (v2 < v0 && higher_priority_than<T0>(0x1::vector::borrow<Entry<T0>>(arg0, v2), 0x1::vector::borrow<Entry<T0>>(arg0, v1))) {
                v4 = v2;
            };
            if (v3 < v0 && higher_priority_than<T0>(0x1::vector::borrow<Entry<T0>>(arg0, v3), 0x1::vector::borrow<Entry<T0>>(arg0, v4))) {
                v4 = v3;
            };
            if (v4 == v1) {
                break
            };
            0x1::vector::swap<Entry<T0>>(arg0, v4, v1);
            v1 = v4;
        };
    }

    fun bubble_up<T0>(arg0: &mut vector<Entry<T0>>) {
        let v0 = 0x1::vector::length<Entry<T0>>(arg0) - 1;
        while (v0 > 0) {
            v0 = (v0 - 1) / 2;
            if (higher_priority_than<T0>(0x1::vector::borrow<Entry<T0>>(arg0, v0), 0x1::vector::borrow<Entry<T0>>(arg0, v0))) {
                0x1::vector::swap<Entry<T0>>(arg0, v0, v0);
            } else {
                break
            };
        };
    }

    fun higher_priority_than<T0>(arg0: &Entry<T0>, arg1: &Entry<T0>) : bool {
        0x1::uq64_64::gt(arg0.priority, arg1.priority) || arg0.priority == arg1.priority && arg0.tie_breaker > arg1.tie_breaker
    }

    public fun insert<T0>(arg0: &mut ApportionmentQueue<T0>, arg1: 0x1::uq64_64::UQ64_64, arg2: u64, arg3: T0) {
        let v0 = Entry<T0>{
            priority    : arg1,
            tie_breaker : arg2,
            value       : arg3,
        };
        0x1::vector::push_back<Entry<T0>>(&mut arg0.entries, v0);
        let v1 = &mut arg0.entries;
        bubble_up<T0>(v1);
    }

    public fun new<T0>() : ApportionmentQueue<T0> {
        ApportionmentQueue<T0>{entries: 0x1::vector::empty<Entry<T0>>()}
    }

    public fun pop_max<T0>(arg0: &mut ApportionmentQueue<T0>) : (0x1::uq64_64::UQ64_64, u64, T0) {
        assert!(0x1::vector::length<Entry<T0>>(&arg0.entries) > 0, 0);
        let Entry {
            priority    : v0,
            tie_breaker : v1,
            value       : v2,
        } = 0x1::vector::swap_remove<Entry<T0>>(&mut arg0.entries, 0);
        let v3 = &mut arg0.entries;
        bubble_down<T0>(v3);
        (v0, v1, v2)
    }

    // decompiled from Move bytecode v6
}

