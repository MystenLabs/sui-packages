module 0x393fedae6e152382ed558e1c0c16eede69584e8f1a909f28821a117ca06e7633::Dusted {
    struct DUSTED has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUSTED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUSTED>(arg0, 9, b"DONE", b"Dusted", b"push it ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/media/GzsvUKRXEAA3WOu?format=jpg&name=medium")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DUSTED>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUSTED>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

