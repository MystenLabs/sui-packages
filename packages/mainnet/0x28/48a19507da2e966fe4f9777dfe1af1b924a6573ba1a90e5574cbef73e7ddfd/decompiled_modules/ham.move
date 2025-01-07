module 0x2848a19507da2e966fe4f9777dfe1af1b924a6573ba1a90e5574cbef73e7ddfd::ham {
    struct HAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAM>(arg0, 6, b"HAM", b"Hammock", b"ham ham ham", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_V_Fen_TZD_Rt_Wc_N_Xuut_GJ_Jam_Ckf_Eitgoe1_Fnktc_Bf_PM_Rr_Yx_b5a2eda8a1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HAM>>(v1);
    }

    // decompiled from Move bytecode v6
}

