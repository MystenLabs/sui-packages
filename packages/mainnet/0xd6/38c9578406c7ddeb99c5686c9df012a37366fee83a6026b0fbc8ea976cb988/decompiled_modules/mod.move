module 0xd638c9578406c7ddeb99c5686c9df012a37366fee83a6026b0fbc8ea976cb988::mod {
    struct MOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOD>(arg0, 9, b"MOD", b"MONAD", x"546573742c20506c61792c20616e64204275696c64206f6e204d6f6e616420204c4159455220310a4765742053746172746564", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/0efbe967aa26352150e35f80e884f43fblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

