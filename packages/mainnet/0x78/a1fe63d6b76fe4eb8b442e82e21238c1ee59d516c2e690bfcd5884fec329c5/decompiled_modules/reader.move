module 0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::reader {
    struct Reader has copy, drop {
        bytes: vector<u8>,
        cursor: u64,
    }

    public fun be_bytes_to_u128(arg0: &vector<u8>) : u128 {
        assert!(0x1::vector::length<u8>(arg0) <= 16, 1);
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(arg0)) {
            let v2 = v0 << 8;
            v0 = v2 | (*0x1::vector::borrow<u8>(arg0, v1) as u128);
            v1 = v1 + 1;
        };
        v0
    }

    public fun cursor(arg0: &Reader) : u64 {
        arg0.cursor
    }

    public fun is_empty(arg0: &Reader) : bool {
        arg0.cursor == 0x1::vector::length<u8>(&arg0.bytes)
    }

    public fun new(arg0: vector<u8>) : Reader {
        Reader{
            bytes  : arg0,
            cursor : 0,
        }
    }

    public fun read_btc_varint(arg0: &mut Reader) : u64 {
        let v0 = read_u8(arg0);
        if (v0 < 253) {
            (v0 as u64)
        } else if (v0 == 253) {
            (read_u16_le(arg0) as u64)
        } else {
            assert!(v0 == 254, 1);
            (read_u32_le(arg0) as u64)
        }
    }

    public fun read_bytes(arg0: &mut Reader, arg1: u64) : vector<u8> {
        assert!(arg0.cursor + arg1 <= 0x1::vector::length<u8>(&arg0.bytes), 0);
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0;
        while (v1 < arg1) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(&arg0.bytes, arg0.cursor + v1));
            v1 = v1 + 1;
        };
        arg0.cursor = arg0.cursor + arg1;
        v0
    }

    public fun read_shortvec_len(arg0: &mut Reader) : u64 {
        let v0 = 0;
        let v1 = 0;
        loop {
            let v2 = read_u8(arg0);
            v0 = v0 | ((v2 & 127) as u64) << v1;
            if (v2 & 128 == 0) {
                break
            };
            v1 = v1 + 7;
            assert!(v1 <= 14, 1);
        };
        v0
    }

    public fun read_u16_le(arg0: &mut Reader) : u16 {
        let v0 = read_u8(arg0);
        (v0 as u16) | (read_u8(arg0) as u16) << 8
    }

    public fun read_u32_le(arg0: &mut Reader) : u32 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 4) {
            v0 = v0 | (read_u8(arg0) as u32) << v1 * 8;
            v1 = v1 + 1;
        };
        v0
    }

    public fun read_u64_le(arg0: &mut Reader) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 8) {
            v0 = v0 | (read_u8(arg0) as u64) << v1 * 8;
            v1 = v1 + 1;
        };
        v0
    }

    public fun read_u8(arg0: &mut Reader) : u8 {
        assert!(arg0.cursor < 0x1::vector::length<u8>(&arg0.bytes), 0);
        arg0.cursor = arg0.cursor + 1;
        *0x1::vector::borrow<u8>(&arg0.bytes, arg0.cursor)
    }

    public fun remaining(arg0: &Reader) : u64 {
        0x1::vector::length<u8>(&arg0.bytes) - arg0.cursor
    }

    public fun skip(arg0: &mut Reader, arg1: u64) {
        assert!(arg0.cursor + arg1 <= 0x1::vector::length<u8>(&arg0.bytes), 0);
        arg0.cursor = arg0.cursor + arg1;
    }

    public fun slice(arg0: &vector<u8>, arg1: u64, arg2: u64) : vector<u8> {
        assert!(arg1 + arg2 <= 0x1::vector::length<u8>(arg0), 0);
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0;
        while (v1 < arg2) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(arg0, arg1 + v1));
            v1 = v1 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v6
}

