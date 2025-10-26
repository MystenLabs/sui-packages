module 0x3844faa501ae22e045cc6c529787eebd4a9034efb7d6440d45567f401ff9ff2b::richy {
    struct RICHY has drop {
        dummy_field: bool,
    }

    fun init(arg0: RICHY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"bcc1b86440ac91f41c3a19157776fae2c0725fd123e3b02b9932f1f3f4bc9f89                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<RICHY>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"RICHY       ")))), trim_right(b"GhostofRichy                    "), trim_right(b"The Ghost made by Grok, Grok's newest companion                                                                                                                                                                                                                                                                                 "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RICHY>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RICHY>>(v4);
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

