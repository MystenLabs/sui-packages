module 0x3f7e4eee6bf7ed0161a6b4c39a67786b6473882573e0fa8e0ed36006b5870bfe::rizzler {
    struct RIZZLER has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<RIZZLER>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<RIZZLER>>(0x2::coin::mint<RIZZLER>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: RIZZLER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/BMniPiFA2TGq9Kqstq48JzEpdQQg1KrQcsGNbkKapump.png?size=lg&key=b4a47d                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<RIZZLER>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"RIZZLER ")))), trim_right(b"Rizzler                         "), trim_right(b"The 8-year-old internet sensation, Rizzler, has taken the world by storm. A recent meme comparing Rizzler to a Mayan Rizzler from the 2006 film Apocalypto has gone viral, proving that Rizzler's charm is timeless, even echoing through ancient Mayan and Egyptian civilizations                                              "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RIZZLER>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<RIZZLER>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<RIZZLER>>(0x2::coin::mint<RIZZLER>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

