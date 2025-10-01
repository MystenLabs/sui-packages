module 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::outbound_packet {
    struct OutboundPacket has copy, drop, store {
        nonce: u64,
        src_eid: u32,
        sender: address,
        dst_eid: u32,
        receiver: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32,
        guid: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32,
        message: vector<u8>,
    }

    public(friend) fun create(arg0: u64, arg1: u32, arg2: address, arg3: u32, arg4: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32, arg5: vector<u8>) : OutboundPacket {
        OutboundPacket{
            nonce    : arg0,
            src_eid  : arg1,
            sender   : arg2,
            dst_eid  : arg3,
            receiver : arg4,
            guid     : 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::utils::compute_guid(arg0, arg1, 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::from_address(arg2), arg3, arg4),
            message  : arg5,
        }
    }

    public fun dst_eid(arg0: &OutboundPacket) : u32 {
        arg0.dst_eid
    }

    public fun guid(arg0: &OutboundPacket) : 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32 {
        arg0.guid
    }

    public fun message(arg0: &OutboundPacket) : &vector<u8> {
        &arg0.message
    }

    public fun message_length(arg0: &OutboundPacket) : u64 {
        0x1::vector::length<u8>(&arg0.message)
    }

    public fun nonce(arg0: &OutboundPacket) : u64 {
        arg0.nonce
    }

    public fun receiver(arg0: &OutboundPacket) : 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32 {
        arg0.receiver
    }

    public fun sender(arg0: &OutboundPacket) : address {
        arg0.sender
    }

    public fun src_eid(arg0: &OutboundPacket) : u32 {
        arg0.src_eid
    }

    public fun unpack(arg0: OutboundPacket) : (u64, u32, address, u32, 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32, 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32, vector<u8>) {
        let OutboundPacket {
            nonce    : v0,
            src_eid  : v1,
            sender   : v2,
            dst_eid  : v3,
            receiver : v4,
            guid     : v5,
            message  : v6,
        } = arg0;
        (v0, v1, v2, v3, v4, v5, v6)
    }

    // decompiled from Move bytecode v6
}

