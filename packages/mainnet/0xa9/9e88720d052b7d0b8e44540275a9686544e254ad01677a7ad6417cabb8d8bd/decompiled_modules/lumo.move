module 0xa99e88720d052b7d0b8e44540275a9686544e254ad01677a7ad6417cabb8d8bd::lumo {
    struct LUMO has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<LUMO>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<LUMO>>(0x2::coin::mint<LUMO>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: LUMO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/F1UDBsPfJhA77wa6uXbuFXhbihozQyBgFEdTnzDbonk.png?size=lg&key=30983e                                                                                                                                                                                                             ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<LUMO>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Lumo    ")))), trim_right(b"Lumo Apple Ai Companion         "), trim_right(b"Lona for Apple Vision Pro features a really cute character named Lumo. You can already try to interact with Lumo in our app. Recently, I have been teaching Lumo to speak and am currently integrating the latest LLM and Text-to-Audio technology, which I'm very excited about.                                               "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LUMO>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<LUMO>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<LUMO>>(0x2::coin::mint<LUMO>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

