module 0xab99f9e5755a4bc581aff94ff69fb301a7f48d6575c112ac72cbbb9b49e8bbbd::dale {
    struct DALE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DALE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/HjjmgBxtnu7soQfbyQAi3ZJAo8MPAA9rn6EPN2K9bonk.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<DALE>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Dale        ")))), trim_right(b"The Surfing Frenchie            "), trim_right(b"Dale, a 6-year-old French bulldog who surfs with his owner, recently made his film debut in Disneys live-action remake of Lilo & Stitch. He gets mad when we take him out of the water, said Julie Eggers, who takes care of Dale with her boyfriend Greg Dutcher.                                                              "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DALE>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DALE>>(v4);
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

