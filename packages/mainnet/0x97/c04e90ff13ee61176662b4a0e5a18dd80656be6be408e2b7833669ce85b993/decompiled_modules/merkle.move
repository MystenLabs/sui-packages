module 0x97c04e90ff13ee61176662b4a0e5a18dd80656be6be408e2b7833669ce85b993::merkle {
    fun bytes_le(arg0: &vector<u8>, arg1: &vector<u8>) : bool {
        let v0 = 0x1::vector::length<u8>(arg0);
        let v1 = 0x1::vector::length<u8>(arg1);
        let v2 = 0;
        while (v2 < v0 && v2 < v1) {
            let v3 = *0x1::vector::borrow<u8>(arg0, v2);
            let v4 = *0x1::vector::borrow<u8>(arg1, v2);
            if (v3 < v4) {
                return true
            };
            if (v3 > v4) {
                return false
            };
            v2 = v2 + 1;
        };
        v0 <= v1
    }

    fun concat_copy(arg0: &vector<u8>, arg1: &vector<u8>) : vector<u8> {
        let v0 = *arg0;
        0x1::vector::append<u8>(&mut v0, *arg1);
        v0
    }

    public fun leaf(arg0: address, arg1: u64) : vector<u8> {
        let v0 = 0x1::bcs::to_bytes<address>(&arg0);
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg1));
        0x2::hash::keccak256(&v0)
    }

    fun parent(arg0: &vector<u8>, arg1: &vector<u8>) : vector<u8> {
        if (bytes_le(arg0, arg1)) {
            let v1 = concat_copy(arg0, arg1);
            0x2::hash::keccak256(&v1)
        } else {
            let v2 = concat_copy(arg1, arg0);
            0x2::hash::keccak256(&v2)
        }
    }

    public fun verify(arg0: &vector<u8>, arg1: &vector<u8>, arg2: &vector<vector<u8>>) : bool {
        assert!(0x1::vector::length<u8>(arg0) == 32, 2);
        assert!(0x1::vector::length<u8>(arg1) == 32, 1);
        let v0 = *arg1;
        let v1 = 0;
        while (v1 < 0x1::vector::length<vector<u8>>(arg2)) {
            let v2 = 0x1::vector::borrow<vector<u8>>(arg2, v1);
            assert!(0x1::vector::length<u8>(v2) == 32, 3);
            let v3 = &v0;
            v0 = parent(v3, v2);
            v1 = v1 + 1;
        };
        v0 == *arg0
    }

    // decompiled from Move bytecode v6
}

