module 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::vaa {
    struct TokenBridgeMessage {
        emitter_chain: u16,
        emitter_address: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress,
        sequence: u64,
        payload: vector<u8>,
    }

    fun assert_registered_emitter(arg0: &0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::state::State, arg1: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::VAA) {
        let v0 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::emitter_chain(arg1);
        let v1 = 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::state::borrow_emitter_registry(arg0);
        assert!(0x2::table::contains<u16, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress>(v1, v0), 0);
        assert!(*0x2::table::borrow<u16, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress>(v1, v0) == 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::emitter_address(arg1), 1);
    }

    public fun emitter_address(arg0: &TokenBridgeMessage) : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress {
        arg0.emitter_address
    }

    public fun emitter_chain(arg0: &TokenBridgeMessage) : u16 {
        arg0.emitter_chain
    }

    public fun sequence(arg0: &TokenBridgeMessage) : u64 {
        arg0.sequence
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

    public fun verify_only_once(arg0: &mut 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::state::State, arg1: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::VAA) : TokenBridgeMessage {
        let v0 = 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::state::assert_latest_only(arg0);
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::consume(0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::state::borrow_mut_consumed_vaas(&v0, arg0), &arg1);
        assert_registered_emitter(arg0, &arg1);
        let (v1, v2, v3) = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::take_emitter_info_and_payload(arg1);
        TokenBridgeMessage{
            emitter_chain   : v1,
            emitter_address : v2,
            sequence        : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::sequence(&arg1),
            payload         : v3,
        }
    }

    // decompiled from Move bytecode v6
}

