module 0x9d9e5d5e517372c2c34d16dfae899ab79cd6dac1165c914ff226e7b4e981e842::pinkkirby {
    struct PINKKIRBY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PINKKIRBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PINKKIRBY>(arg0, 6, b"PINKKIRBY", b"Pink Kirby", x"50696e6b204b69726279202d20546865204d6173636f74206f66205355490a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/kirby_9598a5bf4d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PINKKIRBY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PINKKIRBY>>(v1);
    }

    // decompiled from Move bytecode v6
}

