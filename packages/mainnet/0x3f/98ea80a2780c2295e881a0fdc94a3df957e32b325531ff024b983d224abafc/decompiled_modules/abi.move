module 0x3f98ea80a2780c2295e881a0fdc94a3df957e32b325531ff024b983d224abafc::abi {
    struct AbiReader has copy, drop {
        bytes: vector<u8>,
        head: u64,
        pos: u64,
    }

    struct AbiWriter has copy, drop {
        bytes: vector<u8>,
        pos: u64,
    }

    fun append_bytes(arg0: &mut AbiWriter, arg1: vector<u8>) {
        let v0 = 0x1::vector::length<u8>(&arg1);
        if (v0 == 0) {
            return
        };
        0x1::vector::append<u8>(&mut arg0.bytes, arg1);
        let v1 = 0;
        while (v1 < 32 - 1 - (v0 - 1) % 32) {
            0x1::vector::push_back<u8>(&mut arg0.bytes, 0);
            v1 = v1 + 1;
        };
    }

    fun append_u256(arg0: &mut AbiWriter, arg1: u256) {
        let v0 = 0x2::bcs::to_bytes<u256>(&arg1);
        0x1::vector::reverse<u8>(&mut v0);
        0x1::vector::append<u8>(&mut arg0.bytes, v0);
    }

    fun decode_bytes(arg0: &mut AbiReader) : vector<u8> {
        let v0 = read_u256(arg0);
        let v1 = b"";
        let v2 = 0;
        while (v2 < (v0 as u64)) {
            0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(&arg0.bytes, v2 + arg0.pos));
            v2 = v2 + 1;
        };
        v1
    }

    public fun into_bytes(arg0: AbiWriter) : vector<u8> {
        let AbiWriter {
            bytes : v0,
            pos   : _,
        } = arg0;
        v0
    }

    public fun new_reader(arg0: vector<u8>) : AbiReader {
        AbiReader{
            bytes : arg0,
            head  : 0,
            pos   : 0,
        }
    }

    public fun new_writer(arg0: u64) : AbiWriter {
        let v0 = b"";
        let v1 = 0;
        while (v1 < 32 * arg0) {
            0x1::vector::push_back<u8>(&mut v0, 0);
            v1 = v1 + 1;
        };
        AbiWriter{
            bytes : v0,
            pos   : 0,
        }
    }

    public fun read_bytes(arg0: &mut AbiReader) : vector<u8> {
        let v0 = arg0.pos;
        let v1 = read_u256(arg0);
        arg0.pos = arg0.head + (v1 as u64);
        let v2 = decode_bytes(arg0);
        arg0.pos = v0 + 32;
        v2
    }

    public fun read_bytes_raw(arg0: &mut AbiReader) : vector<u8> {
        let v0 = read_u256(arg0);
        let v1 = (v0 as u64);
        let v2 = b"";
        let v3 = 0;
        while (v3 < 0x1::vector::length<u8>(&arg0.bytes) - v1) {
            0x1::vector::push_back<u8>(&mut v2, *0x1::vector::borrow<u8>(&arg0.bytes, v1 + v3));
            v3 = v3 + 1;
        };
        v2
    }

    public fun read_u256(arg0: &mut AbiReader) : u256 {
        let v0 = 0;
        let v1 = arg0.pos;
        let v2 = 0;
        while (v2 < 32) {
            let v3 = v0 << 8;
            v0 = v3 | (*0x1::vector::borrow<u8>(&arg0.bytes, v2 + v1) as u256);
            v2 = v2 + 1;
        };
        arg0.pos = v1 + 32;
        v0
    }

    public fun read_u8(arg0: &mut AbiReader) : u8 {
        (read_u256(arg0) as u8)
    }

    public fun read_vector_bytes(arg0: &mut AbiReader) : vector<vector<u8>> {
        let v0 = arg0.pos;
        let v1 = arg0.head;
        let v2 = read_u256(arg0);
        arg0.pos = v1 + (v2 as u64);
        let v3 = read_u256(arg0);
        arg0.head = arg0.pos;
        let v4 = vector[];
        let v5 = 0;
        while (v5 < (v3 as u64)) {
            let v6 = read_bytes(arg0);
            0x1::vector::push_back<vector<u8>>(&mut v4, v6);
            v5 = v5 + 1;
        };
        arg0.pos = v0 + 32;
        arg0.head = v1;
        v4
    }

    public fun read_vector_u256(arg0: &mut AbiReader) : vector<u256> {
        let v0 = arg0.pos;
        let v1 = read_u256(arg0);
        arg0.pos = arg0.head + (v1 as u64);
        let v2 = read_u256(arg0);
        let v3 = vector[];
        let v4 = 0;
        while (v4 < (v2 as u64)) {
            let v5 = read_u256(arg0);
            0x1::vector::push_back<u256>(&mut v3, v5);
            v4 = v4 + 1;
        };
        arg0.pos = v0 + 32;
        v3
    }

    public fun replace_bytes(arg0: &mut AbiWriter, arg1: vector<u8>) : &mut AbiWriter {
        let v0 = 0x1::vector::length<u8>(&arg1);
        if (v0 != 32) {
            return arg0
        };
        let v1 = arg0.pos;
        let v2 = 0;
        while (v2 < v0) {
            *0x1::vector::borrow_mut<u8>(&mut arg0.bytes, v1) = *0x1::vector::borrow<u8>(&arg1, v2);
            v1 = v1 + 1;
            v2 = v2 + 1;
        };
        arg0.pos = arg0.pos + 32;
        arg0
    }

    public fun skip_slot(arg0: &mut AbiReader) {
        arg0.pos = arg0.pos + 32;
    }

    public fun write_bytes(arg0: &mut AbiWriter, arg1: vector<u8>) : &mut AbiWriter {
        let v0 = (0x1::vector::length<u8>(&arg0.bytes) as u256);
        write_u256(arg0, v0);
        append_u256(arg0, (0x1::vector::length<u8>(&arg1) as u256));
        append_bytes(arg0, arg1);
        arg0
    }

    public fun write_bytes_raw(arg0: &mut AbiWriter, arg1: vector<u8>) : &mut AbiWriter {
        let v0 = (0x1::vector::length<u8>(&arg0.bytes) as u256);
        write_u256(arg0, v0);
        append_bytes(arg0, arg1);
        arg0
    }

    public fun write_u256(arg0: &mut AbiWriter, arg1: u256) : &mut AbiWriter {
        let v0 = arg0.pos;
        let v1 = 0;
        while (v1 < 32) {
            *0x1::vector::borrow_mut<u8>(&mut arg0.bytes, v1 + v0) = ((arg1 >> (((31 - v1) * 8) as u8) & 255) as u8);
            v1 = v1 + 1;
        };
        arg0.pos = v0 + 32;
        arg0
    }

    public fun write_u8(arg0: &mut AbiWriter, arg1: u8) : &mut AbiWriter {
        write_u256(arg0, (arg1 as u256))
    }

    public fun write_vector_bytes(arg0: &mut AbiWriter, arg1: vector<vector<u8>>) : &mut AbiWriter {
        let v0 = (0x1::vector::length<u8>(&arg0.bytes) as u256);
        write_u256(arg0, v0);
        let v1 = 0x1::vector::length<vector<u8>>(&arg1);
        append_u256(arg0, (v1 as u256));
        let v2 = new_writer(v1);
        0x1::vector::reverse<vector<u8>>(&mut arg1);
        while (0x1::vector::length<vector<u8>>(&arg1) != 0) {
            let v3 = &mut v2;
            write_bytes(v3, 0x1::vector::pop_back<vector<u8>>(&mut arg1));
        };
        0x1::vector::destroy_empty<vector<u8>>(arg1);
        append_bytes(arg0, into_bytes(v2));
        arg0
    }

    public fun write_vector_u256(arg0: &mut AbiWriter, arg1: vector<u256>) : &mut AbiWriter {
        let v0 = (0x1::vector::length<u8>(&arg0.bytes) as u256);
        write_u256(arg0, v0);
        append_u256(arg0, (0x1::vector::length<u256>(&arg1) as u256));
        0x1::vector::reverse<u256>(&mut arg1);
        while (0x1::vector::length<u256>(&arg1) != 0) {
            append_u256(arg0, 0x1::vector::pop_back<u256>(&mut arg1));
        };
        0x1::vector::destroy_empty<u256>(arg1);
        arg0
    }

    // decompiled from Move bytecode v6
}

