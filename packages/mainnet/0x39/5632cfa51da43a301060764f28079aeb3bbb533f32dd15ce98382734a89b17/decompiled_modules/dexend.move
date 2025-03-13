module 0x395632cfa51da43a301060764f28079aeb3bbb533f32dd15ce98382734a89b17::dexend {
    struct DEXEND has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEXEND, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/Ekv4q5s2Q6DAc39V1dAscoKQrotkZmY7Bh6NvX78pump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<DEXEND>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"DEXEND      ")))), trim_right(b"DEXEND                          "), trim_right(b"At Dexend, we believe in a future where digital spaces are secure, resilient, and trustworthy. Founded by a team of cybersecurity experts and AI enthusiasts, Dexend was born out of a mission to combat the ever-evolving landscape of cyber threats. Our platform harnesses the power of artificial intelligence to deliver pr"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEXEND>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DEXEND>>(v4);
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

