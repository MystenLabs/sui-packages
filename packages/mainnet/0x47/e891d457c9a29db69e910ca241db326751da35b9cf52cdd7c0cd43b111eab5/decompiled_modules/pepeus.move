module 0x47e891d457c9a29db69e910ca241db326751da35b9cf52cdd7c0cd43b111eab5::pepeus {
    struct PEPEUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPEUS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/7phqHCE3pJHBpoPNGLH2aXjFvDJF2uBEzFMhrphQFvj1.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<PEPEUS>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"PEPEUS      ")))), trim_right(b"Pepe Kekius Maximus             "), trim_right(x"50657065204b656b697573204d6178696d75732020245045504555530a416c6c206861696c207468652046726f6720456d7065726f72206f66204d656d65732e0a466f7267656420696e20616e6369656e74204b656b697374616e2c207265626f726e206f6e2d636861696e2e0a486520636f6e71756572732077697468206d656d65732e2048652072756c657320776974682076696265732e20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPEUS>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPEUS>>(v4);
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

