module 0x4ae1747356ddd23c1ff9caf1d2b242e949b3ae6a6b7f0c0f930174b61ccb6dbc::aaaa {
    struct AAAA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAAA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAAA>(arg0, 6, b"AAAA", b"aaaaa Cat", b"Your last chance", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GXY_7f_O6_Xc_AA_Ci_FR_b06368b013.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAAA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAAA>>(v1);
    }

    // decompiled from Move bytecode v6
}

