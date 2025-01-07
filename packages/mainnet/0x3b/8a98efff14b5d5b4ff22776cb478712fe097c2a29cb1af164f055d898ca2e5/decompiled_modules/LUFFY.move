module 0x3b8a98efff14b5d5b4ff22776cb478712fe097c2a29cb1af164f055d898ca2e5::LUFFY {
    struct LUFFY has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUFFY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUFFY>(arg0, 9, b"LUFFY", b"SUI D. Luffy", b"LUFFY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/DhDPXfXXCA82EmuUDuRMwNNqs2SLJQd6N6vFn74skVp5.png?size=lg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LUFFY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUFFY>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<LUFFY>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<LUFFY>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

