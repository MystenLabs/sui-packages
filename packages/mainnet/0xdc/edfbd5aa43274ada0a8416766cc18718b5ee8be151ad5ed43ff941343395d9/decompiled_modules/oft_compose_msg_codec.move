module 0xdcedfbd5aa43274ada0a8416766cc18718b5ee8be151ad5ed43ff941343395d9::oft_compose_msg_codec {
    struct OFTComposeMsg has copy, drop {
        nonce: u64,
        src_eid: u32,
        amount_ld: u64,
        compose_from: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32,
        compose_msg: vector<u8>,
    }

    public fun amount_ld(arg0: &OFTComposeMsg) : u64 {
        arg0.amount_ld
    }

    public fun compose_from(arg0: &OFTComposeMsg) : 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32 {
        arg0.compose_from
    }

    public fun compose_msg(arg0: &OFTComposeMsg) : &vector<u8> {
        &arg0.compose_msg
    }

    public fun decode(arg0: &vector<u8>) : OFTComposeMsg {
        let v0 = 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_reader::create(*arg0);
        OFTComposeMsg{
            nonce        : 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_reader::read_u64(&mut v0),
            src_eid      : 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_reader::read_u32(&mut v0),
            amount_ld    : 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_reader::read_u64(&mut v0),
            compose_from : 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_reader::read_bytes32(&mut v0),
            compose_msg  : 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_reader::read_bytes_until_end(&mut v0),
        }
    }

    public fun encode(arg0: u64, arg1: u32, arg2: u64, arg3: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32, arg4: vector<u8>) : vector<u8> {
        let v0 = 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::new();
        0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::write_bytes(0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::write_bytes32(0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::write_u64(0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::write_u32(0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::write_u64(&mut v0, arg0), arg1), arg2), arg3), arg4);
        0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::to_bytes(v0)
    }

    public fun nonce(arg0: &OFTComposeMsg) : u64 {
        arg0.nonce
    }

    public fun src_eid(arg0: &OFTComposeMsg) : u32 {
        arg0.src_eid
    }

    // decompiled from Move bytecode v6
}

