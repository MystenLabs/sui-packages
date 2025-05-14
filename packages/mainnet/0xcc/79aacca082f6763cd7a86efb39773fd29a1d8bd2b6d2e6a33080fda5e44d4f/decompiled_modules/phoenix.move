module 0xcc79aacca082f6763cd7a86efb39773fd29a1d8bd2b6d2e6a33080fda5e44d4f::phoenix {
    struct PHOENIX has drop {
        dummy_field: bool,
    }

    fun init(arg0: PHOENIX, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/H5tnN12NCWqa6zhpmY2ykvmreEUiRaquqtQiPayWpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<PHOENIX>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"PHOENIX     ")))), trim_right(b"Olivers Cat                     "), trim_right(x"4f6c6976657220717569742068697320636f72706f72617465206a6f622c206c69717569646174656420686973203430316b2c20626f756768742061207361696c626f617420616e64206973206e6f77207361696c696e672061726f756e642074686520776f726c64207769746820686973206361742050686f656e697820616e64206c6976652073747265616d696e67206f6e2054696b546f6b20283635304b2b20666f6c6c6f776572732920616e6420496e7374616772616d20283930304b2b20666f6c6c6f77657273292e0a0a466f6c6c6f77657273206172652067726f77696e67206578706f6e656e7469616c6c792e2048697320766964656f732068617665206d696c6c696f6e73206f6620766965777320656163682e0a0a22546865726520617265206e6f2072756c657322202d4f6c69766572202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PHOENIX>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PHOENIX>>(v4);
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

