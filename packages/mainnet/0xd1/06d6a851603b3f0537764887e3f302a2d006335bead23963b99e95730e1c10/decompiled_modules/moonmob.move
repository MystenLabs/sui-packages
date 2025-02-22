module 0xd106d6a851603b3f0537764887e3f302a2d006335bead23963b99e95730e1c10::moonmob {
    struct MOONMOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOONMOB, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/3rSW3k91YLSjJSUWzRxVkSbBqbK95xSbddXhjZT2pump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<MOONMOB>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"MoonMob     ")))), trim_right(b"MoonMob                         "), trim_right(b"MoonMob is your frontline operative in the battle against hidden SOLthose forgotten funds lurking in empty token accounts. We dive into the trenches of the Solana blockchain to recover every stray SOL without any technical wizardry on your part. With our 100% secure, non-custodial service, you can reclaim whats rightfu"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOONMOB>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOONMOB>>(v4);
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

