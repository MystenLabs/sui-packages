module 0xa440bdecff01baf7ebf6bb56050faa87186ad411e4946ab75069436b9aa2d903::kingtrumpa {
    struct KINGTRUMPA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KINGTRUMPA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"4a6c8c126b481e5dea629b4d600bfb4a7a2873fd582c4e18af9f9d7bd99f4096                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<KINGTRUMPA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"KINGTRUMP   ")))), trim_right(b"KINGTRUMP                       "), trim_right(b"Narrative for $KINGTRUMP MemecoinIn the early hours of October 21, 2025, at 6:48 AM CEST, the crypto world awoke to a new legend: $KINGTRUMP, the memecoin born from the chaos of a government shutdown. Picture thisDonald Trump, clad in his iconic MAGA hat and suit, stands defiantly outside the White House, wielding a gl"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KINGTRUMPA>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KINGTRUMPA>>(v4);
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

