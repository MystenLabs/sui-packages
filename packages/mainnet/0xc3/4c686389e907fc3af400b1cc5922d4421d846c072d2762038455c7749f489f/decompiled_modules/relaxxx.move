module 0xc34c686389e907fc3af400b1cc5922d4421d846c072d2762038455c7749f489f::relaxxx {
    struct RELAXXX has drop {
        dummy_field: bool,
    }

    fun init(arg0: RELAXXX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RELAXXX>(arg0, 6, b"RELAXXX", b"Its ok.", b"For people who value calm over chaos. *chill vibes only.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732082535686.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RELAXXX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RELAXXX>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

