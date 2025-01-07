module 0xf7763304cc5c78abec1b83764f03dda36ee15ee74d4d436edbeb792eb96578c4::catfish {
    struct CATFISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATFISH>(arg0, 6, b"CATFISH", b"Cat Fish", x"4e4556455220455645522046414c4c20494e204c4f564520574954482041204d454d45434f494e0a0a554e4c45535320495453204e414d45204953202443415446495348", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ac_Y6_R_Wu_WKM_5_NU_7_Be_SE_4c4z_Qx_B_Zpy_U7p_TLNF_3g5_DTWUC_2_3a214eaf6e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATFISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATFISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

