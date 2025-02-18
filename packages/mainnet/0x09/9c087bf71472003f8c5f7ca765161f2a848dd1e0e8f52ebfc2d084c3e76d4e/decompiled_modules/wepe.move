module 0x99c087bf71472003f8c5f7ca765161f2a848dd1e0e8f52ebfc2d084c3e76d4e::wepe {
    struct WEPE has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<WEPE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<WEPE>>(0x2::coin::mint<WEPE>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: WEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/ethereum/0xccb365d2e11ae4d6d74715c680f56cf58bf4bf10.png?size=lg&key=e92bea                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<WEPE>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"WEPE    ")))), trim_right(b"Wall Street Pepe                "), trim_right(b"Wall Street Pepe ($WEPE) is a meme coin on the Ethereum blockchain that merges meme culture with real trading utilities. Inspired by the iconic Pepe meme and the spirit of Wall Street trading, $WEPE provides small traders with exclusive trading insights, market strategies, and a collaborative community.                "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WEPE>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<WEPE>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<WEPE>>(0x2::coin::mint<WEPE>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

