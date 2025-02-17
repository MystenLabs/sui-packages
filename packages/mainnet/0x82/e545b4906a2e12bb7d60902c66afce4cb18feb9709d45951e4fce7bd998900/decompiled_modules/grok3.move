module 0x82e545b4906a2e12bb7d60902c66afce4cb18feb9709d45951e4fce7bd998900::grok3 {
    struct GROK3 has drop {
        dummy_field: bool,
    }

    fun init(arg0: GROK3, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GROK3>(arg0, 6, b"GROK3", b"GROK3AI", b"grok.x.com", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/FYD_Ro_N_Cex7_K_Jf_Yx3i_H_Fh_D9pe_Jb4_PPSB_9_EG_7_V_Ag4s_UK_Bq_eeff5bb143.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GROK3>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GROK3>>(v1);
    }

    // decompiled from Move bytecode v6
}

