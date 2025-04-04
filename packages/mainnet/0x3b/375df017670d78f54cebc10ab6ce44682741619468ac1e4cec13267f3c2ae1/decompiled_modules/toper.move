module 0x3b375df017670d78f54cebc10ab6ce44682741619468ac1e4cec13267f3c2ae1::toper {
    struct TOPER has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOPER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOPER>(arg0, 9, b"TOPER", b"Top", b"NEW MEM", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/06b743313940d34a93639f4e8132f943blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOPER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOPER>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

