module 0x8e3cdcc8d1abd74eacb1dcf81283f5af405b456b29dc011c843c4d163c242cad::rurika {
    struct RURIKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: RURIKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RURIKA>(arg0, 6, b"Rurika", b"Rurika AI", x"527572696b612041492024527572696b610a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmddz_Qn7bip_Ps_Xs_Dd_MU_3_R8_Lqfe_Lm_Y_Kg8_Wk58_Ho_Tk_KQ_5_Nm_D_45b6725aad.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RURIKA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RURIKA>>(v1);
    }

    // decompiled from Move bytecode v6
}

