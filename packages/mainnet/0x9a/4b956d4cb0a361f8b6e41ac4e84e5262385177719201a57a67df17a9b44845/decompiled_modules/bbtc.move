module 0x9a4b956d4cb0a361f8b6e41ac4e84e5262385177719201a57a67df17a9b44845::bbtc {
    struct BBTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBTC, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"5f9b2e33f48c18c087b6b8b82b7d6781292fe924ec133b3749a8d6e947c2cf64                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<BBTC>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"bbtc        ")))), trim_right(b"Blue Bitcoin                    "), trim_right(x"48656c6c6f204d65657420426c756520426974636f696e20284242544329200a54686520426974636f696e206f6e20536f6c616e6120626c6f636b636861696e202057697468206120436f6f6c20426c7565205477697374210a5769746820412043617070656420537570706c79204f66203231204d696c6c696f6e0a416e642061204275696c742d496e204275726e204d656368616e69736d20546f20456e68616e6365200a56616c75652e312e3730302e303030204275726e65642042425443200a546865726520617265206f6e6c792031392e33206d696c6c696f6e2042425443206c6566742c200a7768696368206d65616e73207468657920617265207261726520616e64200a77696c6c206e657665722062652072652d70726f64756365642e0a4a756d7020496e20416e6420526964652054686520426c756520"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBTC>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BBTC>>(v4);
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

