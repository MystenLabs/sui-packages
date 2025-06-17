module 0xfd9a69094eb35f04e28641c7d4f562cd57f2b58106bd632517adc0ffb0a1932e::string_utils {
    public fun get_bridge_chain_identify(arg0: &0x1::ascii::String) : 0x1::ascii::String {
        let v0 = 0x1::ascii::as_bytes(arg0);
        let v1 = b"(";
        let (_, v3) = index_of(v0, &v1);
        let v4 = b")";
        let (_, v6) = index_of(v0, &v4);
        0x1::ascii::string(substring(v0, v3 + 1, v6))
    }

    public(friend) fun index_of(arg0: &vector<u8>, arg1: &vector<u8>) : (bool, u64) {
        let v0 = 0x1::vector::length<u8>(arg0);
        let v1 = 0x1::vector::length<u8>(arg1);
        if (v0 < v1) {
            return (false, 0)
        };
        if (v0 == 0 && v0 == v1) {
            return (true, 0)
        };
        let v2 = 0;
        while (v2 < v0) {
            let v3 = 0;
            while (v3 < v1) {
                let v4 = v2 + v3;
                if (v4 >= v0) {
                    break
                };
                if (0x1::vector::borrow<u8>(arg0, v4) != 0x1::vector::borrow<u8>(arg1, v3)) {
                    break
                };
                v3 = v3 + 1;
            };
            if (v3 == v1) {
                return (true, v2)
            };
            v2 = v2 + 1;
        };
        (false, 0)
    }

    public(friend) fun last_index_of(arg0: &vector<u8>, arg1: &vector<u8>) : (bool, u64) {
        let v0 = 0x1::vector::length<u8>(arg0);
        let v1 = 0x1::vector::length<u8>(arg1);
        if (v0 < v1) {
            return (false, 0)
        };
        if (v0 == 0 && v0 == v1) {
            return (true, 0)
        };
        let v2 = v0 - v1;
        while (v2 >= 0) {
            let v3 = 0;
            while (v3 < v1) {
                let v4 = v2 + v3;
                if (v4 >= v0) {
                    break
                };
                if (0x1::vector::borrow<u8>(arg0, v4) != 0x1::vector::borrow<u8>(arg1, v3)) {
                    break
                };
                v3 = v3 + 1;
            };
            if (v3 == v1) {
                return (true, v2)
            };
            if (v2 == 0) {
                break
            };
            v2 = v2 - 1;
        };
        (false, 0)
    }

    public(friend) fun substring(arg0: &vector<u8>, arg1: u64, arg2: u64) : vector<u8> {
        let v0 = 0x1::vector::length<u8>(arg0);
        if (arg1 >= v0) {
            return 0x1::vector::empty<u8>()
        };
        let v1 = if (arg2 > v0) {
            v0
        } else {
            arg2
        };
        let v2 = 0x1::vector::empty<u8>();
        while (arg1 < v1) {
            0x1::vector::push_back<u8>(&mut v2, *0x1::vector::borrow<u8>(arg0, arg1));
            arg1 = arg1 + 1;
        };
        v2
    }

    // decompiled from Move bytecode v6
}

