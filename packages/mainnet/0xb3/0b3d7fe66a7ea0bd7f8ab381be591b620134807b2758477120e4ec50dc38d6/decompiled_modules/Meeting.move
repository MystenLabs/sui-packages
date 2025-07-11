module 0xb30b3d7fe66a7ea0bd7f8ab381be591b620134807b2758477120e4ec50dc38d6::Meeting {
    struct MEETING has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEETING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEETING>(arg0, 9, b"MTG", b"Meeting", b"this is a meeting ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa-dev.sgp1.cdn.digitaloceanspaces.com/kappa-dev/coins/5829a513-d704-40d4-8d2d-6e09c91a54cc.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEETING>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEETING>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

