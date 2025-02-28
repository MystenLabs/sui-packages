module 0xd3ce35073105ac38dd9bad9ee8d6dd0a5c71072e27bc0d94cf13f916939e8291::pixnix {
    struct PIXNIX has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<PIXNIX>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PIXNIX>>(0x2::coin::mint<PIXNIX>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: PIXNIX, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/C7W8LEEz7Mi88KVUPS47jAG8QM9BZZHCXG1Kz9Es6nhA.png?size=lg&key=11d6b0                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<PIXNIX>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"PIXNIX  ")))), trim_right(b"PIXNIX                          "), trim_right(b"Join the exciting adventure in the pixel world with PIXNIX! Guide Rex, Nix, and their wise cat, Lyra, on a quest for the legendary artifact. Explore diverse landscapes, complete challenging missions, and collect rare artifacts that can be exchanged for Sui.                                                               "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PIXNIX>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<PIXNIX>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<PIXNIX>>(0x2::coin::mint<PIXNIX>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

