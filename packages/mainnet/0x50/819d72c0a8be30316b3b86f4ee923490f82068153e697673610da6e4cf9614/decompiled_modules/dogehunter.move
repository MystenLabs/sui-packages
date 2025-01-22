module 0x50819d72c0a8be30316b3b86f4ee923490f82068153e697673610da6e4cf9614::dogehunter {
    struct DOGEHUNTER has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<DOGEHUNTER>, arg1: 0x2::coin::Coin<DOGEHUNTER>) {
        0x2::coin::burn<DOGEHUNTER>(arg0, arg1);
    }

    fun mint_and_transfer(arg0: &mut 0x2::coin::TreasuryCap<DOGEHUNTER>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<DOGEHUNTER>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: DOGEHUNTER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/DvebBWPW1t2Cjfxq3M7SRPwqWJ2xdHinwWHSTWTapump.png?size=lg&key=32fe07                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<DOGEHUNTER>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"DOGEHUNTER")))), trim_right(b"Doge the Bounty Hunter          "), trim_right(b"me and trump are out here locking down the borders, brother. no illegals getting past us. were building walls and breaking balls.                                                                                                                                                                                               "), v2, arg1);
        let v5 = v3;
        let v6 = &mut v5;
        let v7 = 0x2::tx_context::sender(arg1);
        mint_and_transfer(v6, 1000000000000000000, v7, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGEHUNTER>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<DOGEHUNTER>>(v5);
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

