module 0x1bf5a8ce77050d8052549d743e16b469f15aa6b81b752b78b6ebb65179665f5a::asc_u64_sorted_list {
    struct AscU64SortedList has copy, drop, store {
        list: vector<u64>,
        set: 0x2::vec_set::VecSet<u64>,
    }

    public fun empty() : AscU64SortedList {
        AscU64SortedList{
            list : 0x1::vector::empty<u64>(),
            set  : 0x2::vec_set::empty<u64>(),
        }
    }

    public fun insert(arg0: &mut AscU64SortedList, arg1: u64) {
        if (0x2::vec_set::contains<u64>(&arg0.set, &arg1)) {
            return
        };
        0x2::vec_set::insert<u64>(&mut arg0.set, arg1);
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(&arg0.list)) {
            if (arg1 < *0x1::vector::borrow<u64>(&arg0.list, v0)) {
                break
            };
            v0 = v0 + 1;
        };
        0x1::vector::insert<u64>(&mut arg0.list, arg1, v0);
    }

    public fun remove(arg0: &mut AscU64SortedList, arg1: u64) {
        if (!0x2::vec_set::contains<u64>(&arg0.set, &arg1)) {
            return
        };
        0x2::vec_set::remove<u64>(&mut arg0.set, &arg1);
        let v0 = 0;
        let v1 = 0x1::vector::length<u64>(&arg0.list);
        while (v0 < v1) {
            if (arg1 == *0x1::vector::borrow<u64>(&arg0.list, v0)) {
                break
            };
            v0 = v0 + 1;
        };
        if (v0 < v1) {
            0x1::vector::remove<u64>(&mut arg0.list, v0);
        };
    }

    public fun find_nearest_smaller_or_equal_value(arg0: &AscU64SortedList, arg1: u64) : u64 {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(&arg0.list)) {
            if (arg1 < *0x1::vector::borrow<u64>(&arg0.list, v0)) {
                break
            };
            v0 = v0 + 1;
        };
        if (v0 == 0) {
            0
        } else {
            *0x1::vector::borrow<u64>(&arg0.list, v0 - 1)
        }
    }

    // decompiled from Move bytecode v6
}

