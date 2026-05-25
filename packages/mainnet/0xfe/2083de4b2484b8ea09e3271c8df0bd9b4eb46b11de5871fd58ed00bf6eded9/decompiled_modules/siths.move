module 0xfe2083de4b2484b8ea09e3271c8df0bd9b4eb46b11de5871fd58ed00bf6eded9::siths {
    struct SITHS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SITHS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SITHS>(arg0, 6, b"SITHS", b"SITHS", b"Launched on Odyssey", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SITHS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SITHS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

