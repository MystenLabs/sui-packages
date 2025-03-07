module 0x9c79496e1d2fc1b9c017d579ba6b4c0f6af758915da55bc5c2a0dbc01f9ece9e::usdas {
    struct USDAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: USDAS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/Bh5GfNv8uRSdmKJ9ZtAHaMu4e4J4MaGum3XeWocRpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<USDAS>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"USDAS       ")))), trim_right(b"U.S. Digital Asset Stockpile    "), trim_right(b"Greatest Country in The World.                                                                                                                                                                                                                                                                                                  "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USDAS>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<USDAS>>(v4);
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

