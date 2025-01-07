module 0x18b7c670dd6bebfebc34cb08f2d7f618860210b1fd9979ed8b2f7a7a833efc70::greatness {
    struct GREATNESS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GREATNESS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GREATNESS>(arg0, 6, b"Greatness", b"chasing greatness", b"Be not afraid of greatness: some men are born great, some achieve greatness, and some have greatness thrust upon them.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Wsf5d2dz_RB_3_M1_Hzq_Kg_W_Mrp_E_Tw_T9_Xciy_Lr_Rkv9_Kv_NK_3o_X_1069d38863.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GREATNESS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GREATNESS>>(v1);
    }

    // decompiled from Move bytecode v6
}

