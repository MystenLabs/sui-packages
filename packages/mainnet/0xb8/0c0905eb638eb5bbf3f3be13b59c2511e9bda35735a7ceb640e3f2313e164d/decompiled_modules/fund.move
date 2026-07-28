module 0xb80c0905eb638eb5bbf3f3be13b59c2511e9bda35735a7ceb640e3f2313e164d::fund {
    struct FUND has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUND>(arg0, 9, b"FUND", b"Whale Fund Test Coin", b"Test-only currency for the whale-sui fund harness. Not a real asset.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://example.invalid/fund")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FUND>>(v1);
    }

    // decompiled from Move bytecode v7
}

