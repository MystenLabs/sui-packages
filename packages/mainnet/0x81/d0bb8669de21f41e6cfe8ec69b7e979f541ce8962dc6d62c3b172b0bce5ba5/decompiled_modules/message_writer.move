module 0x5be3b953994a26e01d28a9bcb6b943f102222ca0a9e265d21e4946915c335d8e::message_writer {
    struct MessageWriter {
        msg: vector<u8>,
    }

    public fun extract_message(arg0: MessageWriter) : vector<u8> {
        let MessageWriter { msg: v0 } = arg0;
        v0
    }

    public fun new() : MessageWriter {
        MessageWriter{msg: b""}
    }

    public fun write_data_pad32(arg0: &mut MessageWriter, arg1: vector<u8>) {
        0x1::vector::append<u8>(&mut arg0.msg, arg1);
        let v0 = 32 - 0x1::vector::length<u8>(&arg1) % 32;
        if (v0 != 32) {
            while (v0 > 0) {
                0x1::vector::push_back<u8>(&mut arg0.msg, 0);
                v0 = v0 - 1;
            };
        };
    }

    public fun write_u256(arg0: &mut MessageWriter, arg1: u256) {
        let v0 = 0x1::bcs::to_bytes<u256>(&arg1);
        0x1::vector::reverse<u8>(&mut v0);
        write_data_pad32(arg0, v0);
    }

    // decompiled from Move bytecode v6
}

