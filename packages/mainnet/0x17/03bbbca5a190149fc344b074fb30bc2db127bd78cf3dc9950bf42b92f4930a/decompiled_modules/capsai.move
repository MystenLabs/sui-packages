module 0x1703bbbca5a190149fc344b074fb30bc2db127bd78cf3dc9950bf42b92f4930a::capsai {
    struct CAPSAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAPSAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAPSAI>(arg0, 6, b"CAPSAI", b"Capsulate AI", b"Preserve your thoughts in digital time capsules, powered by AI. Create meaningful connections across time with encrypted messages that unlock at a perfect time.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_X_Ye9kt_Pvr_Bj_Mkk7_APL_Ddj_V_Ycay5_Dh_Aupk_Ys1m_Q_Eqoa_Cq_49fc500e71.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAPSAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CAPSAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

