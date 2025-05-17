module 0x58dbcc3a5d9c7bd92ecef65122867e3803f671c5388ee19f664a56bbd8b3f196::babykekmax {
    struct BABYKEKMAX has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYKEKMAX, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/Gdykwkw9WZK6weYwkRJEzyJ5dC9ZHEx2KNBSJvZjpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<BABYKEKMAX>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"BabyKekMax  ")))), trim_right(b"Baby Kekius Maximus             "), trim_right(x"4f472042616279204b656b697573204d6178696d7573200a0a54686520736d616c6c65737420676c61646961746f7220776974682074686520626967676573742068656172742c2042616279204b656b697573204d6178696d75732069732061206c6567656e6420696e20746865206d616b696e672e2041726d65642077697468206869732074727573747920746f792073776f72642c206865206272696e6773206c6175676874657220616e6420636f757261676520746f2074686520436f6c6f737365756d2c2070726f76696e67206865726f657320636f6d6520696e20616c6c2073697a65732e2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYKEKMAX>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABYKEKMAX>>(v4);
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

