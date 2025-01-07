module 0x84300a656c18939ab15ef61eceb406d47162d1cf2adbfbbb6652a3c83c30c4f7::dvinci {
    struct DVINCI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DVINCI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DVINCI>(arg0, 6, b"DVINCI", b"Davinci Jeremie", b"Just buy 1$ worth, Please", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/5j_FJ_Cv_Ngg8yt_GW_Bygoqua_UC_6b_M_Zyr7_C5jm_GHEC_Bzrx_R5_c1217d9426.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DVINCI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DVINCI>>(v1);
    }

    // decompiled from Move bytecode v6
}

