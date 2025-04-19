module 0xc8d035212ede7479bb38528aa98234d00e2b15c02f4e0386dadb786dc31bd5d3::fightcoin {
    struct FIGHTCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FIGHTCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/H2cVBowtiPDksh5DqxnYcUrv999EtL4vWywHRfQBpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<FIGHTCOIN>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"fightcoin   ")))), trim_right(b"fightcoin                       "), trim_right(x"246669676874636f696e2020546865204669727374206f6e2024536f6c616e6120746f20656d706f77657220666967687465727320616e64206d656e74616c206865616c74682077617272696f72732e204c6f636b20496e2e2046696768742e2057696e2e200a0a47726f77696e67206120636f6d6d756e6974792c2072616973696e672061776172656e65737320666f72206d656e74616c206865616c74682c20616e6420666577206f746865722052574120706c616e732e2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FIGHTCOIN>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FIGHTCOIN>>(v4);
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

