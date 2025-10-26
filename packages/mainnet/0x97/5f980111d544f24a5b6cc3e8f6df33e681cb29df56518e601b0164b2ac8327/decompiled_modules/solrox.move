module 0x975f980111d544f24a5b6cc3e8f6df33e681cb29df56518e601b0164b2ac8327::solrox {
    struct SOLROX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOLROX, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"53f0a6c8cef593811590cf0408237d714c49d442beea53e2d692a615c4ed7da3                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<SOLROX>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"SolRox      ")))), trim_right(b"LAUNCHPAD                       "), trim_right(x"536f6c616e6120666f63757365642074617820616e64206e6f6e2d746178206c61756e6368706164210a0a4c61756e636820796f7572206964656120616e64206561726e210a0a47726f7720796f757220636f6d6d756e697479210a0a486176652066756e202620636865636b206f757420536f6c526f78210a0a5765203c3320536f6c616e612020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOLROX>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOLROX>>(v4);
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

