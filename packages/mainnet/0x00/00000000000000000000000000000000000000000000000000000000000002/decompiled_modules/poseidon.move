module 0x2::poseidon {
    public fun poseidon_bn254(arg0: &vector<u256>) : u256 {
        assert!(0x1::vector::length<u256>(arg0) > 0, 1);
        assert!(0x1::vector::length<u256>(arg0) <= 16, 2);
        let v0 = vector[];
        let v1 = 0;
        while (v1 < 0x1::vector::length<u256>(arg0)) {
            let v2 = 0x1::vector::borrow<u256>(arg0, v1);
            let v3 = &mut v0;
            assert!(*v2 < 21888242871839275222246405745257275088548364400416034343698204186575808495617, 0);
            0x1::vector::push_back<vector<u8>>(v3, 0x2::bcs::to_bytes<u256>(v2));
            v1 = v1 + 1;
        };
        let v4 = 0x2::bcs::new(poseidon_bn254_internal(&v0));
        0x2::bcs::peel_u256(&mut v4)
    }

    native fun poseidon_bn254_internal(arg0: &vector<vector<u8>>) : vector<u8>;
    // decompiled from Move bytecode v6
}

