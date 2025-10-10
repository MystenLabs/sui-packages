module 0x6386cf2a435ab3d55f52852c16466395391cfe2d74914e5af5305c27eb97cb15::buffer_writer {
    struct Writer has copy {
        buffer: vector<u8>,
    }

    public fun length(arg0: &Writer) : u64 {
        0x1::vector::length<u8>(&arg0.buffer)
    }

    public fun to_bytes(arg0: Writer) : vector<u8> {
        let Writer { buffer: v0 } = arg0;
        v0
    }

    public fun create(arg0: vector<u8>) : Writer {
        Writer{buffer: arg0}
    }

    public fun new() : Writer {
        Writer{buffer: b""}
    }

    public fun write_address(arg0: &mut Writer, arg1: address) : &mut Writer {
        0x1::vector::append<u8>(&mut arg0.buffer, 0x2::address::to_bytes(arg1));
        arg0
    }

    public fun write_bool(arg0: &mut Writer, arg1: bool) : &mut Writer {
        let v0 = if (arg1) {
            1
        } else {
            0
        };
        write_u8(arg0, v0)
    }

    public fun write_bytes(arg0: &mut Writer, arg1: vector<u8>) : &mut Writer {
        0x1::vector::append<u8>(&mut arg0.buffer, arg1);
        arg0
    }

    public fun write_bytes32(arg0: &mut Writer, arg1: 0x6386cf2a435ab3d55f52852c16466395391cfe2d74914e5af5305c27eb97cb15::bytes32::Bytes32) : &mut Writer {
        0x1::vector::append<u8>(&mut arg0.buffer, 0x6386cf2a435ab3d55f52852c16466395391cfe2d74914e5af5305c27eb97cb15::bytes32::to_bytes(&arg1));
        arg0
    }

    public fun write_u128(arg0: &mut Writer, arg1: u128) : &mut Writer {
        let v0 = 0;
        while (v0 < 16) {
            0x1::vector::push_back<u8>(&mut arg0.buffer, ((arg1 >> 8 * (16 - v0 - 1) & 255) as u8));
            v0 = v0 + 1;
        };
        arg0
    }

    public fun write_u16(arg0: &mut Writer, arg1: u16) : &mut Writer {
        let v0 = 0;
        while (v0 < 2) {
            0x1::vector::push_back<u8>(&mut arg0.buffer, ((arg1 >> 8 * (2 - v0 - 1) & 255) as u8));
            v0 = v0 + 1;
        };
        arg0
    }

    public fun write_u256(arg0: &mut Writer, arg1: u256) : &mut Writer {
        let v0 = 0;
        while (v0 < 32) {
            0x1::vector::push_back<u8>(&mut arg0.buffer, ((arg1 >> 8 * (32 - v0 - 1) & 255) as u8));
            v0 = v0 + 1;
        };
        arg0
    }

    public fun write_u32(arg0: &mut Writer, arg1: u32) : &mut Writer {
        let v0 = 0;
        while (v0 < 4) {
            0x1::vector::push_back<u8>(&mut arg0.buffer, ((arg1 >> 8 * (4 - v0 - 1) & 255) as u8));
            v0 = v0 + 1;
        };
        arg0
    }

    public fun write_u64(arg0: &mut Writer, arg1: u64) : &mut Writer {
        let v0 = 0;
        while (v0 < 8) {
            0x1::vector::push_back<u8>(&mut arg0.buffer, ((arg1 >> 8 * (8 - v0 - 1) & 255) as u8));
            v0 = v0 + 1;
        };
        arg0
    }

    public fun write_u8(arg0: &mut Writer, arg1: u8) : &mut Writer {
        let v0 = 0;
        while (v0 < 1) {
            0x1::vector::push_back<u8>(&mut arg0.buffer, ((arg1 >> 8 * (1 - v0 - 1) & 255) as u8));
            v0 = v0 + 1;
        };
        arg0
    }

    // decompiled from Move bytecode v6
}

