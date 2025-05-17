module 0x22271ddc8a6f7bc77a48f661f1e3197058e431e41c25dd4aa4222071bb058b3e::nitro {
    struct NITRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: NITRO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/HN6KHgSwzsqCQJ4xLmccXGJRe3SYbn7yqGiTrNnHJFjB.png?claimId=Bp_-FxPqtaYiLQK-                                                                                                                                                                                                      ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<NITRO>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"NITRO       ")))), trim_right(b"NITRO                           "), trim_right(x"4e6974726f2046726f67204f4720697320746865206669727374204e6974726f2028736f6e206f6620547572626f2920616e64207761732063726561746564206f6e2053657074656d62657220313674682c20323032342e204e6974726f20697320616e2041492d67656e657261746564206d656d6520636f696e20616e642077617320696e73706972656420627920547572626f2e200a0a54686973206973206120636f6d6d756e6974792d64726976656e20636f696e2c20616e64206974277320612070726f6a6563742062792074686520636f6d6d756e6974792c20666f722074686520636f6d6d756e6974792e20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NITRO>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NITRO>>(v4);
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

