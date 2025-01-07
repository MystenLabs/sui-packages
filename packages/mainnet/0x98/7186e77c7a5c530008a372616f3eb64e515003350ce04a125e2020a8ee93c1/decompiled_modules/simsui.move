module 0x987186e77c7a5c530008a372616f3eb64e515003350ce04a125e2020a8ee93c1::simsui {
    struct SIMSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIMSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIMSUI>(arg0, 6, b"SIMSUI", b"Simsui", b"SimSui your friendly AI chatbot, now on the Sui blockchain! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/instant_73_35e355529f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIMSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SIMSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

