module 0x8bf6f75160adbf561c8d755ba3e06a4d2b21719cd6bdb41b3d5f24364d73f181::utils {
    public(friend) fun decode_chakra_id(arg0: u128) : (u64, u64) {
        (((arg0 >> 64) as u64), ((arg0 & 18446744073709551615) as u64))
    }

    public(friend) fun encode_chakra_id(arg0: u64, arg1: u64) : u128 {
        ((arg0 as u128) << 64) + (arg1 as u128)
    }

    public(friend) fun pop_n<T0>(arg0: &mut vector<T0>, arg1: u64) : vector<T0> {
        let v0 = 0x1::vector::empty<T0>();
        while (arg1 > 0) {
            0x1::vector::push_back<T0>(&mut v0, 0x1::vector::pop_back<T0>(arg0));
            arg1 = arg1 - 1;
        };
        0x1::vector::reverse<T0>(&mut v0);
        v0
    }

    public(friend) fun pop_until<T0>(arg0: &mut vector<T0>, arg1: u64) : vector<T0> {
        let v0 = 0x1::vector::empty<T0>();
        while (0x1::vector::length<T0>(arg0) > arg1) {
            0x1::vector::push_back<T0>(&mut v0, 0x1::vector::pop_back<T0>(arg0));
        };
        0x1::vector::reverse<T0>(&mut v0);
        v0
    }

    // decompiled from Move bytecode v6
}

