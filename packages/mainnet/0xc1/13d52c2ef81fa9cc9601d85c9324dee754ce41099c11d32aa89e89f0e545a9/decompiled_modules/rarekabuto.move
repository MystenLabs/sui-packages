module 0xc113d52c2ef81fa9cc9601d85c9324dee754ce41099c11d32aa89e89f0e545a9::rarekabuto {
    struct RAREKABUTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAREKABUTO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"eff9c57f76078632546bcf0f70b93d1490049f87490cc9ca8618634d07be56c8                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<RAREKABUTO>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"RAREKABUTO  ")))), trim_right(b"Rare Kabuto                     "), trim_right(b"RareKabuto is here! A tribute to everyone who loves collecting this cute and charming Pokmon. This is the meme that Solana will recognize more than any other.                                                                                                                                                                  "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAREKABUTO>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RAREKABUTO>>(v4);
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

