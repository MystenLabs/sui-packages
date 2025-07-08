module 0x2::poseidon {
    public fun poseidon_bn254(arg0: &vector<u256>) : u256 {
        let v0 = 0x1::vector::length<u256>(arg0);
        let v1 = vector[];
        let v2 = 0;
        assert!(v0 > 0, 1);
        while (v2 < v0) {
            assert!(*0x1::vector::borrow<u256>(arg0, v2) < 21888242871839275222246405745257275088548364400416034343698204186575808495617, 0);
            0x1::vector::push_back<vector<u8>>(&mut v1, 0x2::bcs::to_bytes<u256>(0x1::vector::borrow<u256>(arg0, v2)));
            v2 = v2 + 1;
        };
        let v3 = 0x2::bcs::new(poseidon_bn254_internal(&v1));
        0x2::bcs::peel_u256(&mut v3)
    }

    native fun poseidon_bn254_internal(arg0: &vector<vector<u8>>) : vector<u8>;
    // decompiled from Move bytecode v6
}

