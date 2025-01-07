module 0xbf4a16cb52025888622869f78c252d5e7a5ceb7ff9a12bbf49c169e20365aead::grazer {
    struct GRAZER has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRAZER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRAZER>(arg0, 6, b"GRAZER", b"Grazer on sui", b"Touching grass and eating ass. $GRAZER eating ASS, as simple as that.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Q_Nv3k676b7_Ct_ZH_Qgj_Y_Lo7_A2_D_Jj_Nx65f_D_Pmn7_Py_Jseaw8_2ac419f5f9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRAZER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GRAZER>>(v1);
    }

    // decompiled from Move bytecode v6
}

