module 0x9961436f9a09758ba2196d4baaeff9e36ecab5da6ee18e699130698d04147e43::dsag {
    struct DSAG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DSAG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DSAG>(arg0, 6, b"DSAG", b"asdg", b"asd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aftermath.finance/coins/perpetuals/default.svg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DSAG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DSAG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

