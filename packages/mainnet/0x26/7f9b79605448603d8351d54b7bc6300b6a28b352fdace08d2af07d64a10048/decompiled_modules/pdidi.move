module 0x267f9b79605448603d8351d54b7bc6300b6a28b352fdace08d2af07d64a10048::pdidi {
    struct PDIDI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PDIDI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PDIDI>(arg0, 6, b"PDIDI", b"PedoDidi", b" Yo, crypto fam! It's time to drop some sick beats and even sicker gains with SCAPE-G.O.A.T., the hottest token this side of the prison yard! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pdidi_b675cc0b88.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PDIDI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PDIDI>>(v1);
    }

    // decompiled from Move bytecode v6
}

