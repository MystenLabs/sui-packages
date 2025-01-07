module 0xe2e210143e1f8646c1ec4d63e56e75f035ee98e8ffdb868ac6ed5b0e9f57b7a2::obutils {
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

    public fun vec_toids(arg0: &vector<address>) : vector<0x2::object::ID> {
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        let v1 = 0x1::vector::length<address>(arg0);
        while (v1 > 0) {
            v1 = v1 - 1;
            0x1::vector::push_back<0x2::object::ID>(&mut v0, 0x2::object::id_from_address(*0x1::vector::borrow<address>(arg0, v1)));
        };
        v0
    }

    // decompiled from Move bytecode v6
}

