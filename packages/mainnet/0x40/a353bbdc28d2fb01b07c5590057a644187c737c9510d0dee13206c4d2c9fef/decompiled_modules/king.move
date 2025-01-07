module 0x40a353bbdc28d2fb01b07c5590057a644187c737c9510d0dee13206c4d2c9fef::king {
    struct KING has drop {
        dummy_field: bool,
    }

    fun init(arg0: KING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KING>(arg0, 6, b"KING", b"KING CRAB", b"I am a king crab swimming in the sea", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmd6q_Do_Kcpda_EV_5_X_Szqie_P1_Ua_CN_2r_Z_Tcr_BE_2h_Jfb_Ci_Uc_Zu_5fc20021ac.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KING>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KING>>(v1);
    }

    // decompiled from Move bytecode v6
}

