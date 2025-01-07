module 0x7cd4fc4a1030def86e8804a3432efe0b619b8d08e2f4b344038fa657055e5f7a::nibles {
    struct NIBLES has drop {
        dummy_field: bool,
    }

    fun init(arg0: NIBLES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NIBLES>(arg0, 6, b"NIBLES", b"Nibles on Sui", b"Nibles was no ordinary flying squirrel. Born in a lab as Part of an experiment, he was imbued with enhanced intelligence. But things went south when he found out about meme coins.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000050122_93b7840a8a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NIBLES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NIBLES>>(v1);
    }

    // decompiled from Move bytecode v6
}

