module 0xafd7b937cd70dd3d735c5f22524c04e77da583de992ae6ffdcf340ad6e1ffab::adadada {
    struct ADADADA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADADADA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ADADADA>(arg0, 6, b"ADADADA", b"TEST", b"aaaaaaaaaaaaaaaa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihvjlic42nmpsckljeev4nep4b7xbu2hhkd7vdlijvr2rph6wcagq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADADADA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ADADADA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

