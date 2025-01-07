module 0x4d991703daf0e83baada3221e458606fad44275c2f8dfeef69f2370a031f8410::longxdd {
    struct LONGXDD has drop {
        dummy_field: bool,
    }

    fun init(arg0: LONGXDD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"1           ");
        let v1 = trim_right(b"https://gateway.irys.xyz/4xTCMpCTfBqn0ZSuwoGqvK_ZQ9wr0OKQbRvBqyS-sXg                                                                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<LONGXDD>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Longxdd ")))), trim_right(b"Longxdd                         "), trim_right(b"The Year of the Dragon, the Dragon Coin and the Dragon Bless China, the ancient civilization and cultural world                                                                                                                                                                                                                 "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LONGXDD>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LONGXDD>>(v4);
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

