module 0xca4650b4039bd3f38aa01fc2753277df1ee0d7c695b314167be4adf8c24bfef7::srsai {
    struct SRSAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SRSAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SRSAI>(arg0, 6, b"SRSAI", b"SUPER RIZZ SYNDROME AI", b"SUPER RIZZ SYNDROME AI makes you believe in us to the moon and beyond.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Q24tw_F_By_KQ_Ti_P1wzu_FULE_Gar_Y4e_J5_AUR_4ih_L1j_Gd_Ee2c_de007a1355.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SRSAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SRSAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

