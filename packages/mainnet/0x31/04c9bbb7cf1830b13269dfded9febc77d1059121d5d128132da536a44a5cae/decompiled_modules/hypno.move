module 0x3104c9bbb7cf1830b13269dfded9febc77d1059121d5d128132da536a44a5cae::hypno {
    struct HYPNO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HYPNO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"b16ceb3b25b1705d500564deec07cd5a397c8735433957a661839bfd747e6805                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<HYPNO>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"HYPNO       ")))), trim_right(b"HYPNOTOAD                       "), trim_right(x"204265666f726520506570652c20746865726520776173204879706e6f746f61642e0a4f6e204a616e2032342c20323031352028626c6f636b203334302c373339292c20736f6d656f6e6520656d62656464656420616e2041534349492064726177696e67206f6620746865204675747572616d61204879706e6f746f616420696e746f2074686520426974636f696e20626c6f636b636861696e20207468652066697273742066726f672d6c696b652063726561747572652065766572207265636f72646564206f6e2d636861696e2e0a0a49742070726564617465732074686520526172652050657065206361726473206f66203230313620616e64206d61726b7320746865206269727468206f66206d656d652063756c7475726520696e7369646520426974636f696e2e0a4120706572666563742073796d626f6c20"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HYPNO>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HYPNO>>(v4);
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

