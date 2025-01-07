module 0x6e3a446405386eb81d4342f24fb4d5c0f725ae61745c7a1908894c8594351a56::isui {
    struct ISUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ISUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ISUI>(arg0, 6, b"ISUI", b"IrobotSUI", b"The sui robot", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/artworks_000668295229_kc5l8i_t500x500_8fcd357e2e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ISUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ISUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

