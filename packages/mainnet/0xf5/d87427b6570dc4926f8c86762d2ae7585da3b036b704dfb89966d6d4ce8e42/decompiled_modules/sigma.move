module 0xf5d87427b6570dc4926f8c86762d2ae7585da3b036b704dfb89966d6d4ce8e42::sigma {
    struct SIGMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIGMA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/AVXTmHgXvjDGhn4wjfvn8UXSi5Yh5X25kaiQdNvBpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<SIGMA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"SIGMA       ")))), trim_right(b"SIGMA COIN                      "), trim_right(x"5369676d6120436f696e20697320746865206469676974616c20656d626f64696d656e74206f6620746865207369676d61206d616c65206172636865747970657374726174656769632c2073656c662d72656c69616e742c20616e6420756e7368616b656e2e20496e206120776f726c6420616464696374656420746f206e6f6973652c205369676d61207374616e6473206669726d20696e20666f6375732e204e6f206469737472616374696f6e732e204e6f20636f6d70726f6d6973652e0a0a546869732069736e742061626f757420687970652e204974732061626f757420707265636973696f6e2e204576657279206d6f76652069732063616c63756c617465642e204576657279206761696e2c206561726e65642e2020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIGMA>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SIGMA>>(v4);
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

