module 0xb01fed0539580e737253b01a80f99e7b74b9a524b5c8471d6704fe92d457ca12::gsui {
    struct GSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<GSUI>(arg0, 6, b"GSUI", b"GramSUI", b"Gramsui comings ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Diamond_256_397a018535.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GSUI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GSUI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

