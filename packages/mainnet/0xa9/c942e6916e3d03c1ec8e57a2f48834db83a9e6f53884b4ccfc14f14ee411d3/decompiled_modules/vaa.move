module 0xa9c942e6916e3d03c1ec8e57a2f48834db83a9e6f53884b4ccfc14f14ee411d3::vaa {
    struct TokenBridgeMessage {
        emitter_chain: u16,
        emitter_address: 0x3ab442fe7bdf90fcb990f72a4df4ed786d49f7dc5d907a47db27d8599b795e31::external_address::ExternalAddress,
        sequence: u64,
        payload: vector<u8>,
    }

    public fun emitter_address(arg0: &TokenBridgeMessage) : 0x3ab442fe7bdf90fcb990f72a4df4ed786d49f7dc5d907a47db27d8599b795e31::external_address::ExternalAddress {
        arg0.emitter_address
    }

    public fun emitter_chain(arg0: &TokenBridgeMessage) : u16 {
        arg0.emitter_chain
    }

    public fun sequence(arg0: &TokenBridgeMessage) : u64 {
        arg0.sequence
    }

    fun assert_registered_emitter(arg0: &0xa9c942e6916e3d03c1ec8e57a2f48834db83a9e6f53884b4ccfc14f14ee411d3::state::State, arg1: &0x3ab442fe7bdf90fcb990f72a4df4ed786d49f7dc5d907a47db27d8599b795e31::vaa::VAA) {
        let v0 = 0x3ab442fe7bdf90fcb990f72a4df4ed786d49f7dc5d907a47db27d8599b795e31::vaa::emitter_chain(arg1);
        let v1 = 0xa9c942e6916e3d03c1ec8e57a2f48834db83a9e6f53884b4ccfc14f14ee411d3::state::borrow_emitter_registry(arg0);
        assert!(0x2::table::contains<u16, 0x3ab442fe7bdf90fcb990f72a4df4ed786d49f7dc5d907a47db27d8599b795e31::external_address::ExternalAddress>(v1, v0), 0);
        assert!(*0x2::table::borrow<u16, 0x3ab442fe7bdf90fcb990f72a4df4ed786d49f7dc5d907a47db27d8599b795e31::external_address::ExternalAddress>(v1, v0) == 0x3ab442fe7bdf90fcb990f72a4df4ed786d49f7dc5d907a47db27d8599b795e31::vaa::emitter_address(arg1), 1);
    }

    public(friend) fun take_payload(arg0: TokenBridgeMessage) : vector<u8> {
        let TokenBridgeMessage {
            emitter_chain   : _,
            emitter_address : _,
            sequence        : _,
            payload         : v3,
        } = arg0;
        v3
    }

    public fun verify_only_once(arg0: &mut 0xa9c942e6916e3d03c1ec8e57a2f48834db83a9e6f53884b4ccfc14f14ee411d3::state::State, arg1: 0x3ab442fe7bdf90fcb990f72a4df4ed786d49f7dc5d907a47db27d8599b795e31::vaa::VAA) : TokenBridgeMessage {
        let v0 = 0xa9c942e6916e3d03c1ec8e57a2f48834db83a9e6f53884b4ccfc14f14ee411d3::state::assert_latest_only(arg0);
        0x3ab442fe7bdf90fcb990f72a4df4ed786d49f7dc5d907a47db27d8599b795e31::vaa::consume(0xa9c942e6916e3d03c1ec8e57a2f48834db83a9e6f53884b4ccfc14f14ee411d3::state::borrow_mut_consumed_vaas(&v0, arg0), &arg1);
        assert_registered_emitter(arg0, &arg1);
        let (v1, v2, v3) = 0x3ab442fe7bdf90fcb990f72a4df4ed786d49f7dc5d907a47db27d8599b795e31::vaa::take_emitter_info_and_payload(arg1);
        TokenBridgeMessage{
            emitter_chain   : v1,
            emitter_address : v2,
            sequence        : 0x3ab442fe7bdf90fcb990f72a4df4ed786d49f7dc5d907a47db27d8599b795e31::vaa::sequence(&arg1),
            payload         : v3,
        }
    }

    // decompiled from Move bytecode v6
}

