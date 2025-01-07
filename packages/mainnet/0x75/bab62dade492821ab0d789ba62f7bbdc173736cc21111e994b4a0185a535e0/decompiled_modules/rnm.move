module 0x75bab62dade492821ab0d789ba62f7bbdc173736cc21111e994b4a0185a535e0::rnm {
    struct RNM has drop {
        dummy_field: bool,
    }

    fun init(arg0: RNM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RNM>(arg0, 6, b"RNM", b"Real Nigga Milton", b"on my demon arc omw to fuck shit up in flawda on foenem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Tx2_Lam1yd41_XPJ_4w_Ht_Jn_Vg_W3_EQ_Gg_Y_Bsw_Hr_Brvteqh_Jfj_8760f1f463.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RNM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RNM>>(v1);
    }

    // decompiled from Move bytecode v6
}

