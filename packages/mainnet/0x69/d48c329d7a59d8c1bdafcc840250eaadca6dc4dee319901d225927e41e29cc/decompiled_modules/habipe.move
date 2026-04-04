module 0x69d48c329d7a59d8c1bdafcc840250eaadca6dc4dee319901d225927e41e29cc::habipe {
    struct HABIPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HABIPE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://photos.pinksale.finance/file/pinksale-logo-upload/1775273676771-c14c0a968b2ef574902b186fdf256f34.jpg";
        let v1 = if (0x1::vector::length<u8>(&v0) > 0) {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://photos.pinksale.finance/file/pinksale-logo-upload/1775273676771-c14c0a968b2ef574902b186fdf256f34.jpg"))
        } else {
            0x1::option::none<0x2::url::Url>()
        };
        let (v2, v3) = 0x2::coin::create_currency<HABIPE>(arg0, 9, b"HABIPE", b"HABIPE", b"Habipe Come to KSA", v1, arg1);
        let v4 = v2;
        if (100000000000000000 > 0) {
            0x2::coin::mint_and_transfer<HABIPE>(&mut v4, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HABIPE>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HABIPE>>(v3, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

