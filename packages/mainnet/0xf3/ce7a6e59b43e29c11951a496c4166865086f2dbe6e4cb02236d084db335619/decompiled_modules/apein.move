module 0xf3ce7a6e59b43e29c11951a496c4166865086f2dbe6e4cb02236d084db335619::apein {
    struct APEIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: APEIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<APEIN>(arg0, 6, b"APEIN", b"APEIN SUI", b"king of the jungle & worshipper of bananas.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmf1mx_Kfmyh1v3_NL_Ayt_Nfm_Uh1gv_J7_Xy_P_Gj_Sd_K_Bc_AJ_Tj_G_No_d9db71e459.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<APEIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<APEIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

