module 0x8b39b2d887709233bf4b2acb35eaa1c1246b11dc66b600d1ab053f9be24605b::wat {
    struct WAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAT>(arg0, 6, b"WAT", b"WhiteAutisticRabbit", b"White Autistic Rabbit is ready for an adventure!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_RX_Eh2m_K6_Q_Beb1_Q_Bs_Gmy_V1v_B9_Ru_Vd_HQ_7_CS_4pgpyz4_Dync_23f764dc7c_2f868a756d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

