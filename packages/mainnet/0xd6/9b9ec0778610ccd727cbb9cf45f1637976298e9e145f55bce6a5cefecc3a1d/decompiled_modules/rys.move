module 0xd69b9ec0778610ccd727cbb9cf45f1637976298e9e145f55bce6a5cefecc3a1d::rys {
    struct RYS has drop {
        dummy_field: bool,
    }

    fun init(arg0: RYS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/8gHPxqgHj6JQ2sQtMSghQYVN5qRP8wm5T6HNejuwpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<RYS>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"RYS         ")))), trim_right(b"RefundYourSOL                   "), trim_right(x"546865206d6f737420616476616e6365642066656520726566756e6420616e6420746f6b656e2d6275726e696e6720706c6174666f726d206f6e20536f6c616e612c20706f6973656420746f207265766f6c7574696f6e697a652074686520656e746972652065636f73797374656d2e0a0a526566756e6420796f757220534f4c206665657320776974682075732e200a0a2d20353025206f6620616c6c20726576656e75652069732065697468657220676976656e206261636b20746f20686f6c646572732c206275726e65642c206f7220696e76657374656420696e746f204c500a2d2035302520626f6e7573206f6e20616c6c20656c696769626c652066656520726566756e64730a2d2053574150206f6e206f7572206f776e207765627369746520666f72205259532c206272696e67696e67206275792d6261636b"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RYS>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RYS>>(v4);
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

