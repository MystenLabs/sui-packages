module 0xbef63ad29fc110638573f165afb30ecfcfffd87dac38daa500fb1f897fecbcf3::sadge {
    struct SADGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SADGE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"2324937cebec3b792ffda1a29e21f5249b7465da7b927a926693f6d3e29141fa                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<SADGE>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"SADGE       ")))), trim_right(b"SADGE                           "), trim_right(b"\"Sadge\" is internet slang originating from the Twitch emote of the same name, which features a sad-looking Pepe the Frog and is used to express sadness, disappointment, or melancholy, often in an ironic or sarcastic way. The term may be a portmanteau of \"sad\" and \"cringe,\" and the emote gained popularity through its us"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SADGE>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SADGE>>(v4);
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

