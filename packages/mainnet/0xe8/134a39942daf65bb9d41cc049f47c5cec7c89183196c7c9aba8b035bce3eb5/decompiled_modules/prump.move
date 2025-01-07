module 0xe8134a39942daf65bb9d41cc049f47c5cec7c89183196c7c9aba8b035bce3eb5::prump {
    struct PRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PRUMP>(arg0, 6, b"PRUMP", b"PUMPKIN TRUMP", b"PUMPKIN TRUMP ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Qihdcx5t_R_Ht_TN_38_Y_Sj_K8_Lsidb7z_Pd_Uek_Jo1xu_Hqa_E_Zqi_fdab0b446e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

