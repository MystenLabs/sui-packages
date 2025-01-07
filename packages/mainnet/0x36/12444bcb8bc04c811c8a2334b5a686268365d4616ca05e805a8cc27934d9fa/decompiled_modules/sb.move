module 0x3612444bcb8bc04c811c8a2334b5a686268365d4616ca05e805a8cc27934d9fa::sb {
    struct SB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SB>(arg0, 6, b"SB", b"Shiny Bants", b"Shiny Bants is a polar bear by artist Philip Banks, creator of \"Chill Guy.\" SB is his P4P favorite character.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2sa3_QJ_5_R_Use1_Kk_TTZ_7_HB_Fa_W_Sffc_Vg_MX_Lq_Y7_U_Jsc2pump_bb0c8e36bc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SB>>(v1);
    }

    // decompiled from Move bytecode v6
}

