module 0x7cdf690fe0f8c57f5b9db27641078470e9e133f83898cb5c4df695e55dfa47ad::grazer {
    struct GRAZER has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRAZER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRAZER>(arg0, 6, b"GRAZER", b"GRAZER MEME", b"GRAZER MEME TOKEN ON SUI ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Q_Nv3k676b7_Ct_ZH_Qgj_Y_Lo7_A2_D_Jj_Nx65f_D_Pmn7_Py_Jseaw8_fdb880dc77.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRAZER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GRAZER>>(v1);
    }

    // decompiled from Move bytecode v6
}

