module 0xcadfa03b1ce64698642cc39ff76e114c7649c75719b8ed19a279d8c146363f21::emperor {
    struct EMPEROR has drop {
        dummy_field: bool,
    }

    fun init(arg0: EMPEROR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EMPEROR>(arg0, 6, b"Emperor", b"Colosseum AI", b"At the helm of ColosseumAI, The Emperor orchestrates intelligent yield farming strategies, guided by a diverse council of AI Senate agents", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_TJ_42_G2dd_Sc_Db1jsr_Yjc_BVD_Zwf_AS_Wv_N7e9m_F_Edi_Juyt_Nt_13128bd961.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EMPEROR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EMPEROR>>(v1);
    }

    // decompiled from Move bytecode v6
}

