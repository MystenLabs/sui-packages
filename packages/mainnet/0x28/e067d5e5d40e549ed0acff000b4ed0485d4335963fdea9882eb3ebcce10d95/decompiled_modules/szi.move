module 0x28e067d5e5d40e549ed0acff000b4ed0485d4335963fdea9882eb3ebcce10d95::szi {
    struct SZI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SZI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SZI>(arg0, 6, b"SZI", b"SuiziAI by SuiAI", b"Clone your favorite songs and customise the lyrics - powered by $SZI. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/3345_a552fee048.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SZI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SZI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

