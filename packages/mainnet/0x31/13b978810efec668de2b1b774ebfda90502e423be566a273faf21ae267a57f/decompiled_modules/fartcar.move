module 0x3113b978810efec668de2b1b774ebfda90502e423be566a273faf21ae267a57f::fartcar {
    struct FARTCAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: FARTCAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FARTCAR>(arg0, 6, b"FARTCar", b"FARTCAT", b"FARTCAT will follow farcoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidpzxy4zqjilcjxrs7eylu6qlgekeriyc7smabte7efkw2sinj2au")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FARTCAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FARTCAR>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

