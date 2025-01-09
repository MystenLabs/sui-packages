module 0xd0209b1afbfa02510390091cfc733d4fe79da0ea5f3e681553f50b39d2e00a7b::pepeng {
    struct PEPENG has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<PEPENG>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PEPENG>>(0x2::coin::mint<PEPENG>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: PEPENG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/4sD9rpU44vEwRzRuCnTpkYkUeJcrZb6oXEdB7yTbVzCw.png?size=lg&key=481716                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<PEPENG>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"PEPENG  ")))), trim_right(b"Penguin with PePe               "), trim_right(b"In the crypto world, a new meme hero has emerged: PEPENG. This smug penguin with PEPE's iconic face became a beacon of hope for anyone dreaming of massive gains. His story began in the icy Arctic depths, where PEPENG stumbled upon a mysterious coin inscribed with ancient symbols.                                        "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEPENG>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<PEPENG>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<PEPENG>>(0x2::coin::mint<PEPENG>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

