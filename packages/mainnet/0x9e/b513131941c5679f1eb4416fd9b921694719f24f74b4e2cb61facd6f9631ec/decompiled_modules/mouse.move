module 0x9eb513131941c5679f1eb4416fd9b921694719f24f74b4e2cb61facd6f9631ec::mouse {
    struct MOUSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOUSE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOUSE>(arg0, 6, b"MOUSE", b"Anonymouse", x"47657420726561647920666f7220736f6d657468696e67204855474520616e6420415745534f4d45210a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Mouse_T_Au_Rqr_SH_Ngyoyv_AA_Hi_0e7f31942e_b8563bd663.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOUSE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOUSE>>(v1);
    }

    // decompiled from Move bytecode v6
}

