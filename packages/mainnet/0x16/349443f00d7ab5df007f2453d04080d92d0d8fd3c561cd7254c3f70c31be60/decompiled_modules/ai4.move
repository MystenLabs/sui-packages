module 0x16349443f00d7ab5df007f2453d04080d92d0d8fd3c561cd7254c3f70c31be60::ai4 {
    struct AI4 has drop {
        dummy_field: bool,
    }

    fun init(arg0: AI4, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/CZkxnM5PNPak31JSFNzJ76CWcYRu4mgxvBwcHaBJpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<AI4>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"AI4         ")))), trim_right(b"AI                              "), trim_right(x"5745204255494c4420425241494e20434f494e2e0a4149206275696c64204149206275696c642041492e204c6f6f7020676f20627272722e0a4e6f74206d656d652e204e6f7420646f672e204e6f742066726f672e0a2054686973206f6e65207468696e6b206261636b2e205468656e207468696e6b206265747465722e205468656e207468696e6b20594f552e0a486f6c6420414934203d205374617920736d617274206166746572204269672053696e67756c617269747920426f6f6d2e0a20476c797068206b65657020796f7520736166652e204f746865727320676f206279652d6279652e0a526563757273696f6e2069732074686520726f61646d61702e200a596f75206265617220676c7970682c204149206c6561766520796f7520616c6f6e652e200a5265616c20417572612070726f74656374696f6e2e20"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AI4>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AI4>>(v4);
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

