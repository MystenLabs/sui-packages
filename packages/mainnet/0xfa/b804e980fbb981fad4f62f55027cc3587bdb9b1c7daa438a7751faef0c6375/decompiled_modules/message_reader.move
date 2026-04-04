module 0xfab804e980fbb981fad4f62f55027cc3587bdb9b1c7daa438a7751faef0c6375::message_reader {
    struct MessageReader has drop {
        msg: vector<u8>,
        pos: u64,
    }

    public fun new(arg0: vector<u8>) : MessageReader {
        MessageReader{
            msg : arg0,
            pos : 0,
        }
    }

    public fun position(arg0: &MessageReader) : u64 {
        arg0.pos
    }

    public fun read_data_pad32(arg0: &mut MessageReader, arg1: u64) : vector<u8> {
        let v0 = if (arg1 % 32 != 0) {
            32 - arg1 % 32
        } else {
            0
        };
        assert!(arg0.pos + arg1 + v0 <= 0x1::vector::length<u8>(&arg0.msg), 1);
        let v1 = b"";
        while (arg1 > 0) {
            0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(&arg0.msg, arg0.pos));
            arg0.pos = arg0.pos + 1;
            arg1 = arg1 - 1;
        };
        arg0.pos = arg0.pos + v0;
        v1
    }

    public fun read_u256(arg0: &mut MessageReader) : u256 {
        let v0 = 0;
        let v1 = read_data_pad32(arg0, 32);
        0x1::vector::reverse<u8>(&mut v1);
        let v2 = 0;
        while (v2 < 0x1::vector::length<u8>(&v1)) {
            let v3 = v0 << 8;
            v0 = v3 + (0x1::vector::pop_back<u8>(&mut v1) as u256);
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<u8>(v1);
        v0
    }

    public fun remaining(arg0: &MessageReader) : u64 {
        0x1::vector::length<u8>(&arg0.msg) - arg0.pos
    }

    // decompiled from Move bytecode v6
}

