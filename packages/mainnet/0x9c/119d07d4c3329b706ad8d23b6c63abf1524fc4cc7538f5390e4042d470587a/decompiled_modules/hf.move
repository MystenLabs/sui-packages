module 0x9c119d07d4c3329b706ad8d23b6c63abf1524fc4cc7538f5390e4042d470587a::hf {
    struct HF has drop {
        dummy_field: bool,
    }

    fun init(arg0: HF, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/FeM52yZTDZfs1mdFLABy5BMdHphGxX3A7N8Gdu2ipump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<HF>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"HF          ")))), trim_right(b"Harry Farter                    "), trim_right(b"The magical meme coin powered by laughter, farts, and community magic. Just like its namesake, Harry Farter was destined to bring joy, mischief, and unforgettable spells to the crypto world. Backed by the strongest force of alldegens unitedHarry Farter turns every pump into a wizards duel and every dump into a puff of "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HF>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HF>>(v4);
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

