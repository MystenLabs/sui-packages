module 0x5b7716fc5f08c1e25a642f32df7b145503707e304102d1bb8296bc13bd169ea7::cancel_message {
    struct CancelMessage {
        hash: address,
        chain_source: u16,
        token_in: address,
        trader: address,
        relayer_cancel: address,
        fee_cancel_normalized: u64,
        fee_refund_normalized: u64,
    }

    public(friend) fun new(arg0: address, arg1: u16, arg2: address, arg3: address, arg4: address, arg5: u64, arg6: u64) : CancelMessage {
        CancelMessage{
            hash                  : arg0,
            chain_source          : arg1,
            token_in              : arg2,
            trader                : arg3,
            relayer_cancel        : arg4,
            fee_cancel_normalized : arg5,
            fee_refund_normalized : arg6,
        }
    }

    public(friend) fun deserialize(arg0: vector<u8>) : CancelMessage {
        assert!(0x1::vector::length<u8>(&arg0) == 147, 1);
        let v0 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<u8>(arg0);
        assert!(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_u8(&mut v0) == 3, 0);
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::destroy_empty<u8>(v0);
        CancelMessage{
            hash                  : 0x2::address::from_bytes(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_bytes(&mut v0, 32)),
            chain_source          : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_u16_be(&mut v0),
            token_in              : 0x2::address::from_bytes(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_bytes(&mut v0, 32)),
            trader                : 0x2::address::from_bytes(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_bytes(&mut v0, 32)),
            relayer_cancel        : 0x2::address::from_bytes(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_bytes(&mut v0, 32)),
            fee_cancel_normalized : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_u64_be(&mut v0),
            fee_refund_normalized : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_u64_be(&mut v0),
        }
    }

    public(friend) fun serialize(arg0: CancelMessage) : vector<u8> {
        let (v0, v1, v2, v3, v4, v5, v6) = unpack(arg0);
        let v7 = 0x1::vector::empty<u8>();
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::push_u8(&mut v7, 3);
        0x1::vector::append<u8>(&mut v7, 0x2::address::to_bytes(v0));
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::push_u16_be(&mut v7, v1);
        0x1::vector::append<u8>(&mut v7, 0x2::address::to_bytes(v2));
        0x1::vector::append<u8>(&mut v7, 0x2::address::to_bytes(v3));
        0x1::vector::append<u8>(&mut v7, 0x2::address::to_bytes(v4));
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::push_u64_be(&mut v7, v5);
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::push_u64_be(&mut v7, v6);
        assert!(0x1::vector::length<u8>(&v7) == 147, 1);
        v7
    }

    public(friend) fun unpack(arg0: CancelMessage) : (address, u16, address, address, address, u64, u64) {
        let CancelMessage {
            hash                  : v0,
            chain_source          : v1,
            token_in              : v2,
            trader                : v3,
            relayer_cancel        : v4,
            fee_cancel_normalized : v5,
            fee_refund_normalized : v6,
        } = arg0;
        (v0, v1, v2, v3, v4, v5, v6)
    }

    // decompiled from Move bytecode v6
}

