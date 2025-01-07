module 0x636abd8a234f755476ae201888294a89ab7dfb2bef426bcf2adeaf5350741327::sola {
    struct SOLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOLA>(arg0, 6, b"SOLA", b"SOLA AI", x"534f4c412d41492028534f4c41290a536f6c616e61277320766f69636520617373697374616e742e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmehs_Db_Nu_Jjx_T1x_E_Nr_Y2372_MQN_65v83arwsfg_QKDZQ_9a_Mn_d11923df94.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOLA>>(v1);
    }

    // decompiled from Move bytecode v6
}

