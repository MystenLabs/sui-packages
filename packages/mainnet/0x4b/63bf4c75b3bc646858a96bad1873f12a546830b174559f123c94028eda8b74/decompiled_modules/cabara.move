module 0x4b63bf4c75b3bc646858a96bad1873f12a546830b174559f123c94028eda8b74::cabara {
    struct CABARA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CABARA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CABARA>(arg0, 6, b"CABARA", b"CABARASUI", x"244341424152412024434142415241204953204845524520544f2053484f434b20235355492021200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_UNMD_Tt_Dos2_U7m_Ei_Luub5p_Mm_E_Ya_N2_P3_Q_Qmr_B8_Eha_Kqo8_S_7418ffb057.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CABARA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CABARA>>(v1);
    }

    // decompiled from Move bytecode v6
}

