module 0x206dd740a952e8ee18334031f18fa1a4c0e9e7d2d88f24120b5dcd5a687dc785::Elon_Musk {
    struct ELON_MUSK has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELON_MUSK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELON_MUSK>(arg0, 9, b"ELON", b"Elon Musk", b"building rockets since 1999. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1936002956333080576/kqqe2iWO_400x400.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ELON_MUSK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELON_MUSK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

