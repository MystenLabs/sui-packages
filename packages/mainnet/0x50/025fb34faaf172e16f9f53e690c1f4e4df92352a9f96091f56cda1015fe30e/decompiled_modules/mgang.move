module 0x50025fb34faaf172e16f9f53e690c1f4e4df92352a9f96091f56cda1015fe30e::mgang {
    struct MGANG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MGANG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MGANG>(arg0, 6, b"MGANG", b"MOPSGANG", b"DSFSFSDFS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730985699276.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MGANG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MGANG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

