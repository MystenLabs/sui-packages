module 0x44cff60cefd35f6d855bbc572b1ae3932413e875266a57c141478c4ba403e863::pepe {
    struct PEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPE>(arg0, 6, b"PEPE", b"PEPE ELON", x"5768656e204d656d6573204d656574204d61727320205045504520454c4f4e2054616b6573204f66660a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_XV_Kw_Ae_N_Jsau4_QGZ_Dy2_A_Je6f_CDG_5mxg_Y7u_Arn_Hqy_F2xev_37553d5061.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

