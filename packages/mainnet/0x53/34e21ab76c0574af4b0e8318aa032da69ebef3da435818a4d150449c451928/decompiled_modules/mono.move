module 0x5334e21ab76c0574af4b0e8318aa032da69ebef3da435818a4d150449c451928::mono {
    struct MONO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MONO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MONO>(arg0, 6, b"MONO", b"MONOBOY", b"$MONO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_P_Fo_R_Mms_ZD_Atdosngb9gf_Wyk_V6_Qo7f_Ue_X9esass6_XQ_7yw_fff9dcb5b4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MONO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MONO>>(v1);
    }

    // decompiled from Move bytecode v6
}

