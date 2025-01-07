module 0xf8eb5a27101bc59680f41d2193809ded929e68878bd62f5f1e165a04fd88e398::bukay {
    struct BUKAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUKAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUKAY>(arg0, 6, b"BUKAY", b"Yakubs Pet", b"BUKAY is Yakub's first black pet created by a failed tricknology experiment.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Pt_B_Lo_Zvm91_N89vbpqrhkrwy_Xzx4_YG_Kh_Pvz_P_Fats_J4yy_V_d9b9feeb09.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUKAY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUKAY>>(v1);
    }

    // decompiled from Move bytecode v6
}

