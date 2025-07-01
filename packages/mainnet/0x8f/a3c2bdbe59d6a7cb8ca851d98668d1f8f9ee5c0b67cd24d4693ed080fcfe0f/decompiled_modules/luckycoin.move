module 0x8fa3c2bdbe59d6a7cb8ca851d98668d1f8f9ee5c0b67cd24d4693ed080fcfe0f::luckycoin {
    struct LUCKYCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUCKYCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/3BtunCQ3KdpsYtXQU9SmkGopnDkaQHuEgG14Dy1Lbonk.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<LUCKYCOIN>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"LuckyCoin   ")))), trim_right(b"                                "), trim_right(x"4368696e657365206c75636b7920636f696e732c20616c736f206b6e6f776e206173202266656e67207368756920636f696e732c2220617265206120706f70756c61722073796d626f6c206f66207765616c746820616e642070726f7370657269747920696e204368696e6573652063756c747572652e200a0a546865736520636f696e7320617265206f6674656e207573656420696e2066656e6720736875692070726163746963657320746f206174747261637420676f6f6420666f7274756e6520616e64206162756e64616e63652e200a0a4b656570207468697320636f696e20696e20796f75722077616c6c657420616e6420776174636820686f7720796f757220666f7274756e6520696d70726f7665732e2020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUCKYCOIN>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LUCKYCOIN>>(v4);
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

