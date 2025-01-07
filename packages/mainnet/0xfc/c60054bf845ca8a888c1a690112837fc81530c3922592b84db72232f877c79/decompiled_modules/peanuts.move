module 0xfcc60054bf845ca8a888c1a690112837fc81530c3922592b84db72232f877c79::peanuts {
    struct PEANUTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEANUTS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/DR9hR7e44uss7QGXgsijehim9T8XUiQGgjGhn3h2pump.png?size=lg&key=680b2c                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<PEANUTS>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"PeanutS ")))), trim_right(b"Peanut Santa                    "), trim_right(b"Peanut Santa is an adorable squirrel dressed as Santa, spreading joy and festive cheer! With a playful and cheerful spirit, Peanut brings laughter and happiness wherever he goes, making every day feel like a holiday season                                                                                                  "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEANUTS>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEANUTS>>(v4);
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

