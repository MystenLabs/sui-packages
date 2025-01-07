module 0xb0eeb71eb064612de3f17265bd5dd685fe31906f46a048ab3ad5e29d8502afe2::tusko {
    struct TUSKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TUSKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TUSKO>(arg0, 6, b"TUSKO", b"TUSKO SU", b"TUI TUSKO SUIi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/qw66_CEQI_9_Tes_Itehp_R_Ibe_NL_35r4_65da7d0095.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TUSKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TUSKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

