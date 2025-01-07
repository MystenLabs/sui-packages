module 0x3b680b3fda6ab46b95567d192dc76906c83514fe1c31b81ba2379d670c38ea1b::cedar {
    struct CEDAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: CEDAR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/BD3zHHcK6aqz1RVBawMyhp5DfXFaDYaBXzwBH8cEpump.png?size=lg&key=971a15                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<CEDAR>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"CEDAR   ")))), trim_right(b"CEDAR                           "), trim_right(b"In 2022, a young California girl's pet goat, Cedar, was auctioned at a fair. When the family tried to save him, sheriff's deputies tracked Cedar down and took him back to be killed, sparking public outrage. JUSTICE FOR CEDAR                                                                                                "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CEDAR>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CEDAR>>(v4);
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

