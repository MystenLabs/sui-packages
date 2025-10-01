module 0x2187b54793cc25e401c3f423d7776bdcd3ad8b2657668cdba1957f9c3e7153fd::sinu {
    struct SINU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SINU, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"2ad1f81387ca35478970dc5be42a6ebada64d82cd1d7b500b8507802acd906f2                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<SINU>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"SINU        ")))), trim_right(b"Sock Inu                        "), trim_right(x"536f636b20496e7520282453494e55292069732061206d656d6520636f696e20626f726e2066726f6d20612053686962612077686f206b65707420737465616c696e6720736f636b732e0a4e6f77206865207765617273207468656d20616e64206c65616473206120636f6d66792c206e6f2d68797065206d6f76656d656e742e0a4e6f20726f61646d61702e204e6f20776869746570617065722e204a75737420636f7a79207669626573207769746820736f636b73206f6e2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SINU>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SINU>>(v4);
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

