module 0x8d0071b514324b8ea03c8c35bc4432f8d97fc12cf168e0f6fdc1870a1f9da841::greens {
    struct GREENS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GREENS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GREENS>(arg0, 6, b"GREENS", x"54686520477265656e73f09f9fa2f09f9fa2", x"f09f9fa2f09f9fa241726520796f7520726561647920666f722054686520477265656e73f09f9fa2f09f9fa20a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736537249594.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GREENS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GREENS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

