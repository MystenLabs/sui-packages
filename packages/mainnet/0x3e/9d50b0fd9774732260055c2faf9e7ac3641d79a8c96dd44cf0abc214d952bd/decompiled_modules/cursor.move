module 0x3e9d50b0fd9774732260055c2faf9e7ac3641d79a8c96dd44cf0abc214d952bd::cursor {
    struct Cursor has drop {
        bytes: vector<u8>,
        offset: u64,
    }

    public fun length(arg0: &mut Cursor) : u64 {
        let v0 = 0;
        let v1 = 0;
        let v2 = 0;
        loop {
            assert!(v0 <= 4, 2);
            let v3 = (read_u8(arg0) as u64);
            v2 = v2 | (v3 & 127) << v1;
            v0 = v0 + 1;
            if (v3 & 128 == 0) {
                break
            };
            v1 = v1 + 7;
        };
        v2
    }

    public fun boolean(arg0: &mut Cursor) : bool {
        let v0 = read_u8(arg0);
        assert!(v0 <= 1, 1);
        v0 == 1
    }

    public fun is_empty(arg0: &Cursor) : bool {
        arg0.offset == 0x1::vector::length<u8>(&arg0.bytes)
    }

    public fun new(arg0: vector<u8>) : Cursor {
        Cursor{
            bytes  : arg0,
            offset : 0,
        }
    }

    public fun read_address(arg0: &mut Cursor) : address {
        let v0 = arg0.offset;
        skip(arg0, 32);
        let v1 = b"";
        let v2 = 0;
        while (v2 < 32) {
            0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(&arg0.bytes, v0 + v2));
            v2 = v2 + 1;
        };
        0x2::address::from_bytes(v1)
    }

    public fun read_u128(arg0: &mut Cursor) : u128 {
        let v0 = read_u64(arg0);
        (v0 as u128) | (read_u64(arg0) as u128) << 64
    }

    public fun read_u16(arg0: &mut Cursor) : u16 {
        let v0 = arg0.offset;
        skip(arg0, 2);
        (*0x1::vector::borrow<u8>(&arg0.bytes, v0) as u16) | (*0x1::vector::borrow<u8>(&arg0.bytes, v0 + 1) as u16) << 8
    }

    public fun read_u32(arg0: &mut Cursor) : u32 {
        let v0 = arg0.offset;
        skip(arg0, 4);
        (*0x1::vector::borrow<u8>(&arg0.bytes, v0) as u32) | (*0x1::vector::borrow<u8>(&arg0.bytes, v0 + 1) as u32) << 8 | (*0x1::vector::borrow<u8>(&arg0.bytes, v0 + 2) as u32) << 16 | (*0x1::vector::borrow<u8>(&arg0.bytes, v0 + 3) as u32) << 24
    }

    public fun read_u64(arg0: &mut Cursor) : u64 {
        let v0 = arg0.offset;
        skip(arg0, 8);
        (*0x1::vector::borrow<u8>(&arg0.bytes, v0) as u64) | (*0x1::vector::borrow<u8>(&arg0.bytes, v0 + 1) as u64) << 8 | (*0x1::vector::borrow<u8>(&arg0.bytes, v0 + 2) as u64) << 16 | (*0x1::vector::borrow<u8>(&arg0.bytes, v0 + 3) as u64) << 24 | (*0x1::vector::borrow<u8>(&arg0.bytes, v0 + 4) as u64) << 32 | (*0x1::vector::borrow<u8>(&arg0.bytes, v0 + 5) as u64) << 40 | (*0x1::vector::borrow<u8>(&arg0.bytes, v0 + 6) as u64) << 48 | (*0x1::vector::borrow<u8>(&arg0.bytes, v0 + 7) as u64) << 56
    }

    public fun read_u8(arg0: &mut Cursor) : u8 {
        let v0 = arg0.offset;
        skip(arg0, 1);
        *0x1::vector::borrow<u8>(&arg0.bytes, v0)
    }

    public fun skip(arg0: &mut Cursor, arg1: u64) {
        assert!(arg1 <= 0x1::vector::length<u8>(&arg0.bytes) - arg0.offset, 0);
        arg0.offset = arg0.offset + arg1;
    }

    // decompiled from Move bytecode v7
}

