module 0x10703a167289323e9b3fdb4d758f602f240bef403d2637e578004702091098fd::popkat {
    struct POPKAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPKAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPKAT>(arg0, 6, b"POPKAT", b"Popkat Sui", b"The kat that Pops, multichain meme maskot on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000002377_8693b4edb1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPKAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POPKAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

