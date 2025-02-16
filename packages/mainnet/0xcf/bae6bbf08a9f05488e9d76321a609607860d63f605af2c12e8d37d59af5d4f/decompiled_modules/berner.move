module 0xcfbae6bbf08a9f05488e9d76321a609607860d63f605af2c12e8d37d59af5d4f::berner {
    struct BERNER has drop {
        dummy_field: bool,
    }

    fun init(arg0: BERNER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/FL6LrGtmvA4YavYh3odc1XFyhBwV8Bqc6DGR1mYwsAfT.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<BERNER>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"BERNER      ")))), trim_right(b"BERNER BULL                     "), trim_right(b"Berner Bull ($BERNER)  Inspired by Berner420 Berner Bull is a meme-driven crypto project inspired by Berner420, a rising content creator and music artist known for his viral energy and bold personality. Built for true fans and degens alike, $BERNER embraces the hustle, creativity, and raw entertainment that define Bern"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BERNER>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BERNER>>(v4);
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

