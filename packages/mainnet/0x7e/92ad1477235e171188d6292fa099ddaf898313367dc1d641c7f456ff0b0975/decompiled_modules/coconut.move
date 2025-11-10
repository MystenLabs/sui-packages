module 0x7e92ad1477235e171188d6292fa099ddaf898313367dc1d641c7f456ff0b0975::coconut {
    struct COCONUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: COCONUT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"15a11e1bc510d68eb9e1440fe6e94c6e0a312e4536aa1f3cc55fc8807b5fb4f7                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<COCONUT>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"COCONUT     ")))), trim_right(b"COLOSSAL COCONUT                "), trim_right(b"The meme COLOSSAL COCONUT made by Elon Musk. The codename for Grok Imagine 1.0. A legendary meme born from the fusion of humor and intelligence  symbolizing massive ideas wrapped in simplicity.  Powered by the community, fueled by imagination.                                                                             "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COCONUT>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COCONUT>>(v4);
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

