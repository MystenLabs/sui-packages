module 0x3456fcb81b3344450ba8fc5a62e11c87cefd969e002f76ebada483d0a58f3665::volt {
    struct VOLT has drop {
        dummy_field: bool,
    }

    fun init(arg0: VOLT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VOLT>(arg0, 6, b"VOLT", b"Volt Ai", b"VOLT is a powerful AI Launchpad enabling anyone to build, test, and deploy AI tools visually - No deep ML knowledge required.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiavcuclsbehi363wswoefjjjyyjtet5vtuvf2g7xqu2tqqrmgubny")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VOLT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<VOLT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

