module 0x240a3d024bad3125306ad70ee546c61f30ebbb1d98d8f78d8440c6273beb3958::aether_token {
    struct AETHER_TOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: AETHER_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AETHER_TOKEN>(arg0, 9, b"AETH", b"Aether", b"Aether (AETH) is the native utility token of the InMotion Aether realm - an AI-orchestrated finance, creator, and infrastructure network on Sui. Fixed 100M supply, fully non-custodial and self-custodied. AETH unlocks access, tooling, and participation across the InMotion stack. A utility token, not a security: no yield, no price promises - its value is what it unlocks.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://inmotion.tech/aether-token.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<AETHER_TOKEN>>(0x2::coin::mint<AETHER_TOKEN>(&mut v2, 100000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AETHER_TOKEN>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<AETHER_TOKEN>>(v2);
    }

    // decompiled from Move bytecode v7
}

