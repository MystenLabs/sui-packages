module 0x9a9f476a782e4f11860ce6d9fbbf43324a02a2e1a6d6e1cb17dfa3f6fc07c538::trmpz {
    struct TRMPZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRMPZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRMPZ>(arg0, 6, b"TRMPZ", b"Trumpzter", b"Dump the Lies, Mint the Truth", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/trmpz_2_ae28ec0d9c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRMPZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRMPZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

