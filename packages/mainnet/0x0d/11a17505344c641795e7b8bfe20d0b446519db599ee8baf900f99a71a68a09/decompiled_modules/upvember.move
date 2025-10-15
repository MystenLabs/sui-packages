module 0xd11a17505344c641795e7b8bfe20d0b446519db599ee8baf900f99a71a68a09::upvember {
    struct UPVEMBER has drop {
        dummy_field: bool,
    }

    fun init(arg0: UPVEMBER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"cab0e887b6f740e2b957af4b61b82aab3b284a5a124745aa688c8739e75f9432                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<UPVEMBER>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"UPVEMBER    ")))), trim_right(b"UPVEMBER (real)                 "), trim_right(x"555056454d4245523a204e6f76656d6265722773204f6e6c7920506c6179200a0a5570746f6265722072616e2c20557076656d626572206d6f6f6e73206861726465722e200a0a5468697320697320746865204e6f76656d62657220706c61792e204c6f616420626167732c207761746368206d616769632068617070656e2e0a0a53706f6e736f72656420627920796f7572206c6f63616c2072657461726420636f6d6d6974746565202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UPVEMBER>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UPVEMBER>>(v4);
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

