module 0x463e33c826abc181393a5cc01d6f113d70b41dcc87f3b527cd72029985a5f0e1::utils {
    public(friend) fun bytes_to_base_u32(arg0: &vector<u8>, arg1: u8, arg2: u64) : vector<u32> {
        assert!(arg1 >= 1 && arg1 <= 31, 0);
        assert!(arg2 * (arg1 as u64) <= 8 * (0x1::vector::length<u8>(arg0) as u64), 1);
        let v0 = vector[];
        let v1 = 0;
        let v2 = 0;
        let v3 = 0;
        while (0x1::vector::length<u32>(&v0) < arg2) {
            while (v2 < arg1 && v3 < 0x1::vector::length<u8>(arg0)) {
                let v4 = v1 << 8;
                v1 = v4 | (*0x1::vector::borrow<u8>(arg0, v3) as u64);
                v2 = v2 + 8;
                v3 = v3 + 1;
            };
            let v5 = v2 - arg1;
            v2 = v5;
            0x1::vector::push_back<u32>(&mut v0, ((v1 >> v5 & (1 << arg1) - 1) as u32));
        };
        v0
    }

    public(friend) fun extend_from(arg0: &mut vector<u8>, arg1: &vector<u8>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u8>(arg1)) {
            0x1::vector::push_back<u8>(arg0, *0x1::vector::borrow<u8>(arg1, v0));
            v0 = v0 + 1;
        };
    }

    public(friend) fun extend_from_slice(arg0: &mut vector<u8>, arg1: &vector<u8>, arg2: u64, arg3: u64) {
        let v0 = 0;
        while (v0 < arg3) {
            0x1::vector::push_back<u8>(arg0, *0x1::vector::borrow<u8>(arg1, arg2 + v0));
            v0 = v0 + 1;
        };
    }

    public(friend) fun extend_from_slice_n16(arg0: &mut vector<u8>, arg1: &vector<u8>, arg2: u64) {
        0x1::vector::push_back<u8>(arg0, *0x1::vector::borrow<u8>(arg1, arg2));
        0x1::vector::push_back<u8>(arg0, *0x1::vector::borrow<u8>(arg1, arg2 + 1));
        0x1::vector::push_back<u8>(arg0, *0x1::vector::borrow<u8>(arg1, arg2 + 2));
        0x1::vector::push_back<u8>(arg0, *0x1::vector::borrow<u8>(arg1, arg2 + 3));
        0x1::vector::push_back<u8>(arg0, *0x1::vector::borrow<u8>(arg1, arg2 + 4));
        0x1::vector::push_back<u8>(arg0, *0x1::vector::borrow<u8>(arg1, arg2 + 5));
        0x1::vector::push_back<u8>(arg0, *0x1::vector::borrow<u8>(arg1, arg2 + 6));
        0x1::vector::push_back<u8>(arg0, *0x1::vector::borrow<u8>(arg1, arg2 + 7));
        0x1::vector::push_back<u8>(arg0, *0x1::vector::borrow<u8>(arg1, arg2 + 8));
        0x1::vector::push_back<u8>(arg0, *0x1::vector::borrow<u8>(arg1, arg2 + 9));
        0x1::vector::push_back<u8>(arg0, *0x1::vector::borrow<u8>(arg1, arg2 + 10));
        0x1::vector::push_back<u8>(arg0, *0x1::vector::borrow<u8>(arg1, arg2 + 11));
        0x1::vector::push_back<u8>(arg0, *0x1::vector::borrow<u8>(arg1, arg2 + 12));
        0x1::vector::push_back<u8>(arg0, *0x1::vector::borrow<u8>(arg1, arg2 + 13));
        0x1::vector::push_back<u8>(arg0, *0x1::vector::borrow<u8>(arg1, arg2 + 14));
        0x1::vector::push_back<u8>(arg0, *0x1::vector::borrow<u8>(arg1, arg2 + 15));
    }

    public(friend) fun push_u32_be(arg0: &mut vector<u8>, arg1: u32) {
        0x1::vector::push_back<u8>(arg0, ((arg1 >> 24 & 255) as u8));
        0x1::vector::push_back<u8>(arg0, ((arg1 >> 16 & 255) as u8));
        0x1::vector::push_back<u8>(arg0, ((arg1 >> 8 & 255) as u8));
        0x1::vector::push_back<u8>(arg0, ((arg1 & 255) as u8));
    }

    public(friend) fun slice(arg0: &vector<u8>, arg1: u64, arg2: u64) : vector<u8> {
        let v0 = b"";
        let v1 = 0;
        while (v1 < arg2) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(arg0, arg1 + v1));
            v1 = v1 + 1;
        };
        v0
    }

    public(friend) fun slice_n16(arg0: &vector<u8>, arg1: u64) : vector<u8> {
        let v0 = b"";
        0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(arg0, arg1));
        0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(arg0, arg1 + 1));
        0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(arg0, arg1 + 2));
        0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(arg0, arg1 + 3));
        0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(arg0, arg1 + 4));
        0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(arg0, arg1 + 5));
        0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(arg0, arg1 + 6));
        0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(arg0, arg1 + 7));
        0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(arg0, arg1 + 8));
        0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(arg0, arg1 + 9));
        0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(arg0, arg1 + 10));
        0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(arg0, arg1 + 11));
        0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(arg0, arg1 + 12));
        0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(arg0, arg1 + 13));
        0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(arg0, arg1 + 14));
        0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(arg0, arg1 + 15));
        v0
    }

    // decompiled from Move bytecode v7
}

