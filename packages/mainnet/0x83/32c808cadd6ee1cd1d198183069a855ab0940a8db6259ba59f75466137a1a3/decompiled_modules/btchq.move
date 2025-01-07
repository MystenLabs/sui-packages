module 0x8332c808cadd6ee1cd1d198183069a855ab0940a8db6259ba59f75466137a1a3::btchq {
    struct BTCHQ has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTCHQ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BTCHQ>(arg0, 6, b"BTCHQ", b"BTC Headquarters", x"49726f6e6d616e204d69636861656c205361796c6f72206973206275737920736176696e672043727970746f2c207573696e6720616e79206d65616e73206e656365737361727920746f20627579206d6f726520426974636f696e210a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Bh_B_Poe6_Xs_AQ_8o_SQ_7uai_U_Krbz_MC_3rb_Kuv_Yo7s5_R_Kq_HR_97_e74d32ff14.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTCHQ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BTCHQ>>(v1);
    }

    // decompiled from Move bytecode v6
}

