module 0xb5bd3599ec7f4ae86afd84398f6f2d862deecce965e8ace2d8d8c8108d5076df::vaa_message {
    struct VaaMessage {
        hash: address,
    }

    public(friend) fun new(arg0: address) : VaaMessage {
        VaaMessage{hash: arg0}
    }

    public(friend) fun deserialize(arg0: vector<u8>) : VaaMessage {
        assert!(0x1::vector::length<u8>(&arg0) == 32, 2);
        let v0 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<u8>(arg0);
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::destroy_empty<u8>(v0);
        VaaMessage{hash: 0x2::address::from_bytes(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_bytes(&mut v0, 32))}
    }

    public(friend) fun serialize(arg0: VaaMessage) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(unpack(arg0)));
        assert!(0x1::vector::length<u8>(&v0) == 32, 2);
        v0
    }

    public(friend) fun unpack(arg0: VaaMessage) : address {
        let VaaMessage { hash: v0 } = arg0;
        v0
    }

    // decompiled from Move bytecode v6
}

