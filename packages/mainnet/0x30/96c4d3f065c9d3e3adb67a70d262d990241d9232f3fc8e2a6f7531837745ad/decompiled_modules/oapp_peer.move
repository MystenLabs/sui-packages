module 0x3096c4d3f065c9d3e3adb67a70d262d990241d9232f3fc8e2a6f7531837745ad::oapp_peer {
    struct Peer has store {
        peers: 0x2::table::Table<u32, 0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::bytes32::Bytes32>,
    }

    struct PeerSetEvent has copy, drop {
        oapp: address,
        eid: u32,
        peer: 0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::bytes32::Bytes32,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : Peer {
        Peer{peers: 0x2::table::new<u32, 0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::bytes32::Bytes32>(arg0)}
    }

    public(friend) fun get_peer(arg0: &Peer, arg1: u32) : 0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::bytes32::Bytes32 {
        let v0 = &arg0.peers;
        assert!(0x2::table::contains<u32, 0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::bytes32::Bytes32>(v0, arg1), 0);
        *0x2::table::borrow<u32, 0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::bytes32::Bytes32>(v0, arg1)
    }

    public(friend) fun has_peer(arg0: &Peer, arg1: u32) : bool {
        0x2::table::contains<u32, 0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::bytes32::Bytes32>(&arg0.peers, arg1)
    }

    public(friend) fun set_peer(arg0: &mut Peer, arg1: address, arg2: u32, arg3: 0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::bytes32::Bytes32) {
        assert!(!0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::bytes32::is_zero(&arg3), 1);
        let v0 = &mut arg0.peers;
        if (0x2::table::contains<u32, 0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::bytes32::Bytes32>(v0, arg2)) {
            *0x2::table::borrow_mut<u32, 0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::bytes32::Bytes32>(v0, arg2) = arg3;
        } else {
            0x2::table::add<u32, 0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::bytes32::Bytes32>(v0, arg2, arg3);
        };
        let v1 = PeerSetEvent{
            oapp : arg1,
            eid  : arg2,
            peer : arg3,
        };
        0x2::event::emit<PeerSetEvent>(v1);
    }

    // decompiled from Move bytecode v6
}

