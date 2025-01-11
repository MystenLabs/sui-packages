module 0x654ad9cec87991802e72c6edb1a542658246b361643ad6278b6c953627150342::chonky {
    struct CHONKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHONKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHONKY>(arg0, 6, b"CHONKY", b"Chonky", x"4f48204c4157442c20484520434f4d494e472e2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Qv_P4x_CS_92_AC_Hrh_Zp_M8_Gz_Cxz_GE_7_S2e_X1_DC_Sf9_UB_Hz_Tt_CV_af8b7c3974.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHONKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHONKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

