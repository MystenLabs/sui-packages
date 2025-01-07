module 0x87cdbf13b0ae4a5040350dc355a9791686825784a37cc478bf5ef1fc4c5af3d8::smoss {
    struct SMOSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMOSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMOSS>(arg0, 6, b"SMOSS", b"SMOSSONSUI", b"$SMOSS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmb_Di_Doy3w9g8_Lcsz_Lgc_E2e_V8_HY_1_Yc_DT_9tr_C898_Ug_XB_Qhp_cdc8a69651.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMOSS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMOSS>>(v1);
    }

    // decompiled from Move bytecode v6
}

