module 0x5d62c9e28bb3af663b8fd746d36293cd642c26acf8836028eebb6b72ba55ccdc::packet_v1_codec {
    struct PacketHeader has copy, drop {
        version: u8,
        nonce: u64,
        src_eid: u32,
        sender: 0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::bytes32::Bytes32,
        dst_eid: u32,
        receiver: 0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::bytes32::Bytes32,
    }

    public fun decode_header(arg0: vector<u8>) : PacketHeader {
        assert!(0x1::vector::length<u8>(&arg0) == 81, 1);
        let v0 = 0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::buffer_reader::create(arg0);
        let v1 = PacketHeader{
            version  : 0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::buffer_reader::read_u8(&mut v0),
            nonce    : 0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::buffer_reader::read_u64(&mut v0),
            src_eid  : 0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::buffer_reader::read_u32(&mut v0),
            sender   : 0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::buffer_reader::read_bytes32(&mut v0),
            dst_eid  : 0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::buffer_reader::read_u32(&mut v0),
            receiver : 0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::buffer_reader::read_bytes32(&mut v0),
        };
        assert!(v1.version == 1, 2);
        v1
    }

    public fun dst_eid(arg0: &PacketHeader) : u32 {
        arg0.dst_eid
    }

    public fun encode_header(arg0: &PacketHeader) : vector<u8> {
        let v0 = 0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::buffer_writer::new();
        0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::buffer_writer::write_bytes32(0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::buffer_writer::write_u32(0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::buffer_writer::write_bytes32(0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::buffer_writer::write_u32(0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::buffer_writer::write_u64(0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::buffer_writer::write_u8(&mut v0, arg0.version), arg0.nonce), arg0.src_eid), arg0.sender), arg0.dst_eid), arg0.receiver);
        0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::buffer_writer::to_bytes(v0)
    }

    public fun encode_packet(arg0: &0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::outbound_packet::OutboundPacket) : vector<u8> {
        let v0 = 0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::buffer_writer::create(encode_packet_header(arg0));
        0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::buffer_writer::write_bytes(0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::buffer_writer::write_bytes32(&mut v0, 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::outbound_packet::guid(arg0)), *0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::outbound_packet::message(arg0));
        0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::buffer_writer::to_bytes(v0)
    }

    public fun encode_packet_header(arg0: &0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::outbound_packet::OutboundPacket) : vector<u8> {
        let v0 = PacketHeader{
            version  : 1,
            nonce    : 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::outbound_packet::nonce(arg0),
            src_eid  : 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::outbound_packet::src_eid(arg0),
            sender   : 0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::bytes32::from_address(0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::outbound_packet::sender(arg0)),
            dst_eid  : 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::outbound_packet::dst_eid(arg0),
            receiver : 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::outbound_packet::receiver(arg0),
        };
        encode_header(&v0)
    }

    public fun nonce(arg0: &PacketHeader) : u64 {
        arg0.nonce
    }

    public fun payload(arg0: &0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::outbound_packet::OutboundPacket) : vector<u8> {
        let v0 = 0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::buffer_writer::new();
        0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::buffer_writer::write_bytes(0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::buffer_writer::write_bytes32(&mut v0, 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::outbound_packet::guid(arg0)), *0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::outbound_packet::message(arg0));
        0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::buffer_writer::to_bytes(v0)
    }

    public fun payload_hash(arg0: &0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::outbound_packet::OutboundPacket) : 0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::bytes32::Bytes32 {
        let v0 = payload(arg0);
        0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::bytes32::from_bytes(0x2::hash::keccak256(&v0))
    }

    public fun receiver(arg0: &PacketHeader) : 0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::bytes32::Bytes32 {
        arg0.receiver
    }

    public fun sender(arg0: &PacketHeader) : 0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::bytes32::Bytes32 {
        arg0.sender
    }

    public fun src_eid(arg0: &PacketHeader) : u32 {
        arg0.src_eid
    }

    public fun version(arg0: &PacketHeader) : u8 {
        arg0.version
    }

    // decompiled from Move bytecode v6
}

