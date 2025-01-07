module 0x7710b8effa235ca3807073470b24c63651053aeb9e0ba992f60e4a1338bbb7fb::hopla {
    struct HOPLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPLA>(arg0, 6, b"HOPLA", b"Hopla on sui", b"$HOPLA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmd_Utt_VQ_2_Fxqkr_Msx_Hhbt2n_Q1g_F_Ynub_A69_Ks_G_Qp_A85_Ax3j_9a585dc35e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOPLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOPLA>>(v1);
    }

    // decompiled from Move bytecode v6
}

