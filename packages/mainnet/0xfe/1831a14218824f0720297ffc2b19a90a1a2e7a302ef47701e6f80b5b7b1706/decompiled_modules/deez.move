module 0xfe1831a14218824f0720297ffc2b19a90a1a2e7a302ef47701e6f80b5b7b1706::deez {
    struct DEEZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEEZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEEZ>(arg0, 6, b"DEEZ", b"DeeznutonSui", b"Official account for Turbos, the first rent-free token standard on SUI. Home to Deez $NUTS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731086306407.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DEEZ>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEEZ>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

