module 0x867d397c547f340917f17090948dc0d6d2172f30195adeff888546dadd8db97e::dege {
    struct DEGE has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<DEGE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<DEGE>>(0x2::coin::mint<DEGE>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: DEGE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/DfRD86CCGB6VphAtF4X2B6wgMSfK1C1xvGHrPLt1pump.png?size=lg&key=490ed6                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<DEGE>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"DEGE    ")))), trim_right(b"Pepe's Dog                      "), trim_right(b"Introducing $DEGE - Pepe's faithful dog and the most fierce meme hero. This four-legged leader has already gathered his first degen - those who are not afraid to take risks and are ready to go to the end. He knows that the crypto market loves hardcore, and memes are his main weapon.                                     "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DEGE>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<DEGE>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<DEGE>>(0x2::coin::mint<DEGE>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

