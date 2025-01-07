module 0xa8cbd50bbe3d9bdc69ba354b8579467c772867f6f236dff5492426eec47a6271::dcs {
    struct DCS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DCS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DCS>(arg0, 6, b"DCS", b"DoyerCatSoon", x"4c61756e6368696e6720536f6f6e21204a6f696e2074686520436f6d6d756e697479210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_SB_9_St_Ld_DH_Sdd6_W_Zcjrp_Kmrfp2_Nzvx49gi_Z6p4k_Xm3ng9_770c2e34e1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DCS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DCS>>(v1);
    }

    // decompiled from Move bytecode v6
}

