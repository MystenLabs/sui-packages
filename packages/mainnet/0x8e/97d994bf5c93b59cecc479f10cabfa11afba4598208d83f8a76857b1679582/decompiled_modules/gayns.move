module 0x8e97d994bf5c93b59cecc479f10cabfa11afba4598208d83f8a76857b1679582::gayns {
    struct GAYNS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GAYNS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/A5JKRAXup65RJndhfBMR1yo1zxZyds2yyZc1niXypump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<GAYNS>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"GAYNS       ")))), trim_right(b"Gainocologist                   "), trim_right(x"244741594e53200a0a5468697320697320746865206f6e6c79204f4646494349414c204761696e6f636f6c6f67792070726f6a6563742e200a0a546865206d6173746572206f66204761696e6f636f6c6f67792c20546865204761696e6f636f6c6f676973742068696d73656c662e200a0a546869732069732074686520756c74696d61746520636f696e20666f722074686f73652077686f207365656b2061206d61737369766520646f7365206f662066696e616e6369616c206761696e2e20466f726765742074686520707265736372697074696f6e20706164202d206a75737420484f444c20616e6420776174636820796f75722063727970746f206865616c746820736b79726f636b6574210a0a63613a2041354a4b52415875703635524a6e646866424d5231796f317a785a7964733279795a63316e6958797075"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GAYNS>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GAYNS>>(v4);
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

