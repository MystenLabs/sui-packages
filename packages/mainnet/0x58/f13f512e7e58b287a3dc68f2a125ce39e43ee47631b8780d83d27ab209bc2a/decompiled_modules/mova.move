module 0x58f13f512e7e58b287a3dc68f2a125ce39e43ee47631b8780d83d27ab209bc2a::mova {
    struct MOVA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOVA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/HRWgXzniyBV12YaW4SPaEYfe847BpByMiKcPkqrpump.png                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<MOVA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"mova        ")))), trim_right(b"MOVA                            "), trim_right(x"4d6f76612069732061206c6f6769737469637320636f6d70616e7920676f696e672066756c6c20536f6c616e6120626c6f636b636861696e2e200a0a244d4f56412069732061206465666c6174696f6e61727920746f6b656e2c20737570706f72746564206279206275796261636b7320616e64206275726e732066756e6465642062792074686520636f6d70616e79732064656c6976657279206561726e696e67732e204576657279207075726368617365206f6620244d4f564120776f727468202435303020555344206f72206d6f7265207175616c696669657320666f7220616e206571756976616c656e7420696e766573746d656e74206f6e206f757220706c6174666f726d2e20486f6c64657273206172652072657761726465642077697468206461696c792070726f6669747320776974686f757420616e7920"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOVA>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOVA>>(v4);
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

