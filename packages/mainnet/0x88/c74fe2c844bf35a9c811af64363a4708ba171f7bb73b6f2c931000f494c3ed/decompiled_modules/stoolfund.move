module 0x88c74fe2c844bf35a9c811af64363a4708ba171f7bb73b6f2c931000f494c3ed::stoolfund {
    struct STOOLFUND has drop {
        dummy_field: bool,
    }

    fun init(arg0: STOOLFUND, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/AnZfSCJdna8EDFh9kgW6ZtpuwoHJUDnK1kG2tP6Kpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<STOOLFUND>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"STOOLFUND   ")))), trim_right(b"The Barstool Fund               "), trim_right(x"53746f6f6c46756e642069732061206d656d65636f696e207468617420686f6e6f722773204461766520506f72746e6f7973206f726967696e616c2042617273746f6f6c46756e642e20204974277320676f616c20697320746f2068656c7020736d616c6c20627573696e657373657320696e206e6565642e0a0a446176652077617320646f6e617465642035352520636f6e74726f6c206f66207468652066756e642062792074686520746f6b656e27732063726561746f722062656361757365206f6620616e20616374206f66206b696e646e657373206f766572204368726973746d61732032303234207468617420736176656420612070697a7a612072657374617572616e742066726f6d20676f696e67206f7574206f6620627573696e6573732e0a0a53746f6f6c46756e642063726561746f72206e6f74653a20"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STOOLFUND>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STOOLFUND>>(v4);
    }

    fun trim_right(arg0: vector<u8>) : vector<u8> {
        let v0 = 32;
        let v1 = &v0;
        while (0x1::vector::length<u8>(&arg0) > 0) {
            if (0x1::vector::borrow<u8>(&arg0, 0x1::vector::length<u8>(&arg0) - 1) != v1) {
                break
            };
            0x1::vector::pop_back<u8>(&mut arg0);
        };
        arg0
    }

    // decompiled from Move bytecode v6
}

