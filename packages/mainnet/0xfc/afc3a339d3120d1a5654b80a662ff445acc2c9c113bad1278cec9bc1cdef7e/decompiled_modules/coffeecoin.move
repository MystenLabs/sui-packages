module 0xfcafc3a339d3120d1a5654b80a662ff445acc2c9c113bad1278cec9bc1cdef7e::coffeecoin {
    struct COFFEECOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: COFFEECOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/8s5X3yLEx2rx8BxGT5uSwR9Z5FP5T64VLr4kkPStpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<COFFEECOIN>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"coffeecoin  ")))), trim_right(b"coffeecoin                      "), trim_right(b"CoffeeCoin Labs LLC is a registered Web3 company on a mission to unite coffee enthusiasts and crypto pioneers, ceating a vibrant ecosystem where coffee and blockchain technology converge. By bridging on-chain and off-chain experiences, CoffeeCoin Labs connects coffee lovers with exceptional brands, shops, and producers"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COFFEECOIN>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COFFEECOIN>>(v4);
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

