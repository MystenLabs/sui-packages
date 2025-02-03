module 0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::vector_utils {
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

