module 0x501d74e828f8ed8fbf217ac5d04072af22d5e9377f0c847ca003c712659a1822::perapera {
    struct PERAPERA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PERAPERA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PERAPERA>(arg0, 6, b"PERAPERA", b"perapera", x"54686f7365206f6620796f752077686f2061726520726561647920666f722074686520686579646179206f662050657261706572612c20636f6d65206f6e20696e2e20596f752077696c6c2073656520746865207472756520657373656e6365206f6620612074727565206d656d652070726f6a6563742e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_SAN_Yhdt_ANP_Ro_Yik6uwb_T81_Ruqo_MN_92dq_Xt_AYE_Jak85g_Q_cea61d7626.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PERAPERA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PERAPERA>>(v1);
    }

    // decompiled from Move bytecode v6
}

