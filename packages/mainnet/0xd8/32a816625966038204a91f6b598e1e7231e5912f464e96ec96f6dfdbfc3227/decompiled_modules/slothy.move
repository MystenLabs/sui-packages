module 0xd832a816625966038204a91f6b598e1e7231e5912f464e96ec96f6dfdbfc3227::slothy {
    struct SLOTHY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLOTHY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLOTHY>(arg0, 6, b"SLOTHY", b"Slothy", b"Slothy takes over SUI now", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Herunterladen_436c710d62.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLOTHY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLOTHY>>(v1);
    }

    // decompiled from Move bytecode v6
}

