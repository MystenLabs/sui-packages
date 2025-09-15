module 0xc24021d2b8359c4912e0435aaa9a51be1d31d8e08c416f5168f6e9a0bef489e6::dahog {
    struct DAHOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAHOG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"906db66ef4e6a6ceb11a0ae3ca7f4377473d0a34e686ef3a9150878536067bc0                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<DAHOG>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"DAHOG       ")))), trim_right(b"DAILY HONK GROW                 "), trim_right(x"4d6565742074686520776f726c6473206669727374207265616c2070657420676f6f7365206d656d6521200a46726f6d20746865207665727920666972737420646179206f66206861746368696e672c20746869732070657420676f6f73652069732066696c6d65642065766572792073696e676c652064617920706c6179696e672c20656174696e672c20616e64206578706c6f72696e6720736f20796f752063616e2077617463682069742067726f772066726f6d2074696e7920666c75666620746f2066756c6c2066656174686572656420737461722e0a54756e6520696e20746f206f7572206461696c79206c6976652073747265616d206f6e2050756d7066756e2061742061207365742074696d6520616e6420666f6c6c6f7720657665727920686f6e6b2c206576657279206d65616c2c206576657279206d69"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAHOG>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DAHOG>>(v4);
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

