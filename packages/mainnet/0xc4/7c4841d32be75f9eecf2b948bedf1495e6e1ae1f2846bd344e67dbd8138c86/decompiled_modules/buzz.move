module 0xc47c4841d32be75f9eecf2b948bedf1495e6e1ae1f2846bd344e67dbd8138c86::buzz {
    struct BUZZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUZZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUZZ>(arg0, 6, b"BUZZ", b"Hive AI", x"53696d706c696679696e672044654669207468726f756768206f6e2d636861696e206167656e74732e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qme1_Aw_Rhg_U8_L_Vp_L_Hz_V_Gp_Kr_Rz_UE_Uw_Mj_Mx_S4_G_Abarmr_Foi_EJ_1cdc131499.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUZZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUZZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

