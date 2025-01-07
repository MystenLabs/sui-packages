module 0x38000132654497077ae4369a03cccc7d65a133694e4fcdd8fb00afb4f2af5b62::pepetoshi {
    struct PEPETOSHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPETOSHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPETOSHI>(arg0, 6, b"PEPETOSHI", b"PETER TOAD", b"Satoshi Nokamota is Peter Toad", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qma_Hm_Dp_HW_Fsp_FK_Gtu_Xr_C_Pbsu5i_Qtz_Sc_Ry9_Q_Vc_SP_Lq195_BG_251f80964d.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPETOSHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPETOSHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

