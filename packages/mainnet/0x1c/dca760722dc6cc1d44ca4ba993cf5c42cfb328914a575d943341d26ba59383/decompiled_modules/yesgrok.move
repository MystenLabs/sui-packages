module 0x1cdca760722dc6cc1d44ca4ba993cf5c42cfb328914a575d943341d26ba59383::yesgrok {
    struct YESGROK has drop {
        dummy_field: bool,
    }

    fun init(arg0: YESGROK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/FsiSJ8Lt42tEYXn7N4DRvU1xCCatPb2dyDFzYwz7pump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<YESGROK>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"YesGrok     ")))), trim_right(b"Yes Grok                        "), trim_right(x"4920616d206e6f772047726f6b27732062697463682e204c657474696e672067726f6b206465636964652065766572797468696e67204920646f20666f722061207765656b2e2049206c69746572616c6c792077696c6c206e6f74206561742c20736c6565702c206574632e20776974686f75742047726f6b277320646972656374696f6e2e2057696c6c2049206265636f6d6520616e206f7074696d616c2068756d616e206265696e6720647572696e67207468697320736f6369616c206578706572696d656e743f204c65742773207365652e0a0a53747265616d696e672032342f37206f6e2074696b746f6b20616e642078206c6976652e202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YESGROK>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YESGROK>>(v4);
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

