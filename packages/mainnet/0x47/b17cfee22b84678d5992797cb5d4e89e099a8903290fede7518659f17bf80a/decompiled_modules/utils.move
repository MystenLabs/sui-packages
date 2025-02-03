module 0x47b17cfee22b84678d5992797cb5d4e89e099a8903290fede7518659f17bf80a::utils {
    public(friend) fun decode_order_id(arg0: u128) : (bool, u64, u64) {
        (arg0 >> 127 == 0, ((arg0 >> 64) as u64) & 9223372036854775807, ((arg0 & 18446744073709551615) as u64))
    }

    public(friend) fun encode_order_id(arg0: bool, arg1: u64, arg2: u64) : u128 {
        if (arg0) {
            ((arg1 as u128) << 64) + (arg2 as u128)
        } else {
            170141183460469231731687303715884105728 + ((arg1 as u128) << 64) + (arg2 as u128)
        }
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

