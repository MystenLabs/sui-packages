module 0x4c9108a50747c512a0c54dfc16f9524f8fdd42494c7dc1e537c762589ebe5fe5::suimming {
    struct SUIMMING has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMMING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMMING>(arg0, 6, b"SUIMMING", b"SuimmingTrump", b"Swimming president on SUI Ocean.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7862_5d7711e28e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMMING>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMMING>>(v1);
    }

    // decompiled from Move bytecode v6
}

