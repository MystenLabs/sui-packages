module 0xa9adbe01501f153db18a3927c5216d4fe0343ffd1af0f4719edf520777bf52e0::gork {
    struct GORK has drop {
        dummy_field: bool,
    }

    fun init(arg0: GORK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/EcwYoghkvSyfLyeg6rDHe6zpvVxGhV3HapheeZv7MeUe.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<GORK>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"gork        ")))), trim_right(b"gork AI Agent                   "), trim_right(x"6a75737420676f726b696e272069742040676f726b2024676f726b0a0a476f726b204149204167656e7420697320612076696272616e742c206d656d652d696e73706972656420414920706c6174666f726d20746861742064656c69766572732077697474792c207265616c2d74696d6520726573706f6e7365732e204275696c7420666f72207365616d6c65737320696e746567726174696f6e207769746820706c6174666f726d73206c696b6520582c206974207265646566696e657320636f6e766572736174696f6e616c20414920776974682068756d6f7220616e6420637265617469766974792e202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GORK>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GORK>>(v4);
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

