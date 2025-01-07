module 0x6ec292808914576e15c9e21c9d0ee51651377d5f0f1465ffd8e4d6ddf669b4bf::init_swap_message {
    struct InitSwapMessage {
        hash: address,
    }

    public(friend) fun new(arg0: address) : InitSwapMessage {
        InitSwapMessage{hash: arg0}
    }

    public(friend) fun deserialize(arg0: vector<u8>) : InitSwapMessage {
        assert!(0x1::vector::length<u8>(&arg0) == 34, 2);
        let v0 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<u8>(arg0);
        assert!(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_u8(&mut v0) == 1, 0);
        assert!(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_u8(&mut v0) == 1, 1);
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::destroy_empty<u8>(v0);
        InitSwapMessage{hash: 0x2::address::from_bytes(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_bytes(&mut v0, 32))}
    }

    public(friend) fun serialize(arg0: InitSwapMessage) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::push_u8(&mut v0, 1);
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::push_u8(&mut v0, 1);
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(unpack(arg0)));
        assert!(0x1::vector::length<u8>(&v0) == 34, 2);
        v0
    }

    public(friend) fun unpack(arg0: InitSwapMessage) : address {
        let InitSwapMessage { hash: v0 } = arg0;
        v0
    }

    // decompiled from Move bytecode v6
}

