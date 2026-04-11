module 0xec1c3128ee35eecee84ae2122400b89d91f3ccb83128efc4a5b69535d24b1bfc::spartans {
    struct SPARTANS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPARTANS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPARTANS>(arg0, 6, b"SPARTANS", b"SPARTANS", b"Launched on Odyssey", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPARTANS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SPARTANS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

