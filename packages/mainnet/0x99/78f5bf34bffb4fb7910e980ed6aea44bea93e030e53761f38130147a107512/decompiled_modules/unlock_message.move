module 0x9978f5bf34bffb4fb7910e980ed6aea44bea93e030e53761f38130147a107512::unlock_message {
    struct UnlockMessage {
        hash: address,
        chain_source: u16,
        token_in: address,
        addr_unlocker: address,
    }

    public(friend) fun new(arg0: address, arg1: u16, arg2: address, arg3: address) : UnlockMessage {
        UnlockMessage{
            hash          : arg0,
            chain_source  : arg1,
            token_in      : arg2,
            addr_unlocker : arg3,
        }
    }

    public(friend) fun deserialize(arg0: vector<u8>) : UnlockMessage {
        assert!(0x1::vector::length<u8>(&arg0) == 99, 1);
        let v0 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<u8>(arg0);
        assert!(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_u8(&mut v0) == 3, 0);
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::destroy_empty<u8>(v0);
        UnlockMessage{
            hash          : 0x2::address::from_bytes(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_bytes(&mut v0, 32)),
            chain_source  : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_u16_be(&mut v0),
            token_in      : 0x2::address::from_bytes(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_bytes(&mut v0, 32)),
            addr_unlocker : 0x2::address::from_bytes(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_bytes(&mut v0, 32)),
        }
    }

    public(friend) fun serialize(arg0: UnlockMessage) : vector<u8> {
        let (v0, v1, v2, v3) = unpack(arg0);
        let v4 = 0x1::vector::empty<u8>();
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::push_u8(&mut v4, 3);
        0x1::vector::append<u8>(&mut v4, 0x2::address::to_bytes(v0));
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::push_u16_be(&mut v4, v1);
        0x1::vector::append<u8>(&mut v4, 0x2::address::to_bytes(v2));
        0x1::vector::append<u8>(&mut v4, 0x2::address::to_bytes(v3));
        assert!(0x1::vector::length<u8>(&v4) == 99, 1);
        v4
    }

    public(friend) fun unpack(arg0: UnlockMessage) : (address, u16, address, address) {
        let UnlockMessage {
            hash          : v0,
            chain_source  : v1,
            token_in      : v2,
            addr_unlocker : v3,
        } = arg0;
        (v0, v1, v2, v3)
    }

    // decompiled from Move bytecode v6
}

