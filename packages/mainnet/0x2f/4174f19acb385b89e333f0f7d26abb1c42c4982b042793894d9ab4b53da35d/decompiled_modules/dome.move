module 0x2f4174f19acb385b89e333f0f7d26abb1c42c4982b042793894d9ab4b53da35d::dome {
    struct DOME has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOME>(arg0, 6, b"DOME", b"Department of Memes Efficiency", b"Department of Memes Efficiency programmed to 1 billy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmf_MD_2956_DG_62_Lot_Y7_Vdu5_Ufeow6_Pdf8yoan_D8yvuf_Uea4_e74fee7fb5.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOME>>(v1);
    }

    // decompiled from Move bytecode v6
}

