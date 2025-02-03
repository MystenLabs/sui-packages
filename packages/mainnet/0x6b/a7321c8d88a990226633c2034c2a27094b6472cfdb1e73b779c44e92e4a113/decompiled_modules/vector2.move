module 0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::vector2 {
    public fun borrow_mut_padding<T0: copy + drop>(arg0: &mut vector<T0>, arg1: u16, arg2: T0) : &mut T0 {
        let v0 = 0x1::vector::length<T0>(arg0);
        let v1 = (arg1 as u64) + 1;
        if (v0 < v1) {
            let v2 = v1 - v0;
            while (v2 > 0) {
                0x1::vector::push_back<T0>(arg0, arg2);
                v2 = v2 - 1;
            };
        };
        0x1::vector::borrow_mut<T0>(arg0, (arg1 as u64))
    }

    public fun intersection<T0: copy>(arg0: &vector<T0>, arg1: &vector<T0>) : vector<T0> {
        let v0 = 0x1::vector::empty<T0>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<T0>(arg0)) {
            let v2 = 0x1::vector::borrow<T0>(arg0, v1);
            if (0x1::vector::contains<T0>(arg1, v2)) {
                0x1::vector::push_back<T0>(&mut v0, *v2);
            };
            v1 = v1 + 1;
        };
        v0
    }

    public fun merge<T0: drop>(arg0: &mut vector<T0>, arg1: vector<T0>) {
        while (0x1::vector::length<T0>(&arg1) > 0) {
            let v0 = 0x1::vector::pop_back<T0>(&mut arg1);
            if (!0x1::vector::contains<T0>(arg0, &v0)) {
                0x1::vector::push_back<T0>(arg0, v0);
            };
        };
    }

    public fun merge_<T0: copy>(arg0: &vector<T0>, arg1: &vector<T0>) : vector<T0> {
        let v0 = 0;
        let v1 = *arg0;
        while (v0 < 0x1::vector::length<T0>(arg1)) {
            let v2 = 0x1::vector::borrow<T0>(arg1, v0);
            if (!0x1::vector::contains<T0>(arg0, v2)) {
                0x1::vector::push_back<T0>(&mut v1, *v2);
            };
            v0 = v0 + 1;
        };
        v1
    }

    public fun push_back_unique<T0: drop>(arg0: &mut vector<T0>, arg1: T0) {
        if (!0x1::vector::contains<T0>(arg0, &arg1)) {
            0x1::vector::push_back<T0>(arg0, arg1);
        };
    }

    public fun remove_maybe<T0>(arg0: &mut vector<T0>, arg1: &T0) : 0x1::option::Option<T0> {
        let (v0, v1) = 0x1::vector::index_of<T0>(arg0, arg1);
        if (v0) {
            0x1::option::some<T0>(0x1::vector::swap_remove<T0>(arg0, v1))
        } else {
            0x1::option::none<T0>()
        }
    }

    public fun slice<T0: copy>(arg0: &vector<T0>, arg1: u64, arg2: u64) : vector<T0> {
        assert!(arg2 >= arg1, 0);
        let v0 = 0x1::vector::empty<T0>();
        while (arg1 < arg2) {
            0x1::vector::push_back<T0>(&mut v0, *0x1::vector::borrow<T0>(arg0, arg1));
            arg1 = arg1 + 1;
        };
        v0
    }

    public fun slice_mut<T0>(arg0: &mut vector<T0>, arg1: u64, arg2: u64) : vector<T0> {
        assert!(arg2 >= arg1, 0);
        let v0 = 0x1::vector::empty<T0>();
        let v1 = arg1;
        while (v1 < arg2) {
            0x1::vector::push_back<T0>(&mut v0, 0x1::vector::swap_remove<T0>(arg0, v1));
            v1 = v1 + 1;
        };
        let v2 = 0x1::vector::length<T0>(arg0) - 1;
        while (v1 < v2) {
            0x1::vector::swap<T0>(arg0, v1, v2);
            v1 = v1 + 1;
            v2 = v2 - 1;
        };
        let v3 = 0x1::vector::empty<T0>();
        let v4 = 0;
        while (v4 < 0x1::vector::length<T0>(arg0) - arg1) {
            0x1::vector::push_back<T0>(&mut v3, 0x1::vector::pop_back<T0>(arg0));
            v4 = v4 + 1;
        };
        0x1::vector::append<T0>(arg0, v3);
        v0
    }

    // decompiled from Move bytecode v6
}

