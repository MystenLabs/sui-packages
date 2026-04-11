module 0x3d8135aec23636f0dbadbc58a0bc4a4fd0ff964caf4c40cf2fa120ba80bdd169::spartan {
    struct SPARTAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPARTAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPARTAN>(arg0, 6, b"SPARTAN", b"SPARTAN", b"Launched on Odyssey", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPARTAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SPARTAN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

