module 0xb37a22fbc53c598c72fb1cc82203fae1aaf509a4a5a7af18921954486b86b48c::employee {
    struct EMPLOYEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: EMPLOYEE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"c093b9d986f3255c390994429360d61444af6f8c03c6de8d9cada2c535868b02                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<EMPLOYEE>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"EMPLOYEE    ")))), trim_right(b"EMPLOYEE                        "), trim_right(b"Start the day with coffee, a deep sigh, and a meme-worthy face. EMPLOYEE brings the small chaos of worksleepy eyes, sudden meetings, and tiny jokes that make the routine feel lighter.                                                                                                                                         "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EMPLOYEE>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EMPLOYEE>>(v4);
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

