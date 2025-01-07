module 0x6e00b71c44ca26a43c14391ab0fa428b96bf3cc984dbaf6c111e2c79bd41e935::nitrosui {
    struct NITROSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NITROSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NITROSUI>(arg0, 6, b"NITROSUI", b"NITRO SNAIL", b"NITROS SNAIL ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3572_26d48e4e45.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NITROSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NITROSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

