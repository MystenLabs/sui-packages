module 0xea6ed72e05517fcea5a6d9c2b74f510e8bfd18b2a7345181ee30e2a7996bc552::dtr {
    struct DTR has drop {
        dummy_field: bool,
    }

    fun init(arg0: DTR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/FkqvTmDNgxgcdS7fPbZoQhPVuaYJPwSsP8mm4p7oNgf6.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<DTR>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"DTR         ")))), trim_right(b"dextoro                         "), trim_right(x"54686520506f77657220426568696e6420646578746f726f202d20546865206e6578742d67656e65726174696f6e20536f6c616e61206d656d65636f696e2074726164696e67206170702c2064657369676e656420666f722065766572796f6e652e0a0a2444545220697320746865207574696c69747920616e642072657761726420746f6b656e2074686174206675656c732074686520646578746f726f2065636f73797374656d202d206f66666572696e67207265616c2c206175746f6d617465642062656e656669747320746f206576657279207472616465722c20636f6e7472696275746f722c20616e642062656c69657665722e204e6f207374616b696e672c206e6f2067616d65732e204a75737420686f6c6420616e64206561726e2e200a0a244454522069736e2774206a75737420616e6f74686572207265"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DTR>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DTR>>(v4);
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

