module 0x82db9671b88c5c66bf85b7ac13a4c9cbbbe4ed5b5b6cfb6865aa0e65d6b166c8::fulfill_message {
    struct FulfillMessage {
        hash: address,
        amount_promised: u64,
        foreign_driver: address,
        penalty_period: u16,
    }

    public(friend) fun deserialize(arg0: vector<u8>) : FulfillMessage {
        assert!(0x1::vector::length<u8>(&arg0) == 75, 1);
        let v0 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<u8>(arg0);
        assert!(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_u8(&mut v0) == 1, 0);
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::destroy_empty<u8>(v0);
        FulfillMessage{
            hash            : 0x2::address::from_bytes(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_bytes(&mut v0, 32)),
            amount_promised : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_u64_be(&mut v0),
            foreign_driver  : 0x2::address::from_bytes(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_bytes(&mut v0, 32)),
            penalty_period  : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_u16_be(&mut v0),
        }
    }

    public(friend) fun unpack(arg0: FulfillMessage) : (address, u64, address, u16) {
        let FulfillMessage {
            hash            : v0,
            amount_promised : v1,
            foreign_driver  : v2,
            penalty_period  : v3,
        } = arg0;
        (v0, v1, v2, v3)
    }

    // decompiled from Move bytecode v6
}

