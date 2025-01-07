module 0x9c762fba3d33a15ae406cc94f41c2724a59fec43669bfef8711d1267675e13ba::akane {
    struct AKANE has drop {
        dummy_field: bool,
    }

    fun init(arg0: AKANE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AKANE>(arg0, 6, b"AKANE", b"Akane", x"74616c6b2077697468206d652c20667269656e202020220a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_X9g6_Uhk_GQUS_7_Wk_Mcx_Yjz4_XTKQD_7_B29_D_Yd_Nop_Jou4_KLVA_8ef2aec41a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AKANE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AKANE>>(v1);
    }

    // decompiled from Move bytecode v6
}

