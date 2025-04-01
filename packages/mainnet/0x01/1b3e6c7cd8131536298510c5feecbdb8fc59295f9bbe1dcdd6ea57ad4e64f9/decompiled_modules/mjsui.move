module 0x11b3e6c7cd8131536298510c5feecbdb8fc59295f9bbe1dcdd6ea57ad4e64f9::mjsui {
    struct MJSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MJSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MJSUI>(arg0, 9, b"MJSUI", b"mjSUI", b"Create mj SUI for my rewards.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://example.com/image.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MJSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MJSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

