module 0x8b24525e4c7495c2bef2b7fc7241acdb5113afaa6629bf71d2d09c4cbe82b89e::one {
    struct ONE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ONE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ONE>(arg0, 9, b"ONE", b"One dolla", b"One dollar memecoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2597ed72-c498-44ef-8522-00489bbc113c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ONE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ONE>>(v1);
    }

    // decompiled from Move bytecode v6
}

