module 0x81c30b8278db9887532fa6c3b3f12b08e867a76b16c5f95bb5c787fc59310843::wells {
    struct WELLS has drop {
        dummy_field: bool,
    }

    fun init(arg0: WELLS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"5160104ca4295ad62469df2c4dc49c88926527b6c5ed49b2990042a159a22604                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<WELLS>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"WELLS       ")))), trim_right(b"WELLSRETARDO                    "), trim_right(x"2057656c6c73205265746172646f202054686520776f726c64732066697273742062616e6b2072756e20627920646567656e732c20666f7220646567656e732c20616e6420706f737369626c7920616761696e737420796f757220626574746572206a7564676d656e74210a0a20576520646f6e74206a75737420737570706f7274206d6f6f6e73686f7473202077652063686565722077696c646c79207768696c652079656574696e6720796f757220706f7274666f6c696f20696e746f206f726269742e0a20446970733f20576520484f444c206c696b6520636f6e667573656420737175697272656c7320636c75746368696e67204e4654732e0a20313030783f2054686174732074686520626173656c696e652c20626162792e20576572652061696d696e6720666f7220737475706964206d6f6e65792077697468"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WELLS>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WELLS>>(v4);
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

