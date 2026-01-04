module 0xdf58b700c122e9c746e393733ec03a35b84eb23b8f027d6e8c9cf4ad786e576e::wormhole_transceiver_info {
    struct WormholeTransceiverInfo has drop {
        manager_address: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress,
        manager_mode: 0x9f56168d45d16ce7a0d91a7b3c4d66133f62134a81145f69d60ac15abf06756d::mode::Mode,
        token_address: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress,
        token_decimals: u8,
    }

    public fun to_bytes(arg0: &WormholeTransceiverInfo) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, x"9c23bd3b");
        0x1::vector::append<u8>(&mut v0, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::to_bytes(arg0.manager_address));
        0x1::vector::append<u8>(&mut v0, 0x9f56168d45d16ce7a0d91a7b3c4d66133f62134a81145f69d60ac15abf06756d::mode::serialize(arg0.manager_mode));
        0x1::vector::append<u8>(&mut v0, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::to_bytes(arg0.token_address));
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::push_u8(&mut v0, arg0.token_decimals);
        v0
    }

    public fun take_bytes(arg0: &mut 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::Cursor<u8>) : WormholeTransceiverInfo {
        assert!(0x33f77c0a7c588b1cefbbf24e627a98ac96f05b176eb981510c7c846154eabad8::bytes4::to_bytes(0x33f77c0a7c588b1cefbbf24e627a98ac96f05b176eb981510c7c846154eabad8::bytes4::take(arg0)) == x"9c23bd3b", 13906834367616974850);
        WormholeTransceiverInfo{
            manager_address : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::take_bytes(arg0),
            manager_mode    : 0x9f56168d45d16ce7a0d91a7b3c4d66133f62134a81145f69d60ac15abf06756d::mode::parse(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_bytes(arg0, 1)),
            token_address   : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::take_bytes(arg0),
            token_decimals  : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_u8(arg0),
        }
    }

    public(friend) fun new(arg0: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress, arg1: 0x9f56168d45d16ce7a0d91a7b3c4d66133f62134a81145f69d60ac15abf06756d::mode::Mode, arg2: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress, arg3: u8) : WormholeTransceiverInfo {
        WormholeTransceiverInfo{
            manager_address : arg0,
            manager_mode    : arg1,
            token_address   : arg2,
            token_decimals  : arg3,
        }
    }

    public fun parse(arg0: vector<u8>) : WormholeTransceiverInfo {
        let v0 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<u8>(arg0);
        let v1 = &mut v0;
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::destroy_empty<u8>(v0);
        take_bytes(v1)
    }

    // decompiled from Move bytecode v6
}

