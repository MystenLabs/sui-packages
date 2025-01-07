module 0x6d05fdf6b9f7acd2b906349e11a3b0cd02a6e8e0be05fd4b5fe4b65ceb131651::haha1 {
    struct HAHA1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAHA1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAHA1>(arg0, 9, b"Haha1", b"Haha123123", b"Test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/664f0c8e439321a1f26e95a55b2cbdd6blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HAHA1>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAHA1>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

