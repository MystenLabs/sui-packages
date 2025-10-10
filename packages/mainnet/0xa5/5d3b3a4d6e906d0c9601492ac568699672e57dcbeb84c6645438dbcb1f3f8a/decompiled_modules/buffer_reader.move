module 0xa55d3b3a4d6e906d0c9601492ac568699672e57dcbeb84c6645438dbcb1f3f8a::buffer_reader {
    struct Reader has copy, drop {
        buffer: vector<u8>,
        position: u64,
    }

    public fun length(arg0: &Reader) : u64 {
        0x1::vector::length<u8>(&arg0.buffer)
    }

    public fun create(arg0: vector<u8>) : Reader {
        Reader{
            buffer   : arg0,
            position : 0,
        }
    }

    public fun position(arg0: &Reader) : u64 {
        arg0.position
    }

    public fun read_address(arg0: &mut Reader) : address {
        let v0 = read_bytes32(arg0);
        0xa55d3b3a4d6e906d0c9601492ac568699672e57dcbeb84c6645438dbcb1f3f8a::bytes32::to_address(&v0)
    }

    public fun read_bool(arg0: &mut Reader) : bool {
        read_u8(arg0) != 0
    }

    public fun read_bytes32(arg0: &mut Reader) : 0xa55d3b3a4d6e906d0c9601492ac568699672e57dcbeb84c6645438dbcb1f3f8a::bytes32::Bytes32 {
        0xa55d3b3a4d6e906d0c9601492ac568699672e57dcbeb84c6645438dbcb1f3f8a::bytes32::from_bytes(read_fixed_len_bytes(arg0, 32))
    }

    public fun read_bytes_until_end(arg0: &mut Reader) : vector<u8> {
        let v0 = remaining_length(arg0);
        read_fixed_len_bytes(arg0, v0)
    }

    public fun read_fixed_len_bytes(arg0: &mut Reader, arg1: u64) : vector<u8> {
        assert!(arg0.position + arg1 <= 0x1::vector::length<u8>(&arg0.buffer), 1);
        let v0 = b"";
        let v1 = 0;
        while (v1 < arg1) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(&arg0.buffer, arg0.position + v1));
            v1 = v1 + 1;
        };
        arg0.position = arg0.position + arg1;
        v0
    }

    public fun read_u128(arg0: &mut Reader) : u128 {
        assert!(arg0.position + 16 <= 0x1::vector::length<u8>(&arg0.buffer), 1);
        let v0 = 0;
        let v1 = 0;
        let v2 = arg0.position;
        while (v1 < 16) {
            v0 = v0 + ((*0x1::vector::borrow<u8>(&arg0.buffer, v2) as u128) << (16 - v1 - 1) * 8);
            v2 = v2 + 1;
            v1 = v1 + 1;
        };
        arg0.position = v2;
        v0
    }

    public fun read_u16(arg0: &mut Reader) : u16 {
        assert!(arg0.position + 2 <= 0x1::vector::length<u8>(&arg0.buffer), 1);
        let v0 = 0;
        let v1 = 0;
        let v2 = arg0.position;
        while (v1 < 2) {
            v0 = v0 + ((*0x1::vector::borrow<u8>(&arg0.buffer, v2) as u16) << (2 - v1 - 1) * 8);
            v2 = v2 + 1;
            v1 = v1 + 1;
        };
        arg0.position = v2;
        v0
    }

    public fun read_u256(arg0: &mut Reader) : u256 {
        assert!(arg0.position + 32 <= 0x1::vector::length<u8>(&arg0.buffer), 1);
        let v0 = 0;
        let v1 = 0;
        let v2 = arg0.position;
        while (v1 < 32) {
            v0 = v0 + ((*0x1::vector::borrow<u8>(&arg0.buffer, v2) as u256) << (32 - v1 - 1) * 8);
            v2 = v2 + 1;
            v1 = v1 + 1;
        };
        arg0.position = v2;
        v0
    }

    public fun read_u32(arg0: &mut Reader) : u32 {
        assert!(arg0.position + 4 <= 0x1::vector::length<u8>(&arg0.buffer), 1);
        let v0 = 0;
        let v1 = 0;
        let v2 = arg0.position;
        while (v1 < 4) {
            v0 = v0 + ((*0x1::vector::borrow<u8>(&arg0.buffer, v2) as u32) << (4 - v1 - 1) * 8);
            v2 = v2 + 1;
            v1 = v1 + 1;
        };
        arg0.position = v2;
        v0
    }

    public fun read_u64(arg0: &mut Reader) : u64 {
        assert!(arg0.position + 8 <= 0x1::vector::length<u8>(&arg0.buffer), 1);
        let v0 = 0;
        let v1 = 0;
        let v2 = arg0.position;
        while (v1 < 8) {
            v0 = v0 + ((*0x1::vector::borrow<u8>(&arg0.buffer, v2) as u64) << (8 - v1 - 1) * 8);
            v2 = v2 + 1;
            v1 = v1 + 1;
        };
        arg0.position = v2;
        v0
    }

    public fun read_u8(arg0: &mut Reader) : u8 {
        assert!(arg0.position + 1 <= 0x1::vector::length<u8>(&arg0.buffer), 1);
        let v0 = 0;
        let v1 = 0;
        let v2 = arg0.position;
        while (v1 < 1) {
            v0 = v0 + ((*0x1::vector::borrow<u8>(&arg0.buffer, v2) as u8) << (1 - v1 - 1) * 8);
            v2 = v2 + 1;
            v1 = v1 + 1;
        };
        arg0.position = v2;
        v0
    }

    public fun remaining_length(arg0: &Reader) : u64 {
        0x1::vector::length<u8>(&arg0.buffer) - arg0.position
    }

    public fun rewind(arg0: &mut Reader, arg1: u64) : &mut Reader {
        assert!(arg0.position >= arg1, 1);
        let v0 = arg0.position - arg1;
        set_position(arg0, v0)
    }

    public fun set_position(arg0: &mut Reader, arg1: u64) : &mut Reader {
        assert!(arg1 <= 0x1::vector::length<u8>(&arg0.buffer), 1);
        arg0.position = arg1;
        arg0
    }

    public fun skip(arg0: &mut Reader, arg1: u64) : &mut Reader {
        let v0 = arg0.position + arg1;
        set_position(arg0, v0)
    }

    public fun to_bytes(arg0: &Reader) : vector<u8> {
        arg0.buffer
    }

    // decompiled from Move bytecode v6
}

