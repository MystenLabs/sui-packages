module 0xb9f84eadd93eb616a3bf4a44b144141926e7c8976262acaa4906b62f647b2558::wormhole_transceiver_registration {
    struct WormholeTransceiverRegistration has drop {
        transceiver_chain_id: u16,
        transceiver_address: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress,
    }

    public fun to_bytes(arg0: &WormholeTransceiverRegistration) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, x"18fc67c2");
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::push_u16_be(&mut v0, arg0.transceiver_chain_id);
        0x1::vector::append<u8>(&mut v0, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::to_bytes(arg0.transceiver_address));
        v0
    }

    public(friend) fun new(arg0: u16, arg1: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress) : WormholeTransceiverRegistration {
        WormholeTransceiverRegistration{
            transceiver_chain_id : arg0,
            transceiver_address  : arg1,
        }
    }

    public fun take_bytes(arg0: &mut 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::Cursor<u8>) : WormholeTransceiverRegistration {
        assert!(0x879a05537be4935866af4b3d620e5efdfe9ad67573cd57c554ba4ff7ca7708e::bytes4::to_bytes(0x879a05537be4935866af4b3d620e5efdfe9ad67573cd57c554ba4ff7ca7708e::bytes4::take(arg0)) == x"18fc67c2", 13906834333257236482);
        WormholeTransceiverRegistration{
            transceiver_chain_id : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_u16_be(arg0),
            transceiver_address  : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::take_bytes(arg0),
        }
    }

    public fun parse(arg0: vector<u8>) : WormholeTransceiverRegistration {
        let v0 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<u8>(arg0);
        let v1 = &mut v0;
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::destroy_empty<u8>(v0);
        take_bytes(v1)
    }

    // decompiled from Move bytecode v6
}

