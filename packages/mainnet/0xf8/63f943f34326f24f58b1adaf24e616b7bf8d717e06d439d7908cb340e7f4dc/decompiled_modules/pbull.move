module 0xf863f943f34326f24f58b1adaf24e616b7bf8d717e06d439d7908cb340e7f4dc::pbull {
    struct PBULL has drop {
        dummy_field: bool,
    }

    fun init(arg0: PBULL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PBULL>(arg0, 9, b"PBULL", b"pre bull", b"IF YOU WANT BUY YOU BUY EZ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/bbed3b4eb9cc30f6595108679c5f01ebblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PBULL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PBULL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

