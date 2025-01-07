module 0x993f09717455c0ce4f8e38e4e290e908757a2d0ac1aca2ac50f9d31751d5b49e::zappy {
    struct ZAPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZAPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZAPPY>(arg0, 6, b"ZAPPY", b"SUI ZAPPY", b"Welcome to ZAPPY on Sui chain ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730965720961.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZAPPY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZAPPY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

