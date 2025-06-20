module 0xf3c55b3522fbfff2023bcaca12497f94d5431ff1cad1c06f5033abbbaa81bd0a::bubbla {
    struct BUBBLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUBBLA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/2fn3D4HL1wPBD95g41s5oHJa8QKBfUuBRoqQh7C7ww7H.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<BUBBLA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"BUBBL       ")))), trim_right(b"TRUMPBUBBLE                     "), trim_right(x"205748592024425542424c3f200a426f726e2066726f6d20746f6461792773205472756d70206d656d65636f696e206369726375732e0a0a204e6f207574696c6974792e204e6f204e4654732e204e6f2044414f2e0a204f6e65206d697373696f6e3a206578706c6f646520796f757220706f7274666f6c696f206f7220796f7572206469676e6974792e2020506f7765726564206279206120646572616e67656420636172746f6f6e20736f617020627562626c652e200a0a4d414b45204d454d455320475245415420414741494e20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUBBLA>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUBBLA>>(v4);
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

