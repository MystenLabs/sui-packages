module 0xeb98c7e572acd94e61149ec2bd85e1e528464d73b28f791c079a2d29df25ea36::ikun {
    struct IKUN has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<IKUN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<IKUN>>(0x2::coin::mint<IKUN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: IKUN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/A33ixaQZyJ6cLvsEgFp8rxFvP2LUD7ZrP7PaPRrnrQ4E.png?size=lg&key=b65e35                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<IKUN>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"IKUN    ")))), trim_right(b"BROTHER IKUN                    "), trim_right(b"BROTHER IKUN is the story of two unstoppable brothers: bold, loud, and always side by side.                                                                                                                                                                                                                                     "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IKUN>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<IKUN>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<IKUN>>(0x2::coin::mint<IKUN>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

