module 0x8cced2c06b3230ce202db0f2b3a1cdac46b98d93010df9f7a37dcacd5a2effa8::kekius {
    struct KEKIUS has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<KEKIUS>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<KEKIUS>>(0x2::coin::mint<KEKIUS>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: KEKIUS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/ethereum/0x26e550ac11b26f78a04489d5f20f24e3559f7dd9.png?size=lg&key=0d93ef                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<KEKIUS>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"KEKIUS  ")))), trim_right(b"Kekius Maximus                  "), trim_right(b"Kekius Maximus has quickly gotten the attention of the crypto space at large with Elon's whimsical take on PEPE the frog emperor having been tweeted by @elonmusk himself on a number of occasions with acknowledgement from the official @PEPE token X accounts and many more.                                                 "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KEKIUS>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<KEKIUS>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<KEKIUS>>(0x2::coin::mint<KEKIUS>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

