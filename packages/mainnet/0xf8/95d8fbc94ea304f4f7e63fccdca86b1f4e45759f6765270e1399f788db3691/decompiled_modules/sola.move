module 0xf895d8fbc94ea304f4f7e63fccdca86b1f4e45759f6765270e1399f788db3691::sola {
    struct SOLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOLA>(arg0, 6, b"SOLA", b"SOLA AI", b"SUI's voice assistant.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmehs_Db_Nu_Jjx_T1x_E_Nr_Y2372_MQN_65v83arwsfg_QKDZQ_9a_Mn_00cfbe54d1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOLA>>(v1);
    }

    // decompiled from Move bytecode v6
}

