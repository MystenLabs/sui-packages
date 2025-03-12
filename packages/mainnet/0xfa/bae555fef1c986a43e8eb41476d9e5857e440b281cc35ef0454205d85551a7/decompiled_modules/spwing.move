module 0xfabae555fef1c986a43e8eb41476d9e5857e440b281cc35ef0454205d85551a7::spwing {
    struct SPWING has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPWING, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/9PtcqGC5PDL7QhHPP3eKJb9AmNsbJomKXyKNUBNKpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<SPWING>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Spwing      ")))), trim_right(b"Spwing Bweak                    "), trim_right(b"Spring break but with a lisp. If your girl goes on spring break vacation without you, she ain't your girl no more.                                                                                                                                                                                                              "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPWING>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPWING>>(v4);
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

