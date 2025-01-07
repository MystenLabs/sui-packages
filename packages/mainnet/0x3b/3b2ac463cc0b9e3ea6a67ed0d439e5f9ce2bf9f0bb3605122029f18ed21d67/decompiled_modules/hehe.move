module 0x3b3b2ac463cc0b9e3ea6a67ed0d439e5f9ce2bf9f0bb3605122029f18ed21d67::hehe {
    struct HEHE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HEHE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HEHE>(arg0, 6, b"HEHE", b"HeHe", b"Pepes Getting Ready for Halloween Early!  Trick or Treat? The community decides!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Vauj_VPBQ_99_ET_Lrsxm_Zdz_Dget98a77_Se_E3wzp_Hp_PN_Su_XA_0819ae3914.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HEHE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HEHE>>(v1);
    }

    // decompiled from Move bytecode v6
}

