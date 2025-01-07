module 0x339fff7b6d8840ab3704bc408b100e32314606467a64bd58f0eb24aff3997914::spooky {
    struct SPOOKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPOOKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPOOKY>(arg0, 6, b"SPOOKY", b"Spooky", b"SPOOKY is ready for a great adventure!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_XPJ_Bk_Qhv1_C2_JU_75_B_Gvm6m_Zf_Wcz_G_Ho_BF_Ed3_Nm_VAF_Mt_NCS_048526e372.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPOOKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPOOKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

