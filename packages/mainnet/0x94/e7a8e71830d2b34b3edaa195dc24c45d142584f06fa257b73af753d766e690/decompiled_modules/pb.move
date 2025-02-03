module 0x94e7a8e71830d2b34b3edaa195dc24c45d142584f06fa257b73af753d766e690::pb {
    struct Buffer has drop {
        idx: u64,
        b: vector<u8>,
    }

    public fun create(arg0: vector<u8>) : Buffer {
        Buffer{
            idx : 0,
            b   : arg0,
        }
    }

    public fun dec_bytes(arg0: &mut Buffer) : vector<u8> {
        let v0 = dec_varint(arg0);
        let v1 = arg0.idx + v0;
        assert!(v1 <= 0x1::vector::length<u8>(&arg0.b), 5002);
        let v2 = 0x1::vector::empty<u8>();
        while (arg0.idx < v1) {
            0x1::vector::push_back<u8>(&mut v2, *0x1::vector::borrow<u8>(&arg0.b, arg0.idx));
            arg0.idx = arg0.idx + 1;
        };
        v2
    }

    public fun dec_key(arg0: &mut Buffer) : (u64, u8) {
        let v0 = dec_varint(arg0);
        (v0 / 8, ((v0 % 8) as u8))
    }

    public fun dec_varint(arg0: &mut Buffer) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 10) {
            let v2 = 0x1::vector::borrow<u8>(&arg0.b, arg0.idx + (v1 as u64));
            let v3 = v0 | ((*v2 & 127) as u64) << v1 * 7;
            v0 = v3;
            if (*v2 < 128) {
                arg0.idx = arg0.idx + (v1 as u64) + 1;
                return v3
            };
            v1 = v1 + 1;
        };
        assert!(v1 < 10, 5001);
        v0
    }

    public fun from_bytes(arg0: vector<u8>) : Buffer {
        Buffer{
            idx : 0,
            b   : arg0,
        }
    }

    public fun has_more(arg0: &Buffer) : bool {
        arg0.idx < 0x1::vector::length<u8>(&arg0.b)
    }

    public fun to_u128(arg0: vector<u8>) : u128 {
        let v0 = 0x1::vector::length<u8>(&arg0);
        assert!(v0 <= 16, 5004);
        let v1 = 0;
        let v2 = 0;
        while ((v2 as u64) < v0) {
            v1 = v1 + ((*0x1::vector::borrow<u8>(&arg0, v0 - 1 - (v2 as u64)) as u128) << v2 * 8);
            v2 = v2 + 1;
        };
        v1
    }

    public fun to_u64(arg0: &vector<u8>) : u64 {
        let v0 = 0x1::vector::length<u8>(arg0);
        assert!(v0 <= 8, 5003);
        let v1 = 0;
        let v2 = 0;
        while ((v2 as u64) < v0) {
            v1 = v1 + ((*0x1::vector::borrow<u8>(arg0, v0 - 1 - (v2 as u64)) as u64) << v2 * 8);
            v2 = v2 + 1;
        };
        v1
    }

    // decompiled from Move bytecode v6
}

