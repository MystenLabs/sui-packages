module 0x820c1ca8fcd9f3cfcd7b7fb4b32da82d111ac6222e5a291961c8cc60ba361bd::forky {
    struct FORKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FORKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FORKY>(arg0, 6, b"Forky", b"Forkysui", b" $forky was found and revived because $forky is NOT trash!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_07_09_59_17_1567f95d62.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FORKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FORKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

