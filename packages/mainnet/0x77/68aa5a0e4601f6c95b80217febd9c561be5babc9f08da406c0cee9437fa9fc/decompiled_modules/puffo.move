module 0x7768aa5a0e4601f6c95b80217febd9c561be5babc9f08da406c0cee9437fa9fc::puffo {
    struct PUFFO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUFFO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUFFO>(arg0, 6, b"PUFFO", b"PUFFO SUI", x"666c75666669657374206167656e740a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Q_Kbgh_B8_Xe2_L_Pvp_TT_6cnfu_CC_Ka_Mc_Het_V_Eu_Wa_Hah_S3_Mo6m_4ab697af15.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUFFO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUFFO>>(v1);
    }

    // decompiled from Move bytecode v6
}

