module 0x49d78eb24464ab95817a7feb1569a877607bff850060be9126fbcde1b48f0728::megamind {
    struct MEGAMIND has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEGAMIND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEGAMIND>(arg0, 6, b"Megamind", b"Megamind on Sui", b"Big brains, bigger moves! $MEGAMIND is taking over the Sui blockchain with genius-level strategies and meme-worthy style.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Megamind_e5892ae827.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEGAMIND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEGAMIND>>(v1);
    }

    // decompiled from Move bytecode v6
}

