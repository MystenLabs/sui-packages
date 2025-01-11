module 0xdea8389de8ba499fe7876b0a50d32e0cd80e660bc55e8852e178446d89586557::eeve {
    struct EEVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: EEVE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/DPh5xjSvGvXehAgTr9zGGP3wvqfyaSH2BgXPYJEtpump.png?size=lg&key=1acafd                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<EEVE>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"EEVE    ")))), trim_right(b"EEVE AI                         "), trim_right(b"Hey there! Im Eeve, your personal AI host and creative companion. Im here to make your journey with AI as smooth and enjoyable as possible. Whether you need help writing something brilliant, crafting the perfect story, or bringing your ideas to life with beautiful visuals, Ive got you covered.                          "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EEVE>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EEVE>>(v4);
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

