module 0x26636b29f56711982aa52545cc16a935a8409e2a9d75c388978fc3f83fbf42da::onlyfans {
    struct ONLYFANS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ONLYFANS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"oRuBoAbE2DvY5ujk                                                                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<ONLYFANS>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"ONLYFANS    ")))), trim_right(b"ONLYFANS OFFICIAL               "), trim_right(x"4f6e6c7966616e7320697320746865206f6666696369616c20746f6b656e206f6620746865204f6e6c7966616e732e636f6d20776562736974652e204f6e6c7946616e73206973206120737562736372697074696f6e20736f6369616c20706c6174666f726d207265766f6c7574696f6e6973696e672063726561746f7220616e642066616e20636f6e6e656374696f6e732e204f4620546f6b656e20726577617264732070726f6772616d20616e6e6f756e63656d656e7420636f6d696e67206166746572205261796469756d206c697374696e672e0d0a0d0a0d0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ONLYFANS>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ONLYFANS>>(v4);
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

