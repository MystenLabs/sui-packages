module 0xde8f8fec44151cadb4c315937562483c56f5c361316db293a3e6417f6516922e::melaniameme {
    struct MELANIAMEME has drop {
        dummy_field: bool,
    }

    fun init(arg0: MELANIAMEME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MELANIAMEME>(arg0, 6, b"Melaniameme", b"Melania Meme", b"Melania Meme On Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7826_6209afdddd.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MELANIAMEME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MELANIAMEME>>(v1);
    }

    // decompiled from Move bytecode v6
}

