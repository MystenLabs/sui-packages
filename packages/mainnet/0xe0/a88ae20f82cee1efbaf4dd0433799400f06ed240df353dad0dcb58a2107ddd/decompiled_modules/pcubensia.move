module 0xe0a88ae20f82cee1efbaf4dd0433799400f06ed240df353dad0dcb58a2107ddd::pcubensia {
    struct PCUBENSIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PCUBENSIA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"0d256855c1bc7098d639217fc47438a64b6ae2cc3bc36f2a48bd1510e8101850                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<PCUBENSIA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Pcubensi    ")))), trim_right(b"Magic Mushroom Experiment       "), trim_right(x"52656c61756e6368696e67207468697320776974682074686520636f7272656374206e616d6520616e64207469636b65722e20546865206f6c642064657620616c736f206162616e646f6e656420746865205820636f6d6d20616e642077652063616e742043544f2069742e200a0a427279616e204a6f686e736f6e2068617320616e6e6f756e636564206865732074616b696e672035206772616d73206f66206d61676963206d757368726f6f6d73206f6e63652061206d6f6e746820746f207465737420696620697420736c6f7773206167696e672e200a0a4974207374617274732053756e6461792031312f392f323520616e642068617320616c726561647920676f6e652065787472656d656c7920766972616c20776974682074656e73206f66206d696c6c696f6e73206f6620766965777320616e6420656e6761"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PCUBENSIA>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PCUBENSIA>>(v4);
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

