module 0x7bab1132528618b9f607d2116926f9d9850676e815d24a8c42b67fc4a460c6ee::hood {
    struct HOOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOOD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"552nSH7Gj419xKFF                                                                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<HOOD>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Hood        ")))), trim_right(b"Robbing the Hood                "), trim_right(b"Robbing the Hood is a community-driven meme coin on Solana, built on the idea that the hood fights back and wins against the rich and corrupt. Fast, low-cost, and powered by the people, this token flips the script on financial inequality. With a strong community at its core, Robbing the Hood isnt just a memeits a movem"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOOD>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOOD>>(v4);
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

