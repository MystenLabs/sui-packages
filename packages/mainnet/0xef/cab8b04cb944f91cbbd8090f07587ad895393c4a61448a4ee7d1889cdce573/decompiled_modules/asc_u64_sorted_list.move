module 0x5658d4bf5ddcba27e4337b4262108b3ad1716643cac8c2054ac341538adc72ec::asc_u64_sorted_list {
    struct AscU64SortedList has copy, drop, store {
        list: vector<u64>,
    }

    public fun empty() : AscU64SortedList {
        AscU64SortedList{list: 0x1::vector::empty<u64>()}
    }

    public fun insert(arg0: &mut AscU64SortedList, arg1: u64) {
        let v0 = upper_bound(&arg0.list, arg1);
        if (v0 > 0 && *0x1::vector::borrow<u64>(&arg0.list, v0 - 1) == arg1) {
            return
        };
        0x1::vector::insert<u64>(&mut arg0.list, arg1, v0);
    }

    public fun remove(arg0: &mut AscU64SortedList, arg1: u64) {
        let v0 = upper_bound(&arg0.list, arg1);
        if (v0 > 0 && *0x1::vector::borrow<u64>(&arg0.list, v0 - 1) == arg1) {
            0x1::vector::remove<u64>(&mut arg0.list, v0 - 1);
        };
    }

    public fun find_nearest_smaller_or_equal_value(arg0: &AscU64SortedList, arg1: u64) : u64 {
        let v0 = upper_bound(&arg0.list, arg1);
        assert!(v0 > 0, 1);
        *0x1::vector::borrow<u64>(&arg0.list, v0 - 1)
    }

    public fun to_vector(arg0: &AscU64SortedList) : vector<u64> {
        arg0.list
    }

    public fun upper_bound(arg0: &vector<u64>, arg1: u64) : u64 {
        let v0 = 0;
        let v1 = (0x1::vector::length<u64>(arg0) as u64);
        while (v0 < v1) {
            v1 = v0 + (v1 - v0) / 2;
            if (arg1 >= *0x1::vector::borrow<u64>(arg0, v1)) {
                v0 = v1 + 1;
                continue
            };
        };
        if (v0 < 0x1::vector::length<u64>(arg0) && *0x1::vector::borrow<u64>(arg0, v0) <= arg1) {
            v0 = v0 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v6
}

