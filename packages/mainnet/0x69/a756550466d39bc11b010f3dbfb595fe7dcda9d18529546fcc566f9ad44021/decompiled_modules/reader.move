module 0x69a756550466d39bc11b010f3dbfb595fe7dcda9d18529546fcc566f9ad44021::reader {
    struct AbiReader has copy, drop {
        bytes: vector<u8>,
    }

    fun decode_variable(arg0: &AbiReader, arg1: u64) : vector<u8> {
        let v0 = &arg0.bytes;
        let v1 = 0x1::vector::empty<u8>();
        let v2 = 0;
        while (v2 < (read_u256(arg0, arg1) as u64)) {
            0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(v0, v2 + (arg1 + 1) * 32));
            v2 = v2 + 1;
        };
        v1
    }

    public fun new_reader(arg0: vector<u8>) : AbiReader {
        AbiReader{bytes: arg0}
    }

    public fun read_address(arg0: &AbiReader, arg1: u64) : address {
        0x2::address::from_bytes(read_bytes(arg0, arg1))
    }

    public fun read_bytes(arg0: &AbiReader, arg1: u64) : vector<u8> {
        decode_variable(arg0, (read_u256(arg0, arg1) as u64) / 32)
    }

    public fun read_u256(arg0: &AbiReader, arg1: u64) : u256 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 32) {
            let v2 = v0 << 8;
            v0 = v2 | (*0x1::vector::borrow<u8>(&arg0.bytes, v1 + 32 * arg1) as u256);
            v1 = v1 + 1;
        };
        v0
    }

    public fun read_vector_address(arg0: &AbiReader, arg1: u64) : vector<address> {
        let v0 = (read_u256(arg0, arg1) as u64) / 32;
        let v1 = 0x1::vector::empty<address>();
        let v2 = 0;
        while (v2 < (read_u256(arg0, v0) as u64)) {
            0x1::vector::push_back<address>(&mut v1, 0x2::address::from_bytes(decode_variable(arg0, v0 + (read_u256(arg0, v0 + v2 + 1) as u64) / 32 + 1)));
            v2 = v2 + 1;
        };
        v1
    }

    public fun read_vector_bytes(arg0: &AbiReader, arg1: u64) : vector<vector<u8>> {
        let v0 = (read_u256(arg0, arg1) as u64) / 32;
        let v1 = 0x1::vector::empty<vector<u8>>();
        let v2 = 0;
        while (v2 < (read_u256(arg0, v0) as u64)) {
            0x1::vector::push_back<vector<u8>>(&mut v1, decode_variable(arg0, v0 + (read_u256(arg0, v0 + v2 + 1) as u64) / 32 + 1));
            v2 = v2 + 1;
        };
        v1
    }

    public fun read_vector_u256(arg0: &AbiReader, arg1: u64) : vector<u256> {
        let v0 = (read_u256(arg0, arg1) as u64) / 32;
        let v1 = 0x1::vector::empty<u256>();
        let v2 = 0;
        while (v2 < (read_u256(arg0, v0) as u64)) {
            0x1::vector::push_back<u256>(&mut v1, read_u256(arg0, v0 + v2 + 1));
            v2 = v2 + 1;
        };
        v1
    }

    // decompiled from Move bytecode v6
}

