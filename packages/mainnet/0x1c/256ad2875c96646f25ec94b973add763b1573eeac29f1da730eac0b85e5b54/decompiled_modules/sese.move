module 0x1c256ad2875c96646f25ec94b973add763b1573eeac29f1da730eac0b85e5b54::sese {
    struct SESE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SESE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SESE>(arg0, 6, b"SESE", b"Sese", b"The most memeable reptile in existence. Dogs had their day. Sese reigns now. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000085804_1effc30b47.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SESE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SESE>>(v1);
    }

    // decompiled from Move bytecode v6
}

