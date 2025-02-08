module 0xa93d4f6ab784c0d804e7ef1a4d6d4c7494b2c4cd2d173825d74641535587978d::teddybear {
    struct TEDDYBEAR has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<TEDDYBEAR>, arg1: 0x2::coin::Coin<TEDDYBEAR>) {
        0x2::coin::burn<TEDDYBEAR>(arg0, arg1);
    }

    fun mint_and_transfer(arg0: &mut 0x2::coin::TreasuryCap<TEDDYBEAR>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<TEDDYBEAR>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: TEDDYBEAR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/32bjWJAPvja9SwanmZBsdSpwgbiLKokBXnFf29z8YkHR.png?size=lg&key=055df7                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<TEDDYBEAR>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"TEDDYBEAR ")))), trim_right(b"TEDDY BEAR                      "), trim_right(b"#1 MEM eon Pulse Chain! Everyone loves SA Teddy Bear! Now coming to Solana                                                                                                                                                                                                                                                      "), v2, arg1);
        let v5 = v3;
        let v6 = &mut v5;
        let v7 = 0x2::tx_context::sender(arg1);
        mint_and_transfer(v6, 1000000000000000000, v7, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEDDYBEAR>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TEDDYBEAR>>(v5);
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

