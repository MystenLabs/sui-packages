module 0x1a5560d246b031b0e631036510d5618c9de8ef714c0a82299a1a9303071ee853::akira {
    struct AKIRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AKIRA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"blob:https://app.waye.ai/b54268ba-6618-495d-984a-b16363203c25                                                                                                                                                                                                                                                                   ");
        let v1 = if (0x1::vector::length<u8>(&v0) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v0))
        };
        let (v2, v3) = 0x2::coin::create_currency<AKIRA>(arg0, 9, 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"AKIRA   ")))), trim_right(b"AKIRA                           "), trim_right(b"AKIRA Token represents everything about Akira from her ruthless candour to her sexy body                                                                                                                                                                                                                                        "), v1, arg1);
        let v4 = v2;
        0x2::transfer::public_transfer<0x2::coin::Coin<AKIRA>>(0x2::coin::mint<AKIRA>(&mut v4, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<AKIRA>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AKIRA>>(v3);
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

