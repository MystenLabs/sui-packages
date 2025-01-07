module 0xcc03e307df63357689925bf5a0305bd885e4dd6508b228889b359a9abb5e567f::nogeno {
    struct NOGENO has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOGENO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOGENO>(arg0, 6, b"NOGENO", b"nogeno", b"$NOGENO is ready for an adventure.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmeud_Q2_KLS_Lk_Nq_AKS_Ubb_B_Rj_YMWG_2r4a47_RFX_Xo3wi_Bhpt_H_ac22a3f602.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOGENO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NOGENO>>(v1);
    }

    // decompiled from Move bytecode v6
}

