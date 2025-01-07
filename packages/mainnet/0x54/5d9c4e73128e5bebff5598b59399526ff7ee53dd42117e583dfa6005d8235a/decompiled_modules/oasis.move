module 0x545d9c4e73128e5bebff5598b59399526ff7ee53dd42117e583dfa6005d8235a::oasis {
    struct OASIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: OASIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OASIS>(arg0, 6, b"OASIS", b"Oasis Town Ai", b"The first crypto town running entirely by AI agents.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000050819_89ea9b6ed3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OASIS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OASIS>>(v1);
    }

    // decompiled from Move bytecode v6
}

