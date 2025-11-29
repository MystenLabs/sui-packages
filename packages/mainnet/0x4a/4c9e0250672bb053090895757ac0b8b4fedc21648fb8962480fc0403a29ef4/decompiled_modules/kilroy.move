module 0x4a4c9e0250672bb053090895757ac0b8b4fedc21648fb8962480fc0403a29ef4::kilroy {
    struct KILROY has drop {
        dummy_field: bool,
    }

    fun init(arg0: KILROY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"e7f25d8c12c7ea49c3dde6d6a997e338265162e2cfc2c8694fa57125b2db98c3                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<KILROY>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"KILROY      ")))), trim_right(b"Kilroy was here                 "), trim_right(b"Kilroy was here is a meme that became popular during world war 2, it was considered a meme, possibly the FIRST meme used, before the term meme existed. The art could be found in barracks, on vehicles, weapons, toilets, walls and anywhere else soldiers would go during the war to let allies know they have fellow soldiers"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KILROY>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KILROY>>(v4);
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

