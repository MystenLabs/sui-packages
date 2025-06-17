module 0x83c5f2551bc725205d69ea7e6cbae455f2b4616b257ad0ec9dbc5dc01f061c51::sl {
    struct SL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/7ACyFibKSpZ56uJp1L1rM5bFKtJQxRj7T3kc7UYCpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<SL>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"SL          ")))), trim_right(b"Steak And Lobster               "), trim_right(x"546865205553206d696c69746172792063616e7465656e20626567616e2073657276696e67206c6f62737465722066656173747320616e6420737465616b206665617374732e200a557375616c6c792c207468652070726f766973696f6e206f662073756368206c75787572696f7573206d65616c732069732061207369676e207468617420746865205553206d696c69746172792069732061626f757420746f206265206465706c6f79656420746f207468652066726f6e74206c696e6573206f6620636f6d6261742e202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SL>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SL>>(v4);
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

