module 0x53f54132c694be04cfd3f84966560bedb2475f5101f6d7342d568df9c0223235::smilecat {
    struct SMILECAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMILECAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMILECAT>(arg0, 6, b"SMIlECAT", b":)CAT", b":):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):):)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Q_Hs_W12bx1_Mj_Uyqkx_Pv_H_Wd_Br_J4yd_QFUGFM_Qrmmu_U_Anw_S6_b3216c7c99.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMILECAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMILECAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

