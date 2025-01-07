module 0x4b7b208177ce0627fb25ae007f5365f61a407a67313297ee34299141c250753b::frog {
    struct FROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FROG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FROG>(arg0, 6, b"FROG", b"Sui Frog", b"Meet Sui $FROG. FROG is a token inspired by the book \"Frog and Toad\" (1971) by Arnold Lobel. It is not Pepe, it is 40 years older. FROG OS features apps to engage users.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sm6_Lo_Si_RQLM_28r_Mgcd8_Gt_R5_X_Bk_ZFMEY_Xg_E_Ugw_Cxpump_2fa4e34056.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FROG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FROG>>(v1);
    }

    // decompiled from Move bytecode v6
}

