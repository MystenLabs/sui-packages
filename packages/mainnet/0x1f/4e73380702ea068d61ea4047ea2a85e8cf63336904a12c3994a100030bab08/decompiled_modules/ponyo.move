module 0x1f4e73380702ea068d61ea4047ea2a85e8cf63336904a12c3994a100030bab08::ponyo {
    struct PONYO has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<PONYO>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PONYO>>(0x2::coin::mint<PONYO>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: PONYO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/EaezaNAZSrxkWpdvzzDFsYP5bCx8BjskcE1iQa9J8UZK.png?size=lg&key=999b7e                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<PONYO>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"PONYO   ")))), trim_right(b"Ponyo Wif Hat                   "), trim_right(b"Ponyo is a magical goldfish curious about the human world. In this meme token version, she returns as a cute icon with a big heart, rocking a hat, and ready to make waves in the crypto space. Adorable, magical and full of spirit!                                                                                           "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PONYO>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<PONYO>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<PONYO>>(0x2::coin::mint<PONYO>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

