module 0x25cda7b43fe8b28191736a70dc5a1bb37f4eb54a35845c2372dc2475c876f738::len {
    struct LEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: LEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LEN>(arg0, 6, b"Len", b"Lens", b"l", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241005_223200_d6d8b938a5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

