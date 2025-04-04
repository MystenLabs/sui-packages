module 0x38866daff485e6e04f98e1be087194ec8c078b0046597624436886a023c17c23::vivary {
    struct VIVARY has drop {
        dummy_field: bool,
    }

    fun init(arg0: VIVARY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VIVARY>(arg0, 9, b"VIVARY", b"Viva", b"NEW MEM", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/c4b8c348f7f158136bb080fc8f572d86blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VIVARY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VIVARY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

