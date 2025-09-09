module 0x560f7c1f9488aac7c0ecd02acc74efeb0a35bc9ba46d491937a75de4c07289d6::rubix {
    struct RUBIX has drop {
        dummy_field: bool,
    }

    fun init(arg0: RUBIX, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"1d0f71e195701d67fdbec2498dc317d32045b223fce1b5d160c3272718839a86                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<RUBIX>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"RUBIX       ")))), trim_right(b"$RUBIX                          "), trim_right(b"RUBIX is a meme + community coin built on the Solana blockchain. Inspired by the idea of fun, vibes, and decentralization, RUBIX represents a puzzle of endless possibilities  where every holder is a piece of the bigger picture.                                                                                             "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RUBIX>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RUBIX>>(v4);
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

