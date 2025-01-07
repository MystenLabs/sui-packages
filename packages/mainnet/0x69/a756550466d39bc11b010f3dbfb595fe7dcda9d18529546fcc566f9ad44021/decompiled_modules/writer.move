module 0x69a756550466d39bc11b010f3dbfb595fe7dcda9d18529546fcc566f9ad44021::writer {
    struct AbiWriter has copy, drop {
        bytes: vector<u8>,
        pos: u64,
    }

    fun append_bytes(arg0: &mut AbiWriter, arg1: vector<u8>) {
        let v0 = 0x1::vector::length<u8>(&arg1);
        let v1 = &mut arg0.bytes;
        0x1::vector::append<u8>(v1, arg1);
        if (v0 == 0) {
            return
        };
        let v2 = 0;
        while (v2 < 31 - (v0 - 1) % 32) {
            0x1::vector::push_back<u8>(v1, 0);
            v2 = v2 + 1;
        };
    }

    fun append_u256(arg0: &mut AbiWriter, arg1: u256) {
        let v0 = &mut arg0.bytes;
        let v1 = 0;
        while (v1 < 32) {
            0x1::vector::push_back<u8>(v0, ((arg1 >> (((31 - v1) * 8) as u8) & 255) as u8));
            v1 = v1 + 1;
        };
    }

    fun encode_u256(arg0: &mut AbiWriter, arg1: u64, arg2: u256) {
        let v0 = &mut arg0.bytes;
        let v1 = 0;
        while (v1 < 32) {
            *0x1::vector::borrow_mut<u8>(v0, v1 + 32 * arg1) = ((arg2 >> (((31 - v1) * 8) as u8) & 255) as u8);
            v1 = v1 + 1;
        };
    }

    public fun into_bytes(arg0: AbiWriter) : vector<u8> {
        let AbiWriter {
            bytes : v0,
            pos   : _,
        } = arg0;
        v0
    }

    public fun new_writer(arg0: u64) : AbiWriter {
        let v0 = 0x1::vector::empty<u8>();
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

    public fun write_address(arg0: &mut AbiWriter, arg1: address) : &mut AbiWriter {
        write_bytes(arg0, 0x1::bcs::to_bytes<address>(&arg1))
    }

    public fun write_bool(arg0: &mut AbiWriter, arg1: bool) : &mut AbiWriter {
        if (arg1) {
            write_u256(arg0, 1)
        } else {
            write_u256(arg0, 0)
        }
    }

    public fun write_bytes(arg0: &mut AbiWriter, arg1: vector<u8>) : &mut AbiWriter {
        let v0 = arg0.pos;
        let v1 = (0x1::vector::length<u8>(&arg0.bytes) as u256);
        encode_u256(arg0, v0, v1);
        append_u256(arg0, (0x1::vector::length<u8>(&arg1) as u256));
        append_bytes(arg0, arg1);
        arg0.pos = arg0.pos + 1;
        arg0
    }

    public fun write_string(arg0: &mut AbiWriter, arg1: 0x1::string::String) : &mut AbiWriter {
        write_bytes(arg0, *0x1::string::bytes(&arg1))
    }

    public fun write_u256(arg0: &mut AbiWriter, arg1: u256) : &mut AbiWriter {
        let v0 = arg0.pos;
        encode_u256(arg0, v0, arg1);
        arg0.pos = arg0.pos + 1;
        arg0
    }

    public fun write_vector_bytes(arg0: &mut AbiWriter, arg1: vector<vector<u8>>) : &mut AbiWriter {
        let v0 = arg0.pos;
        let v1 = (0x1::vector::length<u8>(&arg0.bytes) as u256);
        encode_u256(arg0, v0, v1);
        let v2 = 0x1::vector::length<vector<u8>>(&arg1);
        append_u256(arg0, (v2 as u256));
        let v3 = 0;
        let v4 = new_writer(v2);
        while (v3 < v2) {
            let v5 = &mut v4;
            write_bytes(v5, *0x1::vector::borrow<vector<u8>>(&arg1, v3));
            v3 = v3 + 1;
        };
        append_bytes(arg0, into_bytes(v4));
        arg0.pos = arg0.pos + 1;
        arg0
    }

    public fun write_vector_u256(arg0: &mut AbiWriter, arg1: vector<u256>) : &mut AbiWriter {
        let v0 = arg0.pos;
        let v1 = (0x1::vector::length<u8>(&arg0.bytes) as u256);
        encode_u256(arg0, v0, v1);
        let v2 = 0x1::vector::length<u256>(&arg1);
        append_u256(arg0, (v2 as u256));
        let v3 = 0;
        while (v3 < v2) {
            append_u256(arg0, *0x1::vector::borrow<u256>(&arg1, v3));
            v3 = v3 + 1;
        };
        arg0.pos = arg0.pos + 1;
        arg0
    }

    // decompiled from Move bytecode v6
}

