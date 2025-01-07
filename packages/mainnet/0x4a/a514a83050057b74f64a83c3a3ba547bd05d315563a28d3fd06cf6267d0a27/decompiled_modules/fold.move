module 0x4aa514a83050057b74f64a83c3a3ba547bd05d315563a28d3fd06cf6267d0a27::fold {
    struct FOLD has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOLD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOLD>(arg0, 6, b"FOLD", b"Foldi cat", b"Fascinating world of CAT$FOLDI Game Join us on exciting journey where gaming and blockchain unite. Get ready to experience a new level of entertainment and innovation.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241003_024106_241_removebg_preview_60a7001e0f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOLD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FOLD>>(v1);
    }

    // decompiled from Move bytecode v6
}

