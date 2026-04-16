module 0xcf7eeb3d4fc53529996e8903e739cb703528e9b60dd07405b2a3d65afb29d3ee::nav {
    struct NAV has drop {
        dummy_field: bool,
    }

    fun init(arg0: NAV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NAV>(arg0, 6, b"NAV", b"NAV", b"Launched on Odyssey", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NAV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<NAV>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

