module 0x90a3ba1a0ab349abb459af52f24287a331b1889b252baa1ece7a1d6ca271babd::gro {
    struct GRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRO>(arg0, 6, b"GRO", b"GRO SUI", b"GRO ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qme_QKN_8_Wu_DM_2_Dh_Qpa_Y6s_JAB_4y_Rvttqa_S7zjo_DX_Ljdcb_VCZ_ccd8d768a9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

