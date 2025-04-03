module 0xdb333886d62b73e3e09a387c8db930d2ed6f680d5b6cd4cdd28461f3f4fef24d::pnh {
    struct PNH has drop {
        dummy_field: bool,
    }

    fun init(arg0: PNH, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/ARnYeJKES4jjn4wViCamV78E79xaFzUFkq2o9Mwopump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<PNH>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"PNH         ")))), trim_right(b"Dave's Pump-n-Hodl Coin         "), trim_right(x"24504e48206973206120636f696e2077697468207072652d616e6e6f756e6365642050554d50532c20796f75276c6c2077616e7420746f20484f444c2120504c55532c207765277265206d616b696e67206c6172676520646f6e6174696f6e7320746f2074776f206f66204461766520506f72746e6f792773206661766f72697465204348415249544945532e2e20746f206761696e2068697320737570706f727421200a0a224461766527732050756d702d6e2d486f646c20436f696e22202824504e48292077696c6c2064697374726962757465203525206f662074686520746f6b656e20737570706c7920746f2077616c6c65747320666f72207468652054756e6e656c20746f20546f7765727320466f756e646174696f6e20616e6420352520746f20746865204c6966654c696e6520416e696d616c2050726f6a65"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PNH>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PNH>>(v4);
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

