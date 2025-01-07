module 0x89270d6877017bc3e300dd2080416d87348c6a42fd2d1e727666c0230b3278d6::venus {
    struct VENUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: VENUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VENUS>(arg0, 6, b"VENUS", b"TwoFaceCat", b"Chimerism, a genetic condition that gives Venus her multicolored face, is responsible for her appearance. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/7333234478711734277_c5_1080x1080_c4e0414c4e.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VENUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VENUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

