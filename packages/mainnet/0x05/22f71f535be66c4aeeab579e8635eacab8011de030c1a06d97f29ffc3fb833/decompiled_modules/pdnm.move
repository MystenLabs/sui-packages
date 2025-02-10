module 0x522f71f535be66c4aeeab579e8635eacab8011de030c1a06d97f29ffc3fb833::pdnm {
    struct PDNM has drop {
        dummy_field: bool,
    }

    fun init(arg0: PDNM, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/849NnEGJwJLSB5bbWVHNohqw15L1Y2rrCHMYcDvUpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<PDNM>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"PDNM        ")))), trim_right(b"Pandanomics                     "), trim_right(b"Welcome to Pandanomics, where community spirit thrives and the playful charm of pandas inspire us! Born from the unique intersection of luck and fortune, Pandanomics is not just a meme coin; it represents a movement dedicated to panda conservation and environmental well-being. Our passionate team comprises of individua"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PDNM>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PDNM>>(v4);
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

