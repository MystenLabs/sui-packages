module 0x89d45f411dcc8ec8b2892a978cd508b82a9d35189f0ec8622be8ef9459abf671::Believe {
    struct BELIEVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BELIEVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BELIEVE>(arg0, 9, b"BELIEVE", b"Believe", b"just believe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/media/GzymwQJXcAAG48W?format=jpg&name=large")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BELIEVE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BELIEVE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

