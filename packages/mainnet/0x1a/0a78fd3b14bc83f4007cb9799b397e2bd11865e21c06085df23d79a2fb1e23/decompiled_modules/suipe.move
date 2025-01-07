module 0x1a0a78fd3b14bc83f4007cb9799b397e2bd11865e21c06085df23d79a2fb1e23::suipe {
    struct SUIPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPE>(arg0, 6, b"SUIPE", b"SUIPEPE", b"SUI PEPE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5017_f1bafb8f83.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

