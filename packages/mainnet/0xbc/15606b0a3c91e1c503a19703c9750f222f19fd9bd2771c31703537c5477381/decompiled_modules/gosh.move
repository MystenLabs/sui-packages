module 0xbc15606b0a3c91e1c503a19703c9750f222f19fd9bd2771c31703537c5477381::gosh {
    struct GOSH has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOSH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOSH>(arg0, 6, b"GOSH", b"GOSHSUI", b"GOSH ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmbu_SQC_By83o_Y3_Bun_KBE_2p9_C_Dg_LS_2_Zm_Nkmij_Wa_RPUHEH_3y_666f863611.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOSH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOSH>>(v1);
    }

    // decompiled from Move bytecode v6
}

