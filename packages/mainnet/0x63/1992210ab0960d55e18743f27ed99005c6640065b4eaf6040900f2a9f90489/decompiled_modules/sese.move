module 0x631992210ab0960d55e18743f27ed99005c6640065b4eaf6040900f2a9f90489::sese {
    struct SESE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SESE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SESE>(arg0, 9, b"SESE", b"qqq", b"sss", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://static.thenounproject.com/png/447685-200.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SESE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SESE>>(v1);
    }

    // decompiled from Move bytecode v6
}

