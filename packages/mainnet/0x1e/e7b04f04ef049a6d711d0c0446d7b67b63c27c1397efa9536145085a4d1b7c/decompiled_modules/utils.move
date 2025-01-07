module 0x1ee7b04f04ef049a6d711d0c0446d7b67b63c27c1397efa9536145085a4d1b7c::utils {
    public fun calculate_power(arg0: u128, arg1: u16) : u256 {
        let v0 = 1;
        let v1 = (arg0 as u256);
        assert!(v1 | (arg1 as u256) != 0, 1);
        if (v1 == 0) {
            return 0
        };
        while (arg1 != 0) {
            if (arg1 & 1 == 1) {
                v0 = v0 * v1;
            };
            v1 = v1 * v1;
            arg1 = arg1 >> 1;
        };
        v0
    }

    public fun destructive_reverse_append<T0: drop>(arg0: &mut vector<T0>, arg1: vector<T0>) {
        while (!0x1::vector::is_empty<T0>(&arg1)) {
            0x1::vector::push_back<T0>(arg0, 0x1::vector::pop_back<T0>(&mut arg1));
        };
    }

    public fun vector_flatten_concat<T0: copy + drop>(arg0: &mut vector<T0>, arg1: vector<vector<T0>>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<vector<T0>>(&arg1)) {
            0x1::vector::append<T0>(arg0, *0x1::vector::borrow<vector<T0>>(&arg1, v0));
            v0 = v0 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

