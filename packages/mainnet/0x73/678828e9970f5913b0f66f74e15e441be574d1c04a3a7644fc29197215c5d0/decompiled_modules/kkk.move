module 0x73678828e9970f5913b0f66f74e15e441be574d1c04a3a7644fc29197215c5d0::kkk {
    struct KKK has drop {
        dummy_field: bool,
    }

    fun init(arg0: KKK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KKK>(arg0, 6, b"KKK", b"Kabal Kitty Kat", b"join the kabal kitty kommunity :)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_UXX_2_K_Jd_Gw_R2_A8_Jfg_Xz_Lnt_Gaj3n_J_Md6y_HG_Ng_Mxjtt_S_Hy_Q_76f06ab5d0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KKK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KKK>>(v1);
    }

    // decompiled from Move bytecode v6
}

