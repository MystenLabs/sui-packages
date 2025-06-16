module 0xa7263f99c2d5f129bdc35d5c7cbf12bded2646b05a871e20d19b96a97a987fbe::bio {
    struct BIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIO>(arg0, 9, b"BIO", b"Black It Out", b"Just black it out ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/07ea18e0a66253b25b34d835f486be4fblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BIO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

