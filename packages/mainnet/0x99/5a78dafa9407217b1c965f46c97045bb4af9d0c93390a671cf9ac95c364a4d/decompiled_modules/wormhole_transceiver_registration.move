module 0x995a78dafa9407217b1c965f46c97045bb4af9d0c93390a671cf9ac95c364a4d::wormhole_transceiver_registration {
    struct WormholeTransceiverRegistration has drop {
        transceiver_chain_id: u16,
        transceiver_address: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress,
    }

    public(friend) fun new(arg0: u16, arg1: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress) : WormholeTransceiverRegistration {
        WormholeTransceiverRegistration{
            transceiver_chain_id : arg0,
            transceiver_address  : arg1,
        }
    }

    public fun take_bytes(arg0: &mut 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::Cursor<u8>) : WormholeTransceiverRegistration {
        assert!(0x64339530a202aa86f7419ed3fcb05f6f1c7ffcad8e3b1743d61a69fd6d157751::bytes4::to_bytes(0x64339530a202aa86f7419ed3fcb05f6f1c7ffcad8e3b1743d61a69fd6d157751::bytes4::take(arg0)) == x"18fc67c2", 13906834333257236482);
        WormholeTransceiverRegistration{
            transceiver_chain_id : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_u16_be(arg0),
            transceiver_address  : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::take_bytes(arg0),
        }
    }

    public fun to_bytes(arg0: &WormholeTransceiverRegistration) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, x"18fc67c2");
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::push_u16_be(&mut v0, arg0.transceiver_chain_id);
        0x1::vector::append<u8>(&mut v0, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::to_bytes(arg0.transceiver_address));
        v0
    }

    public fun parse(arg0: vector<u8>) : WormholeTransceiverRegistration {
        let v0 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<u8>(arg0);
        let v1 = &mut v0;
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::destroy_empty<u8>(v0);
        take_bytes(v1)
    }

    // decompiled from Move bytecode v6
}

