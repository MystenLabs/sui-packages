module 0x7d5cf826fe034eec612bcd5d4b39f296fc9e9a93ada4fce42328bece7897cf20::ketyswag {
    struct KETYSWAG has drop {
        dummy_field: bool,
    }

    fun init(arg0: KETYSWAG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KETYSWAG>(arg0, 6, b"Ketyswag", b"Kety Swag", b"Katyswag : Im Blue and Gorgeous!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidltwqpakxel7eo2wempxsnpa2nmp5w35e4czue2jqgyieyemp46u")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KETYSWAG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KETYSWAG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

