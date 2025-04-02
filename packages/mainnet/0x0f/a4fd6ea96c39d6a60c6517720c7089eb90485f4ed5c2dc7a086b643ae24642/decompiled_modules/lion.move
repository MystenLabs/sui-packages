module 0xfa4fd6ea96c39d6a60c6517720c7089eb90485f4ed5c2dc7a086b643ae24642::lion {
    struct LION has drop {
        dummy_field: bool,
    }

    fun init(arg0: LION, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/7kN5FQMD8ja4bzysEgc5FXmryKd6gCgjiWnhksjHCFb3.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<LION>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"LION        ")))), trim_right(b"Loaded Lions                    "), trim_right(b"Loaded Lions, the flagship NFT collection of Cryptocom has launched their native token, $LION. $LION serves as the financial backbone of the project and the core utility token within the ecosystem. LION will be available on the Cronos EVM chain at launch, with plans to expand $LION to Ethereum, Solana and other ecosyst"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LION>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LION>>(v4);
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

