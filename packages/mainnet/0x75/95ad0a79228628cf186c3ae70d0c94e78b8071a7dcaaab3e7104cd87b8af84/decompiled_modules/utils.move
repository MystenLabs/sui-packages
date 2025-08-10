module 0x7595ad0a79228628cf186c3ae70d0c94e78b8071a7dcaaab3e7104cd87b8af84::utils {
    public fun bytes_eq(arg0: &vector<u8>, arg1: &vector<u8>) : bool {
        if (0x1::vector::length<u8>(arg0) != 0x1::vector::length<u8>(arg1)) {
            return false
        };
        let v0 = 0;
        while (v0 < 0x1::vector::length<u8>(arg0)) {
            if (*0x1::vector::borrow<u8>(arg0, v0) != *0x1::vector::borrow<u8>(arg1, v0)) {
                return false
            };
            v0 = v0 + 1;
        };
        true
    }

    public(friend) fun bytes_less_than(arg0: &vector<u8>, arg1: &vector<u8>) : bool {
        let v0 = 0x1::vector::length<u8>(arg0);
        let v1 = 0x1::vector::length<u8>(arg1);
        let v2 = if (v0 < v1) {
            v0
        } else {
            v1
        };
        let v3 = 0;
        while (v3 < v2) {
            let v4 = *0x1::vector::borrow<u8>(arg0, v3);
            let v5 = *0x1::vector::borrow<u8>(arg1, v3);
            if (v4 < v5) {
                return true
            };
            if (v4 > v5) {
                return false
            };
            v3 = v3 + 1;
        };
        v0 < v1
    }

    public(friend) fun concat_bytes(arg0: &vector<u8>, arg1: &vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(arg0)) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(arg0, v1));
            v1 = v1 + 1;
        };
        let v2 = 0;
        while (v2 < 0x1::vector::length<u8>(arg1)) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(arg1, v2));
            v2 = v2 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v6
}

