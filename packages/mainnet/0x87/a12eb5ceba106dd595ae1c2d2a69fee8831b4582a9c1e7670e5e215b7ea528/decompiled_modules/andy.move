module 0x87a12eb5ceba106dd595ae1c2d2a69fee8831b4582a9c1e7670e5e215b7ea528::andy {
    struct ANDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANDY>(arg0, 0x83fa035d3d43c4da8af5c961cb604cd564e13b9622c306eb5127ae8fbf761ca7::constants::lp_decimals(), b"ANDY", b"A", b"Andy coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aftermath.finance/coins/perpetuals/default.svg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ANDY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANDY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

