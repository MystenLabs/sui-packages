module 0x56b98fe63b386d342b1b11fe7264c02d697a73fb8a34cafac3f01dafe8c98a8a::utils {
    public(friend) fun decode_chakra_id(arg0: u128) : (u64, u64) {
        (((arg0 >> 64 & 18446744073709551615) as u64), ((arg0 >> 32 & 4294967295) as u64))
    }

    public(friend) fun encode_chakra_id(arg0: u64, arg1: u64, arg2: address) : u128 {
        let v0 = 0x2::bcs::to_bytes<address>(&arg2);
        let v1 = 0x2::hash::keccak256(&v0);
        (arg0 as u128) << 64 | (arg1 as u128) << 32 | (*0x1::vector::borrow<u8>(&v1, 31) as u128)
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

