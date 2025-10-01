module 0x9de6d60206bfbc7b6f4c898b7d7c12dc749973098a9c346bca9d0cfa365be0d3::packet_v1_codec {
    struct PacketHeader has copy, drop {
        version: u8,
        nonce: u64,
        src_eid: u32,
        sender: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32,
        dst_eid: u32,
        receiver: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32,
    }

    public fun dst_eid(arg0: &PacketHeader) : u32 {
        arg0.dst_eid
    }

    public fun nonce(arg0: &PacketHeader) : u64 {
        arg0.nonce
    }

    public fun receiver(arg0: &PacketHeader) : 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32 {
        arg0.receiver
    }

    public fun sender(arg0: &PacketHeader) : 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32 {
        arg0.sender
    }

    public fun src_eid(arg0: &PacketHeader) : u32 {
        arg0.src_eid
    }

    public fun decode_header(arg0: vector<u8>) : PacketHeader {
        assert!(0x1::vector::length<u8>(&arg0) == 81, 1);
        let v0 = 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_reader::create(arg0);
        let v1 = PacketHeader{
            version  : 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_reader::read_u8(&mut v0),
            nonce    : 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_reader::read_u64(&mut v0),
            src_eid  : 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_reader::read_u32(&mut v0),
            sender   : 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_reader::read_bytes32(&mut v0),
            dst_eid  : 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_reader::read_u32(&mut v0),
            receiver : 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_reader::read_bytes32(&mut v0),
        };
        assert!(v1.version == 1, 2);
        v1
    }

    public fun encode_header(arg0: &PacketHeader) : vector<u8> {
        let v0 = 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::new();
        0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::write_bytes32(0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::write_u32(0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::write_bytes32(0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::write_u32(0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::write_u64(0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::write_u8(&mut v0, arg0.version), arg0.nonce), arg0.src_eid), arg0.sender), arg0.dst_eid), arg0.receiver);
        0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::to_bytes(v0)
    }

    public fun encode_packet(arg0: &0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::outbound_packet::OutboundPacket) : vector<u8> {
        let v0 = 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::create(encode_packet_header(arg0));
        0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::write_bytes(0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::write_bytes32(&mut v0, 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::outbound_packet::guid(arg0)), *0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::outbound_packet::message(arg0));
        0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::to_bytes(v0)
    }

    public fun encode_packet_header(arg0: &0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::outbound_packet::OutboundPacket) : vector<u8> {
        let v0 = PacketHeader{
            version  : 1,
            nonce    : 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::outbound_packet::nonce(arg0),
            src_eid  : 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::outbound_packet::src_eid(arg0),
            sender   : 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::from_address(0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::outbound_packet::sender(arg0)),
            dst_eid  : 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::outbound_packet::dst_eid(arg0),
            receiver : 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::outbound_packet::receiver(arg0),
        };
        encode_header(&v0)
    }

    public fun payload(arg0: &0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::outbound_packet::OutboundPacket) : vector<u8> {
        let v0 = 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::new();
        0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::write_bytes(0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::write_bytes32(&mut v0, 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::outbound_packet::guid(arg0)), *0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::outbound_packet::message(arg0));
        0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_writer::to_bytes(v0)
    }

    public fun payload_hash(arg0: &0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::outbound_packet::OutboundPacket) : 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32 {
        let v0 = payload(arg0);
        0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::from_bytes(0x2::hash::keccak256(&v0))
    }

    public fun version(arg0: &PacketHeader) : u8 {
        arg0.version
    }

    // decompiled from Move bytecode v6
}

