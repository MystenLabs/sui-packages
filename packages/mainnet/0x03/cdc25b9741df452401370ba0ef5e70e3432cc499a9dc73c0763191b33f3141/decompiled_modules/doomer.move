module 0x3cdc25b9741df452401370ba0ef5e70e3432cc499a9dc73c0763191b33f3141::doomer {
    struct DOOMER has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOOMER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/5tweC8q9jbKi3JawkM6WnxVDRL5Yi5h8Y5mdq4wA9wP5.png?size=lg&key=e79ec4                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<DOOMER>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"DOOMER  ")))), trim_right(b"Doomer                          "), trim_right(b"Doomer sat in his dimly lit room, staring at his screen, watching his portfolio bleed outagain. Every time he thought he'd made it, every time he saw the next big meme coin pumping, he threw in everything he had. \"This is the one,\" he whispered, knowing deep down it wasn't.                                              "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOOMER>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOOMER>>(v4);
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

