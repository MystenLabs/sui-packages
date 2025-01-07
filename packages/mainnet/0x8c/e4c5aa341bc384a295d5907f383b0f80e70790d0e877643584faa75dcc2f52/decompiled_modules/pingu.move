module 0x8ce4c5aa341bc384a295d5907f383b0f80e70790d0e877643584faa75dcc2f52::pingu {
    struct PINGU has drop {
        dummy_field: bool,
    }

    fun init(arg0: PINGU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PINGU>(arg0, 6, b"PINGU", b"Pingu", x"2450494e47552069732061206d656d6520434f494e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qma_R_Mb_Mfh_W_Da_Wt_R_Xu_Ez6_SATS_Vw4_W_Brc_Wp_A_Yep6_E_Hu_Ye1_Ff_264c5d5cdb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PINGU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PINGU>>(v1);
    }

    // decompiled from Move bytecode v6
}

