module 0xe574bb3f49ec8907c6e6163fe184a16cef535e994418bcfbfd0bad0676cdf953::oilcoin {
    struct OILCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: OILCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/Cwn9d1E636CPBTgtPXZAuqn6TgUh6mPpUMBr3w7kpump.png?claimId=o8QtpXANwQ0j4Lwu                                                                                                                                                                                                      ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<OILCOIN>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"OILCOIN     ")))), trim_right(b"Oil Coin                        "), trim_right(x"4f494c20434f494e2028244f494c432920697320746865206f6666696369616c20636f6d6d6f6469747920746f6b656e206f662050726f6a656374204320204372797374616c20436c65617220436f6d6d6f6469746965732e0a0a4261636b6564206279206120737570706c792d6275726e2070726f746f636f6c20616e6420736d61727420636f6e7472616374207669736962696c6974792c20244f494c4320726570726573656e747320746865206e6578742065766f6c7574696f6e206f66207265616c2d776f726c64206173736574206f776e657273686970206f6e2d636861696e2e0a0a5265616c20436f6d6d6f64697479204e61727261746976652e0a4f696c2d4261636b6564205574696c697479204c6f6769632e0a546f6b656e204275726e7320416c72656164792045786563757465642e20202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OILCOIN>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OILCOIN>>(v4);
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

