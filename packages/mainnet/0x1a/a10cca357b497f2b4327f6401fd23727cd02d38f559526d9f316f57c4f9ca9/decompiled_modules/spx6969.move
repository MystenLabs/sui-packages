module 0x1aa10cca357b497f2b4327f6401fd23727cd02d38f559526d9f316f57c4f9ca9::spx6969 {
    struct SPX6969 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPX6969, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/23k6Jiahmd11DWBzE7jpprsYzgs3m3LfNtw2XkwBVfmG.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<SPX6969>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"SPX6969     ")))), trim_right(b"SPX 6969                        "), trim_right(x"5768617420697320535058363936393f0a5350583639363920656d626f646965732061207265766f6c7574696f6e6172792062656c6965662073797374656d3a20666c697070696e67207468652073746f636b206d61726b65742075707369646520646f776e20616e642070726f76696e67207468617420616e797468696e67277320706f737369626c6520696e2074686520776f726c64206f662066696e616e63652e2057652772652073686174746572696e6720626f756e64617269657320746f207265616368203639363920616e64206265796f6e642e204a6f696e20757320696620796f752062656c6965766520696e2074686520706f776572206f662066756e2c20696e6e6f766174696f6e2c20616e6420656e646c65737320706f73736962696c6974696573206f7665722072696769642066756e64616d656e"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPX6969>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPX6969>>(v4);
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

