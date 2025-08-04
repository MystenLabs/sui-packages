module 0x20ecff2251d42eebd840d726fba4fe1e752b05271abba1cac9209db98ebf0bc8::buttbench {
    struct BUTTBENCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUTTBENCH, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"5f9f3dccc4727aa2cc5f0b911b2ddc88d2e546572b49f0cc0056ce469dcf4501                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<BUTTBENCH>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"ButtBench   ")))), trim_right(b"ButtBench                       "), trim_right(b"at some point I will no doubt release a white paper about ButtBench                                                                                                                                                                                                                                                             "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUTTBENCH>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUTTBENCH>>(v4);
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

