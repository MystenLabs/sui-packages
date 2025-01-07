module 0x3277ca43e1fcbf22d81ab9b50053fafa6a5df72c5cf8d51618b62c9b0ef42ce5::catie {
    struct CATIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATIE>(arg0, 6, b"CATIE", b"Catie", b"Rest assured! CATIE's liquidity will live on forever!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmad_Uprjnuo_T6tvgr_FB_8b_W7_MGN_Zpnkx_Jdqm_V1_E_Jv_M_Lmue2_d6a427ca75.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

