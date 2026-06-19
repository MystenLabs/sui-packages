module 0x39138b21b866d558a8d81a73ee4289f077f4500a8a78951b4dc54d8f0c8c1ba0::memo {
    public fun build(arg0: vector<u8>, arg1: bool) : vector<u8> {
        let v0 = if (arg1) {
            1
        } else {
            2
        };
        encode(v0, 0, arg0)
    }

    public fun build_with_deadline(arg0: vector<u8>, arg1: bool, arg2: u64) : vector<u8> {
        let v0 = if (arg1) {
            1
        } else {
            2
        };
        encode(v0, arg2, arg0)
    }

    public fun encode(arg0: u8, arg1: u64, arg2: vector<u8>) : vector<u8> {
        assert!(flags_are_valid(arg0), 1);
        let v0 = 0x1::vector::length<u8>(&arg2);
        assert!(v0 <= 512, 2);
        let v1 = b"";
        0x1::vector::push_back<u8>(&mut v1, 1);
        0x1::vector::push_back<u8>(&mut v1, arg0);
        0x1::vector::push_back<u8>(&mut v1, ((arg1 / 1099511627776 % 256) as u8));
        0x1::vector::push_back<u8>(&mut v1, ((arg1 / 4294967296 % 256) as u8));
        0x1::vector::push_back<u8>(&mut v1, ((arg1 / 16777216 % 256) as u8));
        0x1::vector::push_back<u8>(&mut v1, ((arg1 / 65536 % 256) as u8));
        0x1::vector::push_back<u8>(&mut v1, ((arg1 / 256 % 256) as u8));
        0x1::vector::push_back<u8>(&mut v1, ((arg1 % 256) as u8));
        0x1::vector::push_back<u8>(&mut v1, ((v0 / 256 % 256) as u8));
        0x1::vector::push_back<u8>(&mut v1, ((v0 % 256) as u8));
        0x1::vector::append<u8>(&mut v1, arg2);
        v1
    }

    fun flags_are_valid(arg0: u8) : bool {
        arg0 != 0 && arg0 <= 1 | 2
    }

    public fun is_expired(arg0: &vector<u8>, arg1: u64) : bool {
        if (!is_valid(arg0)) {
            false
        } else {
            let v1 = read_u48_be(arg0, 2);
            v1 != 0 && arg1 > v1
        }
    }

    public fun is_strict(arg0: &vector<u8>) : bool {
        is_valid(arg0) && *0x1::vector::borrow<u8>(arg0, 1) & 1 == 1
    }

    public fun is_valid(arg0: &vector<u8>) : bool {
        let v0 = 0x1::vector::length<u8>(arg0);
        if (v0 < 10 || v0 > 10 + 512) {
            return false
        };
        if (*0x1::vector::borrow<u8>(arg0, 0) != 1) {
            return false
        };
        if (!flags_are_valid(*0x1::vector::borrow<u8>(arg0, 1))) {
            return false
        };
        let v1 = read_u16_be(arg0, 8);
        v1 <= 512 && v0 == 10 + v1
    }

    public fun max_payload() : u64 {
        512
    }

    public fun payload(arg0: &vector<u8>) : vector<u8> {
        let v0 = b"";
        let (v1, v2) = if (is_valid(arg0)) {
            (10, 10 + read_u16_be(arg0, 8))
        } else {
            (0, 0x1::vector::length<u8>(arg0))
        };
        while (v1 < v2) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(arg0, v1));
            v1 = v1 + 1;
        };
        v0
    }

    fun read_u16_be(arg0: &vector<u8>, arg1: u64) : u64 {
        (*0x1::vector::borrow<u8>(arg0, arg1) as u64) * 256 + (*0x1::vector::borrow<u8>(arg0, arg1 + 1) as u64)
    }

    fun read_u48_be(arg0: &vector<u8>, arg1: u64) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 6) {
            let v2 = v0 * 256;
            v0 = v2 + (*0x1::vector::borrow<u8>(arg0, arg1 + v1) as u64);
            v1 = v1 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v7
}

