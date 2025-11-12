module 0x1c79faf812a70eab73a8027bfd23616cff094b1dd20e48416d0ef0e985fe69ae::quest {
    struct QUEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: QUEST, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"cf9858d256206b5a1638170bdf6a4f62c995e21611dd6f289d2564e46433ea64                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<QUEST>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"QUEST       ")))), trim_right(b"Traders Quest                   "), trim_right(b"Traders Quest is a fantasy-trading ecosystem where traders compete in leagues and earn rewards based on performance and strategy. Platform revenue funds $Quest buybacks and prize pools, while 20% of all creator fees is distributed to top holders. Fantasy sports is a multi-billion dollar market, and retail trading is gr"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QUEST>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<QUEST>>(v4);
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

