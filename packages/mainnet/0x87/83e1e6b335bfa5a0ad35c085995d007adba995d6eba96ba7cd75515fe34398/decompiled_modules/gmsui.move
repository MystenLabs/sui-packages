module 0x8783e1e6b335bfa5a0ad35c085995d007adba995d6eba96ba7cd75515fe34398::gmsui {
    struct GMSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GMSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GMSUI>(arg0, 6, b"GMSUI", b"gm sui frens", b"No matter what fucking time zone you're in, dropping a \"GM\" is like saying, \"Hey, we're all getting mental illness together, and we might as well have a laugh while we're at it.\" Dexscreener Paid", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_27_c3483d9390.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GMSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GMSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

