module 0x6847ff694191b4c2e484f322fbd6f6951dea23fa10a92a599bf5e518e864e0f4::suizoo {
    struct SUIZOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIZOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIZOO>(arg0, 6, b"SUIZOO", b"SUI ZOO", b"Welcome to SUIZOO. On SUI ecosystem, explore all aquatic animals include fish, lobsters, dolphins, jellyfish, sharks, sea turtles, starfish, crabs, octopus, whales, seahorses, squid, swordfish, shrimp, killer whales, manta rays, otters, and oysters.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/CZOO_1b9cb5664e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIZOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIZOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

