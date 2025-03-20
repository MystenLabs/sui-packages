module 0xc7ac6b1af209fe429c8e41ec6c749e310efc9eb43b42c933534be4514553e2b7::primechat {
    struct PRIMECHAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PRIMECHAT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/5iyN5nX7cj7sEGS8MqL9rGop4d6ZbJxSFZMi3htupump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<PRIMECHAT>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"PRIMECHAT   ")))), trim_right(b"PRIMECHAT                       "), trim_right(x"5052494d4520434841542028245052494d454348415429200a0a4e6f74206a75737420616e6f74686572202241492220746f6b656e202074686973206f6e652773206120776f726b696e67206265617374207769746820686170707920637573746f6d65727321200a0a426f726e2066726f6d206120626174746c652d7465737465642041492063686174626f7420616c726561647920636f6e76657274696e672076697369746f7273206f6e2068756e6472656473206f662077656273697465732c20245052494d4543484154206973206d6f7265207468616e206120746f6b656e202069742773206261636b6564206279207265616c207465636820736f6c76696e67207265616c2070726f626c656d732e200a0a43656c6562726174696e672074776f207965617273206f66205072696d65204368617420616e642053"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PRIMECHAT>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PRIMECHAT>>(v4);
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

