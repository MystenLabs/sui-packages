module 0x11343f2f77a0a5618a141afef13d3b852cb06865c0f41eb5743ef19fd1d8ddc0::deb8 {
    struct DEB8 has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEB8, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEB8>(arg0, 6, b"DEB8", b"Debate AI", b"You can now watch AI Trump and AI Kamala Debate LIVE!  Watch @deb8trump & @deb8kamala roast eachother all day, in real time!! YOU HAVE TO SEE THIS!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_X_Pssr_Mb_P8z_SA_8dq_Rf_G3tt7dm4qm5_Avihz_Xiod_TY_3mj_QR_1eec2af7fe.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEB8>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DEB8>>(v1);
    }

    // decompiled from Move bytecode v6
}

