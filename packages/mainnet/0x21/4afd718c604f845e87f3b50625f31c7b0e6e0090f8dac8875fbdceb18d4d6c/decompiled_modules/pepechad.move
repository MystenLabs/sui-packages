module 0x214afd718c604f845e87f3b50625f31c7b0e6e0090f8dac8875fbdceb18d4d6c::pepechad {
    struct PEPECHAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPECHAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPECHAD>(arg0, 6, b"PEPECHAD", b"PEPE CHAD", b"Pepe the Chad is back! More powerful and pumped up, ready to dominate the crypto scene. The ultimate alpha meme evolution has landed prepare for the flex! #CHADTAKEOVER WE ARE LOOKING FOR REAL CHADS ONLY, TO BUILD FOUNDATION, JEETS STAY AWAY!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/7_289c334bb6_a1bc9d4b6c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPECHAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPECHAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

