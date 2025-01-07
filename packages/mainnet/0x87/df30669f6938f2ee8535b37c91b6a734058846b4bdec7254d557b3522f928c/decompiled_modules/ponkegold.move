module 0x87df30669f6938f2ee8535b37c91b6a734058846b4bdec7254d557b3522f928c::ponkegold {
    struct PONKEGOLD has drop {
        dummy_field: bool,
    }

    fun init(arg0: PONKEGOLD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PONKEGOLD>(arg0, 6, b"PONKEGOLD", b"Ponke Gold", x"4368616e67696e67207468652063756c7475726520472e0a0a4a6f696e2074686520537569206d6f76656d656e7420236265636f6d6561470a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2o_K_Drpj2rn_Jgf1w_E2d9_P_Rr_G4_Grig_MJ_5_H8t_Bo_H_Syapump_283ab87a66.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PONKEGOLD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PONKEGOLD>>(v1);
    }

    // decompiled from Move bytecode v6
}

