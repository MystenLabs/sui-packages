module 0x96ff60e67b69ff5e992e4adddb137c4b0cb1fb7d1c7f73b9d6624ef28343ff58::wat {
    struct WAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAT>(arg0, 6, b"WAT", b"WhiteAutisticRabbit", b"White Autistic Rabbit", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_RX_Eh2m_K6_Q_Beb1_Q_Bs_Gmy_V1v_B9_Ru_Vd_HQ_7_CS_4pgpyz4_Dync_23f764dc7c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

