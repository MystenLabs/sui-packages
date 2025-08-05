module 0x66c0b509338ff781b6d0f725c2335ad9ad4e77bb30db03b860a18c8baff347c7::roxgold {
    struct ROXGOLD has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROXGOLD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"40a354bdc96923728d1ae91a162922dec051e1fbfcf7a6fd740d7d5cd46527d1                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<ROXGOLD>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"ROXGOLD     ")))), trim_right(b"Rox Gold Coin                   "), trim_right(b"ROXGOLD is no ordinary fox  hes a cunning miner, treasure hunter, and gold-stacking degen legend. Deep in the blockchain mines, ROX digs for riches and BONKs bears with bags of pure digital gold.                                                                                                                             "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROXGOLD>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ROXGOLD>>(v4);
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

