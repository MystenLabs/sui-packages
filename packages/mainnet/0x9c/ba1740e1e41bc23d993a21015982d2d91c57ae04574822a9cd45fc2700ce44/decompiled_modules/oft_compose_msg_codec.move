module 0x9cba1740e1e41bc23d993a21015982d2d91c57ae04574822a9cd45fc2700ce44::oft_compose_msg_codec {
    struct OFTComposeMsg has copy, drop {
        nonce: u64,
        src_eid: u32,
        amount_ld: u64,
        compose_from: 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::Bytes32,
        compose_msg: vector<u8>,
    }

    public fun amount_ld(arg0: &OFTComposeMsg) : u64 {
        arg0.amount_ld
    }

    public fun compose_from(arg0: &OFTComposeMsg) : 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::Bytes32 {
        arg0.compose_from
    }

    public fun compose_msg(arg0: &OFTComposeMsg) : &vector<u8> {
        &arg0.compose_msg
    }

    public fun decode(arg0: &vector<u8>) : OFTComposeMsg {
        let v0 = 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::buffer_reader::create(*arg0);
        OFTComposeMsg{
            nonce        : 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::buffer_reader::read_u64(&mut v0),
            src_eid      : 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::buffer_reader::read_u32(&mut v0),
            amount_ld    : 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::buffer_reader::read_u64(&mut v0),
            compose_from : 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::buffer_reader::read_bytes32(&mut v0),
            compose_msg  : 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::buffer_reader::read_bytes_until_end(&mut v0),
        }
    }

    public fun encode(arg0: u64, arg1: u32, arg2: u64, arg3: 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::Bytes32, arg4: vector<u8>) : vector<u8> {
        let v0 = 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::buffer_writer::new();
        0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::buffer_writer::write_bytes(0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::buffer_writer::write_bytes32(0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::buffer_writer::write_u64(0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::buffer_writer::write_u32(0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::buffer_writer::write_u64(&mut v0, arg0), arg1), arg2), arg3), arg4);
        0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::buffer_writer::to_bytes(v0)
    }

    public fun nonce(arg0: &OFTComposeMsg) : u64 {
        arg0.nonce
    }

    public fun src_eid(arg0: &OFTComposeMsg) : u32 {
        arg0.src_eid
    }

    // decompiled from Move bytecode v6
}

