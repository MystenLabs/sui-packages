module 0x3464d3508e6eeb201c24bda40b52883e0a02e9393eb5891e777082284eb91785::oft_msg_codec {
    struct OFTMessage has copy, drop {
        send_to: address,
        amount_sd: u64,
        compose_from: 0x1::option::Option<0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32>,
        compose_msg: 0x1::option::Option<vector<u8>>,
    }

    public fun amount_sd(arg0: &OFTMessage) : u64 {
        arg0.amount_sd
    }

    public fun compose_from(arg0: &OFTMessage) : 0x1::option::Option<0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32> {
        arg0.compose_from
    }

    public fun compose_msg(arg0: &OFTMessage) : &0x1::option::Option<vector<u8>> {
        &arg0.compose_msg
    }

    public fun decode(arg0: vector<u8>) : OFTMessage {
        let v0 = 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_reader::create(arg0);
        if (0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_reader::remaining_length(&v0) > 0) {
            OFTMessage{send_to: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_reader::read_address(&mut v0), amount_sd: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_reader::read_u64(&mut v0), compose_from: 0x1::option::some<0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32>(0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_reader::read_bytes32(&mut v0)), compose_msg: 0x1::option::some<vector<u8>>(0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_reader::read_bytes_until_end(&mut v0))}
        } else {
            OFTMessage{send_to: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_reader::read_address(&mut v0), amount_sd: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_reader::read_u64(&mut v0), compose_from: 0x1::option::none<0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32>(), compose_msg: 0x1::option::none<vector<u8>>()}
        }
    }

    public fun encode(arg0: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32, arg1: u64, arg2: 0x1::option::Option<0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32>, arg3: 0x1::option::Option<vector<u8>>) : vector<u8> {
        let v0 = 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::new();
        0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::write_u64(0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::write_bytes32(&mut v0, arg0), arg1);
        if (0x1::option::is_some<0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32>(&arg2) && 0x1::option::is_some<vector<u8>>(&arg3)) {
            0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::write_bytes32(&mut v0, 0x1::option::destroy_some<0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32>(arg2));
            0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::write_bytes(&mut v0, 0x1::option::destroy_some<vector<u8>>(arg3));
        };
        0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::to_bytes(v0)
    }

    public fun is_composed(arg0: &OFTMessage) : bool {
        0x1::option::is_some<0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32>(&arg0.compose_from) && 0x1::option::is_some<vector<u8>>(&arg0.compose_msg)
    }

    public fun send_to(arg0: &OFTMessage) : address {
        arg0.send_to
    }

    // decompiled from Move bytecode v6
}

