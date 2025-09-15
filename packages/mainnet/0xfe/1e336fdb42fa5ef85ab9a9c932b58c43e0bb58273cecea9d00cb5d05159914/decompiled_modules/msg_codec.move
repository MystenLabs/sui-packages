module 0xfe1e336fdb42fa5ef85ab9a9c932b58c43e0bb58273cecea9d00cb5d05159914::msg_codec {
    public fun encode_msg(arg0: u8, arg1: u32, arg2: u256) : vector<u8> {
        let v0 = 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::buffer_writer::new();
        0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::buffer_writer::write_u32(0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::buffer_writer::write_u8(&mut v0, arg0), arg1);
        if (arg2 > 0) {
            0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::buffer_writer::write_u256(&mut v0, arg2);
        };
        0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::buffer_writer::to_bytes(v0)
    }

    public fun get_msg_type(arg0: &vector<u8>) : u8 {
        let v0 = 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::buffer_reader::create(*arg0);
        0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::buffer_reader::read_u8(0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::buffer_reader::skip(&mut v0, 0))
    }

    public fun get_src_eid(arg0: &vector<u8>) : u32 {
        let v0 = 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::buffer_reader::create(*arg0);
        0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::buffer_reader::read_u32(0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::buffer_reader::skip(&mut v0, 1))
    }

    public fun get_value(arg0: &vector<u8>) : u256 {
        if (0x1::vector::length<u8>(arg0) > (5 as u64)) {
            let v1 = 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::buffer_reader::create(*arg0);
            0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::buffer_reader::read_u256(0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::buffer_reader::skip(&mut v1, 5))
        } else {
            0
        }
    }

    // decompiled from Move bytecode v6
}

