module 0x4814cea3e98c99e388df06b0467c1ee95e712d6a815af01e0e3a166e55ade073::unlock_message {
    struct UnlockMessage {
        hash: address,
        chain_source: u16,
        token_in: address,
        addr_ref: address,
        fee_rate_ref: u8,
        fee_rate_mayan: u8,
        addr_unlocker: address,
        winner: address,
        fulfill_time: u64,
    }

    public(friend) fun deserialize(arg0: vector<u8>) : UnlockMessage {
        assert!(0x1::vector::length<u8>(&arg0) == 173, 1);
        let v0 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<u8>(arg0);
        assert!(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_u8(&mut v0) == 2, 0);
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::destroy_empty<u8>(v0);
        UnlockMessage{
            hash           : 0x2::address::from_bytes(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_bytes(&mut v0, 32)),
            chain_source   : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_u16_be(&mut v0),
            token_in       : 0x2::address::from_bytes(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_bytes(&mut v0, 32)),
            addr_ref       : 0x2::address::from_bytes(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_bytes(&mut v0, 32)),
            fee_rate_ref   : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_u8(&mut v0),
            fee_rate_mayan : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_u8(&mut v0),
            addr_unlocker  : 0x2::address::from_bytes(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_bytes(&mut v0, 32)),
            winner         : 0x2::address::from_bytes(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_bytes(&mut v0, 32)),
            fulfill_time   : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_u64_be(&mut v0),
        }
    }

    public(friend) fun new(arg0: address, arg1: u16, arg2: address, arg3: address, arg4: u8, arg5: u8, arg6: address, arg7: address, arg8: u64) : UnlockMessage {
        UnlockMessage{
            hash           : arg0,
            chain_source   : arg1,
            token_in       : arg2,
            addr_ref       : arg3,
            fee_rate_ref   : arg4,
            fee_rate_mayan : arg5,
            addr_unlocker  : arg6,
            winner         : arg7,
            fulfill_time   : arg8,
        }
    }

    public(friend) fun serialize(arg0: UnlockMessage) : vector<u8> {
        let (v0, v1, v2, v3, v4, v5, v6, v7, v8) = unpack(arg0);
        let v9 = 0x1::vector::empty<u8>();
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::push_u8(&mut v9, 2);
        0x1::vector::append<u8>(&mut v9, 0x2::address::to_bytes(v0));
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::push_u16_be(&mut v9, v1);
        0x1::vector::append<u8>(&mut v9, 0x2::address::to_bytes(v2));
        0x1::vector::append<u8>(&mut v9, 0x2::address::to_bytes(v3));
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::push_u8(&mut v9, v4);
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::push_u8(&mut v9, v5);
        0x1::vector::append<u8>(&mut v9, 0x2::address::to_bytes(v6));
        0x1::vector::append<u8>(&mut v9, 0x2::address::to_bytes(v7));
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::push_u64_be(&mut v9, v8);
        assert!(0x1::vector::length<u8>(&v9) == 173, 1);
        v9
    }

    public(friend) fun unpack(arg0: UnlockMessage) : (address, u16, address, address, u8, u8, address, address, u64) {
        let UnlockMessage {
            hash           : v0,
            chain_source   : v1,
            token_in       : v2,
            addr_ref       : v3,
            fee_rate_ref   : v4,
            fee_rate_mayan : v5,
            addr_unlocker  : v6,
            winner         : v7,
            fulfill_time   : v8,
        } = arg0;
        (v0, v1, v2, v3, v4, v5, v6, v7, v8)
    }

    // decompiled from Move bytecode v6
}

