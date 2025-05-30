module 0x4814cea3e98c99e388df06b0467c1ee95e712d6a815af01e0e3a166e55ade073::fulfill_message {
    struct FulfillMessage {
        hash: address,
        amount_promised: u64,
        driver: address,
    }

    public(friend) fun deserialize(arg0: vector<u8>) : FulfillMessage {
        assert!(0x1::vector::length<u8>(&arg0) == 73, 1);
        let v0 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<u8>(arg0);
        assert!(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_u8(&mut v0) == 1, 0);
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::destroy_empty<u8>(v0);
        FulfillMessage{
            hash            : 0x2::address::from_bytes(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_bytes(&mut v0, 32)),
            amount_promised : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_u64_be(&mut v0),
            driver          : 0x2::address::from_bytes(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_bytes(&mut v0, 32)),
        }
    }

    public(friend) fun unpack(arg0: FulfillMessage) : (address, u64, address) {
        let FulfillMessage {
            hash            : v0,
            amount_promised : v1,
            driver          : v2,
        } = arg0;
        (v0, v1, v2)
    }

    // decompiled from Move bytecode v6
}

