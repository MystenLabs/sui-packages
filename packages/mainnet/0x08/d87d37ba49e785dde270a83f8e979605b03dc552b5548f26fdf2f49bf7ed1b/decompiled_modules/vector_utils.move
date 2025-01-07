module 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::vector_utils {
    public fun slice<T0: copy>(arg0: &vector<T0>, arg1: u64, arg2: u64) : vector<T0> {
        assert!(arg2 > arg1, 1);
        assert!(arg1 < 0x1::vector::length<T0>(arg0), 0);
        assert!(arg2 <= 0x1::vector::length<T0>(arg0), 1);
        let v0 = 0x1::vector::empty<T0>();
        while (arg1 < arg2) {
            0x1::vector::push_back<T0>(&mut v0, *0x1::vector::borrow<T0>(arg0, arg1));
            arg1 = arg1 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v6
}

