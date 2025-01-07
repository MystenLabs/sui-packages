module 0x540087a4696c097dd8da28b71949d0d0692275ebbc7534a4a1caf41885bb5e4::suit {
    struct SUIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIT>(arg0, 6, b"SUIT", b"SUIt", b"Just a SUIt", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/men_s_charcoal_grey_3_piece_tweed_herringbone_suit_stz11_1_400x400_88b737a5a2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

