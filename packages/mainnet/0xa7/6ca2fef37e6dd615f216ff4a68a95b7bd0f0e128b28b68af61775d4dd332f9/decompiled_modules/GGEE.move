module 0xa76ca2fef37e6dd615f216ff4a68a95b7bd0f0e128b28b68af61775d4dd332f9::GGEE {
    struct GGEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GGEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GGEE>(arg0, 6, b"ges", b"GGEE", b"cubes", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"ICoN_URL_STRING_PLACEHOLDER")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GGEE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GGEE>>(v1);
    }

    // decompiled from Move bytecode v6
}

