module 0xaa580479f05298a012f40da3b366a0f7a24a5691e4845a63b95aac51139f93d4::bewh {
    struct BEWH has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEWH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEWH>(arg0, 6, b"BEWH", b"Blue Eyes White Hasbulla", b"A science subject escaped from the matrix lab and went to Solana space. This subject was known as $BEWH has a power to release them from the matrix.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_YH_4if_Bbwv_Aco_FL_2_Xf_Ymp_CNT_67o_SP_Xq_Dsuc_Ud_Cx_T2ycd_Q_c467da138b.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEWH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BEWH>>(v1);
    }

    // decompiled from Move bytecode v6
}

