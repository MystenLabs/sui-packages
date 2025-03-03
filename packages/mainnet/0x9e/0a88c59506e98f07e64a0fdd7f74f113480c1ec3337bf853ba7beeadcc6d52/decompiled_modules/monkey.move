module 0x9e0a88c59506e98f07e64a0fdd7f74f113480c1ec3337bf853ba7beeadcc6d52::monkey {
    struct MONKEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MONKEY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/D2vutozQtXEpfeDDwdL71e94M3feJDw5nbVqnHCQpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<MONKEY>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"MONKEY      ")))), trim_right(b"Evil Monkey                     "), trim_right(b"Evil Monkey is the crypto thats been hiding in your closet, waiting to make its big move when you least expect it! Inspired by the finger-pointing menace from Family Guy, this coin is here to turn your portfolio into a comedy show. Think youve got diamond hands? Evil Monkeys here to laugh in your face and throw a banan"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MONKEY>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MONKEY>>(v4);
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

