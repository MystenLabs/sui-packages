module 0xdc6184bbcdee4a59778c5b9cae2d5097dcc48580b14a6dd3d1d0585e47201103::rich {
    struct RICH has drop {
        dummy_field: bool,
    }

    fun init(arg0: RICH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RICH>(arg0, 6, b"RICH", b"CHOOSERICH", b"I Choose Rich Every Time", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/4_XF_6ar_X_Uc_B_Hy_EBB_7_Zy_RFSSZ_4p_N_Ff_E_Yv_JM_7jg4v_Vw_Gr_BD_05e1de0e82.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RICH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RICH>>(v1);
    }

    // decompiled from Move bytecode v6
}

