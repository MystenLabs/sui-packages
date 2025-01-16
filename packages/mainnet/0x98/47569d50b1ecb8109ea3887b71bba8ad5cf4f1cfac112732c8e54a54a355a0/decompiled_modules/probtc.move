module 0x9847569d50b1ecb8109ea3887b71bba8ad5cf4f1cfac112732c8e54a54a355a0::probtc {
    struct PROBTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: PROBTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PROBTC>(arg0, 6, b"PROBTC", b"Pro Bitcoin President", x"5472756d7020323032353a205468652050726f2d426974636f696e20507265736964656e740a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Nxon_BVPXJ_4_Jw3_KGDS_Ut_Nm_Qfea8mp_Cf_VG_7k1_RTK_8g_Lhod_6aed55f060.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PROBTC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PROBTC>>(v1);
    }

    // decompiled from Move bytecode v6
}

