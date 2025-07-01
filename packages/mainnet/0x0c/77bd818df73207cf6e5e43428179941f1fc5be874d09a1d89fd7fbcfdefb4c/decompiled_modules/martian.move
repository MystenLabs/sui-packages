module 0xc77bd818df73207cf6e5e43428179941f1fc5be874d09a1d89fd7fbcfdefb4c::martian {
    struct MARTIAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MARTIAN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/F995aybZVjghgSs4MRHw1STA5TEUAueAghRYXEDTpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<MARTIAN>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"MARTIAN     ")))), trim_right(b"MORK                            "), trim_right(b"MORK serves as a cosmic rallying point for the Solana meme coin community, fostering safe investing, enthusiastic engagement and chart-pumping excitement. With his out-of-this-world charisma, MORK bridges intergalactic divides, turning strangers into a tight-knit crew of crypto-investor enthusiasts. His mission? To mak"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MARTIAN>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MARTIAN>>(v4);
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

