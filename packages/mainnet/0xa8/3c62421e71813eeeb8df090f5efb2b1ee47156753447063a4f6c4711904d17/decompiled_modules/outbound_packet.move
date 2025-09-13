module 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::outbound_packet {
    struct OutboundPacket has copy, drop, store {
        nonce: u64,
        src_eid: u32,
        sender: address,
        dst_eid: u32,
        receiver: 0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::bytes32::Bytes32,
        guid: 0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::bytes32::Bytes32,
        message: vector<u8>,
    }

    public(friend) fun create(arg0: u64, arg1: u32, arg2: address, arg3: u32, arg4: 0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::bytes32::Bytes32, arg5: vector<u8>) : OutboundPacket {
        OutboundPacket{
            nonce    : arg0,
            src_eid  : arg1,
            sender   : arg2,
            dst_eid  : arg3,
            receiver : arg4,
            guid     : 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::utils::compute_guid(arg0, arg1, 0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::bytes32::from_address(arg2), arg3, arg4),
            message  : arg5,
        }
    }

    public fun dst_eid(arg0: &OutboundPacket) : u32 {
        arg0.dst_eid
    }

    public fun guid(arg0: &OutboundPacket) : 0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::bytes32::Bytes32 {
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

    public fun receiver(arg0: &OutboundPacket) : 0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::bytes32::Bytes32 {
        arg0.receiver
    }

    public fun sender(arg0: &OutboundPacket) : address {
        arg0.sender
    }

    public fun src_eid(arg0: &OutboundPacket) : u32 {
        arg0.src_eid
    }

    public fun unpack(arg0: OutboundPacket) : (u64, u32, address, u32, 0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::bytes32::Bytes32, 0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::bytes32::Bytes32, vector<u8>) {
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

