module 0xc68550154c5e06139afb81dac91bfcb342f3707897d31b788067d7d087b5cd8::bluzo {
    struct BLUZO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUZO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUZO>(arg0, 6, b"BLUZO", b"Bluzo On Sui", b"One silent night at the North Pole, a mysterious portal opened in the sky. From it emerged Bluzo, an otherworldly being drawn to Earth by an ancient signal buried beneath the ice.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiho54mmescd3oryxcf6qvmtlvrscr3orhepqnusm56gcb7xkb7wse")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUZO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BLUZO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

