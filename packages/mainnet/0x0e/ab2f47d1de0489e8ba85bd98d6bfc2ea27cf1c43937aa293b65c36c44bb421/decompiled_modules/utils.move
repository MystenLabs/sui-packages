module 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::utils {
    public fun linked_table_key_of<T0: copy + drop + store, T1: store>(arg0: &0x2::linked_table::LinkedTable<T0, T1>, arg1: 0x1::option::Option<u64>) : 0x1::option::Option<T0> {
        let v0 = 0x2::linked_table::length<T0, T1>(arg0);
        let v1 = if (0x1::option::is_some<u64>(&arg1)) {
            *0x1::option::borrow<u64>(&arg1)
        } else {
            0
        };
        if (v1 >= v0) {
            return 0x1::option::none<T0>()
        };
        if (v1 == v0 - 1) {
            return *0x2::linked_table::back<T0, T1>(arg0)
        };
        let v2 = 0;
        let v3 = 0x2::linked_table::front<T0, T1>(arg0);
        while (v2 != v1) {
            let v4 = *0x1::option::borrow<T0>(v3);
            v3 = 0x2::linked_table::next<T0, T1>(arg0, v4);
            v2 = v2 + 1;
        };
        *v3
    }

    public fun linked_table_keys<T0: copy + drop + store, T1: store>(arg0: &0x2::linked_table::LinkedTable<T0, T1>) : vector<T0> {
        let v0 = 0x1::vector::empty<T0>();
        let v1 = 0x2::linked_table::front<T0, T1>(arg0);
        while (0x1::option::is_some<T0>(v1)) {
            let v2 = *0x1::option::borrow<T0>(v1);
            v1 = 0x2::linked_table::next<T0, T1>(arg0, v2);
            0x1::vector::push_back<T0>(&mut v0, v2);
        };
        v0
    }

    public fun linked_table_limit_keys<T0: copy + drop + store, T1: store>(arg0: &0x2::linked_table::LinkedTable<T0, T1>, arg1: 0x1::option::Option<u64>, arg2: 0x1::option::Option<u64>) : (vector<T0>, u64) {
        let v0 = 0x2::linked_table::length<T0, T1>(arg0);
        let v1 = 0x1::vector::empty<T0>();
        let v2 = if (0x1::option::is_some<u64>(&arg1)) {
            *0x1::option::borrow<u64>(&arg1)
        } else {
            v0
        };
        let v3 = linked_table_key_of<T0, T1>(arg0, arg2);
        let v4 = &v3;
        while (0x1::option::is_some<T0>(v4) && 0x1::vector::length<T0>(&v1) < v2) {
            let v5 = *0x1::option::borrow<T0>(v4);
            v4 = 0x2::linked_table::next<T0, T1>(arg0, v5);
            0x1::vector::push_back<T0>(&mut v1, v5);
        };
        (v1, v0)
    }

    // decompiled from Move bytecode v6
}

