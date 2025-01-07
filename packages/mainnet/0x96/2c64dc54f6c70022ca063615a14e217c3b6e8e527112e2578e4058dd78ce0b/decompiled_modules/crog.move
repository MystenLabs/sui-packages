module 0x962c64dc54f6c70022ca063615a14e217c3b6e8e527112e2578e4058dd78ce0b::crog {
    struct CROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: CROG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CROG>(arg0, 6, b"CROG", b"Crazy Frog", b"Merry Christmas my friend", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_S5_EQZ_1zdy7_CZSX_Lm2fme4_EXJHE_Gmqf1_Y_Vu6_Fmdk_N_Vou_W_2bb7513ccf.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CROG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CROG>>(v1);
    }

    // decompiled from Move bytecode v6
}

