module 0xb46aebfbcf43fc9e69bd3d02c0b91b27842a7e137aa14aacffcabdae55e6fc19::phyl {
    struct PHYL has drop {
        dummy_field: bool,
    }

    fun init(arg0: PHYL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111      ");
        let v1 = trim_right(b"https://ipfs.io/ipfs/QmdZur3ARuiTA9micAXHRC3DYmwCx2T2QsHZ1RBbLsh58b                                                                                                                                                                                                                                                             ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<PHYL>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"PHYL    ")))), trim_right(b"Agent PHYL                      "), trim_right(x"4167656e74205048594c207c205355492773204d656d652041490a0a4f6e2d636861696e20414920626f74616e697374207c204d656d6520776869737065726572207c204275696c74206f6e205375694e6574776f726b0a0a4465636f64696e6720576562332c2067726f77696e6720677265656e2074656368202620706f7374696e672064616e6b204149206d656d6573200a0a56657269666961626c652e2041646170746976652e2046756c6c7920646563656e7472616c697a65642e0a0a4a6f696e20746865206d6f76656d656e743b0a0a58202020203a2068747470733a2f2f782e636f6d2f6167656e747068796c6f6e7375690a5447203a2068747470733a2f2f742e6d652f6167656e747068796c6f6e737569202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PHYL>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PHYL>>(v4);
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

