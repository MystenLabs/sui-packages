module 0xb07e8ede0cf73b00aa23efa15f09a3fa50fb2e4248fb92892e4c772b0b2dc314::doglemonade {
    struct DOGLEMONADE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGLEMONADE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGLEMONADE>(arg0, 6, b"Doglemonade", b"dog at a lemonade stand", b"This dog wants to sell you some lemonade.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Pn_G5hx_CDUX_Rhws_C9_L_Pnw_S_Chh_BAHG_3s_F_Dekc_Ly_Dsmy61_X_916100b959.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGLEMONADE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGLEMONADE>>(v1);
    }

    // decompiled from Move bytecode v6
}

