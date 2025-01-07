module 0x6b8695d41ac6d58a9fd73a65e5b3750cbd5ba4c81b9757f97314ffb24f888bfb::hippnotize {
    struct HIPPNOTIZE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HIPPNOTIZE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HIPPNOTIZE>(arg0, 6, b"HIPPNOTIZE", b"hippnotize", b"hippnotize sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmd_U476_X_Xy_X_La_Nv_QTSS_Ps_Ror_Chpguqv_X_Bex2rbig5p_V7u_M_7c93339cc3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HIPPNOTIZE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HIPPNOTIZE>>(v1);
    }

    // decompiled from Move bytecode v6
}

