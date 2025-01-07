module 0x82b55fbf39c76138ab8cc7d4e50e09a4146f4937566853cd2e0348433db2a636::dobby {
    struct DOBBY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOBBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOBBY>(arg0, 6, b"DOBBY", b"Dobby", b"Choo-wawa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Tq1b_Wd71n_J2w5_NL_Bhr_Y8_Vrmes_S92vso_S_Bbh_EPCE_Vzy_Zs_bf39f20ebf.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOBBY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOBBY>>(v1);
    }

    // decompiled from Move bytecode v6
}

