module 0x541b56e7378b21ba7cbca78c1e232d098dcb9f5d48e41420b1bea78aa6c06711::griddy {
    struct GRIDDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRIDDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRIDDY>(arg0, 9, b"GRIDDY", b"Griddy", b"Griddy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/A21r5h19iHhQt6b7vzkgHNgMaSAR9YSazGeJedJepump.png?size=lg&key=54f4d0")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GRIDDY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GRIDDY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRIDDY>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

