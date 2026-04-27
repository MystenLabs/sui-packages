module 0x6cd8332bd716ff3e21cf3cf49ddd435f55ea657ba5e8bc564382499567055614::axbit {
    struct AXBIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: AXBIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AXBIT>(arg0, 6, b"AXBIT", b"AXBIT", b"Launched on Odyssey", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AXBIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AXBIT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

