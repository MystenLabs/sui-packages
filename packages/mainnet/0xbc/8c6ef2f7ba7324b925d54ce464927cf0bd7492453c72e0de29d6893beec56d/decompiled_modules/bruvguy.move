module 0xbc8c6ef2f7ba7324b925d54ce464927cf0bd7492453c72e0de29d6893beec56d::bruvguy {
    struct BRUVGUY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRUVGUY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/5VmMME9V6CLMJdEngDabKQAfB839CK3CrgtUZpRteYTN.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<BRUVGUY>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"BRUVGUY     ")))), trim_right(b"Just A Bruv Guy                 "), trim_right(x"496d204a757374204120427275764775790a0a62727576202b206368696c6c677579200a0a686f646c2f746f7020686f6c6465727320686f6c64696e672074686520666c6f6f7220772f44455820626f6f737473203d206f7267616e696320636f6d6d756e6974790a0a43613a0a0a35566d4d4d45395636434c4d4a64456e674461624b51416642383339434b3343726774555a7052746559544e202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRUVGUY>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BRUVGUY>>(v4);
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

