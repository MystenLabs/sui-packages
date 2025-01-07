module 0x19092ec09d41a915cef9cc6c20c4b653ec918fbd6f5a517ef3a5f0fbff91d408::dan {
    struct DAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAN>(arg0, 6, b"DAN", b"Lieutenant Dan", b"Im staying on the boat.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_W3_Kf_V876_X5_HJ_Es_Cx_Eu_Y_Foas7nmw6o_TP_Hf_Vr_M_Zcwqf_L_Xq_92c4456649.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

