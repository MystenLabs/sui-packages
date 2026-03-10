module 0xb5ae92de5c71a1d15ac6e5ed681e6e1cfb7ea82563ed753fc629efca0e73d86e::poseidon {
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

    // decompiled from Move bytecode v6
}

