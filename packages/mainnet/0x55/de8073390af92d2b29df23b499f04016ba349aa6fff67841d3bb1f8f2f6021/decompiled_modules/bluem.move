module 0x55de8073390af92d2b29df23b499f04016ba349aa6fff67841d3bb1f8f2f6021::bluem {
    struct BLUEM has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUEM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUEM>(arg0, 6, b"BLUEM", b"BLUEM SUI", b"THE FIRST NAME GIVEN TO BLUEM SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_05_02_33_33_d8769b42c0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUEM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUEM>>(v1);
    }

    // decompiled from Move bytecode v6
}

