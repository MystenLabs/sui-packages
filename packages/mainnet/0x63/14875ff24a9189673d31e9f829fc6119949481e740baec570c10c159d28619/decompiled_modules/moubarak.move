module 0x6314875ff24a9189673d31e9f829fc6119949481e740baec570c10c159d28619::moubarak {
    struct MOUBARAK has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOUBARAK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://photos.pinksale.finance/file/pinksale-logo-upload/1775147568260-e7ec69536eca2c6f2d04dca4cbb2a753.png";
        let v1 = if (0x1::vector::length<u8>(&v0) > 0) {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://photos.pinksale.finance/file/pinksale-logo-upload/1775147568260-e7ec69536eca2c6f2d04dca4cbb2a753.png"))
        } else {
            0x1::option::none<0x2::url::Url>()
        };
        let (v2, v3) = 0x2::coin::create_currency<MOUBARAK>(arg0, 9, b"MOUBARAK", b"Moubarak sui", b"sui moubarak coin", v1, arg1);
        let v4 = v2;
        if (10000000000000000000 > 0) {
            0x2::coin::mint_and_transfer<MOUBARAK>(&mut v4, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOUBARAK>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MOUBARAK>>(v3, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

