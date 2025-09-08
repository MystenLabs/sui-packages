module 0xdb19c9ef8f51d02ac075f55d2f7754cae77babfe8492d909acba1e8288b2a6c2::andrea {
    struct ANDREA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANDREA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"92a124114bdf7a7170ae2be6f53a755b95230237ff3e3e922b3bee6f5bd754d8                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<ANDREA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"ANDREA      ")))), trim_right(b"Pump Girl                       "), trim_right(b"5 years without seeing my mom in Venezuela. If this coin pumps, Ill renew my passport, buy the ticket, and share the whole journey on my TikTok. Family reunion sponsored by the trenches of pump fun.                                                                                                                          "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANDREA>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ANDREA>>(v4);
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

