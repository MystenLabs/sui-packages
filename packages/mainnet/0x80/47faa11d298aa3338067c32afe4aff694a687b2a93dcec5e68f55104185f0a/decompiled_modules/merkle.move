module 0x8047faa11d298aa3338067c32afe4aff694a687b2a93dcec5e68f55104185f0a::merkle {
    fun compare_bytes(arg0: &vector<u8>, arg1: &vector<u8>) : bool {
        let v0 = 0x1::vector::length<u8>(arg0);
        let v1 = 0x1::vector::length<u8>(arg1);
        let v2 = if (v0 < v1) {
            v0
        } else {
            v1
        };
        let v3 = 0;
        while (v3 < v2) {
            if (*0x1::vector::borrow<u8>(arg0, v3) < *0x1::vector::borrow<u8>(arg1, v3)) {
                return true
            };
            if (*0x1::vector::borrow<u8>(arg0, v3) > *0x1::vector::borrow<u8>(arg1, v3)) {
                return false
            };
            v3 = v3 + 1;
        };
        v0 < v1
    }

    public fun verify_proof(arg0: &vector<vector<u8>>, arg1: address, arg2: &vector<u8>) : bool {
        let v0 = 0x2::bcs::to_bytes<address>(&arg1);
        let v1 = 0x2::hash::keccak256(&v0);
        let v2 = 0;
        while (v2 < 0x1::vector::length<vector<u8>>(arg0)) {
            let v3 = 0x1::vector::borrow<vector<u8>>(arg0, v2);
            let v4 = 0x1::vector::empty<u8>();
            if (compare_bytes(&v1, v3)) {
                0x1::vector::append<u8>(&mut v4, v1);
                0x1::vector::append<u8>(&mut v4, *v3);
            } else {
                0x1::vector::append<u8>(&mut v4, *v3);
                0x1::vector::append<u8>(&mut v4, v1);
            };
            v1 = 0x2::hash::keccak256(&v4);
            v2 = v2 + 1;
        };
        &v1 == arg2
    }

    // decompiled from Move bytecode v6
}

