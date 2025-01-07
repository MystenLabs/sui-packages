module 0xb39912773ba4015d222e347ec7eb33d35bdd0c8c401e6c64c03af097daea0343::neko {
    struct NEKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEKO>(arg0, 6, b"NEKO", b"NEKO COIN", x"4f6666696369616c2063757272656e6379206f66207468652046656c696e65732e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmf_U_Sx_A_Nsb_DQFX_Jv_S7w4_QB_Cp_Yvu_La_H_Jc9_Uu9d_Q9_Lhs_Y1_B9_b8375478d7.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

