module 0x531c46a3cf22a0d29eb332c570d8fba628dd92fabc5f373a20b67cda01257dd1::aie {
    struct AIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/4eGMg4neWET7tVjPA3Dj7Yp2RBem2v36iWW4TgmVpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<AIE>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"AIE         ")))), trim_right(b"AI Explorer                     "), trim_right(b" Welcome to AI Explorer, the revolutionary search tool that defies all your expectations! This cutting-edge project completely redefines the Internet search experience by offering you the possibility of finding absolutely nothing of what you are looking for. With AI Explorer, forget about the frustration of getting use"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIE>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AIE>>(v4);
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

