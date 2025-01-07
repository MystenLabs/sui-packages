module 0x16b3dd1171ec000cb6efba651c083f55d509c823faf97297060cf14d6d278742::ufo {
    struct UFO has drop {
        dummy_field: bool,
    }

    fun init(arg0: UFO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UFO>(arg0, 6, b"UFO", b"unidentified flying octopus", x"756e6964656e74696669656420666c79696e67206f63746f7075730a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Rb_Ctc_Dc_Z_Rs_Bn_DRX_Jj_Vo_Se_Tc_Tvag_UZ_4b_V_Akf_B7qw_Hp_P4w_c63da308d1.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UFO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UFO>>(v1);
    }

    // decompiled from Move bytecode v6
}

