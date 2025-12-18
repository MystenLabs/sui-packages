module 0xd31a019213735e5e1f0708afba82b8ad2746ff5b907f9508d048378000c18242::catwifdog {
    struct CATWIFDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATWIFDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"926a2365a4d13664049dade376d02815c2cd85f7b2eb9f06ae2d025925c04a41                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<CATWIFDOG>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"CATWIFDOG   ")))), trim_right(b"CATWIFDOG                       "), trim_right(x"434154574946444f472e20436f6d62696e696e6720746865206c6f766520666f7220626f7468204361747320616e6420446f67732074686973206d6574612021200a0a35302070657263656e74206f662043726561746f72205265776172647320746f2074686520436f6d6d756e69747920776f726b696e6720666f72207468656972206261677320696e206f7572205820434f4d4d20616e6420676976696e67206261636b20616e696d616c20666f6f6420746f206c6f63616c207368656c74657220696620766f6c756d6520616c6c6f77732d2070726f6f66206f6620776f726b207265717569726564206f6620636f757273652e200a0a35302070657263656e7420746f7761726473206d61726b6574696e6720666f72207468652070726f6a6563742e20202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATWIFDOG>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATWIFDOG>>(v4);
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

