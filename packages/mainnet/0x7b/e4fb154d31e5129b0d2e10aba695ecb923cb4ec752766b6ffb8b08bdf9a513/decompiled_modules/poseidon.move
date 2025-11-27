module 0x7be4fb154d31e5129b0d2e10aba695ecb923cb4ec752766b6ffb8b08bdf9a513::poseidon {
    public fun hash1(arg0: u256) : u256 {
        let v0 = 0x1::vector::empty<u256>();
        0x1::vector::push_back<u256>(&mut v0, arg0);
        0x2::poseidon::poseidon_bn254(&v0)
    }

    public fun hash2(arg0: u256, arg1: u256) : u256 {
        let v0 = 0x1::vector::empty<u256>();
        let v1 = &mut v0;
        0x1::vector::push_back<u256>(v1, arg0);
        0x1::vector::push_back<u256>(v1, arg1);
        0x2::poseidon::poseidon_bn254(&v0)
    }

    public fun hash3(arg0: u256, arg1: u256, arg2: u256) : u256 {
        let v0 = 0x1::vector::empty<u256>();
        let v1 = &mut v0;
        0x1::vector::push_back<u256>(v1, arg0);
        0x1::vector::push_back<u256>(v1, arg1);
        0x1::vector::push_back<u256>(v1, arg2);
        0x2::poseidon::poseidon_bn254(&v0)
    }

    // decompiled from Move bytecode v6
}

