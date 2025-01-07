module 0x7fb294b0826870f40c3ebc40c30b9eab0f9eec4715e5d80b18009cad1b0a13f7::pets {
    struct PETS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PETS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PETS>(arg0, 6, b"PETS", b"Sacred Pets", b"Sacred Pets $PETS is a unique project that unites the symbolism of three sacred forces ($PNUT,$FRED,$CHEYENNE) into a single memecoin centered around the love for pets", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731947178889.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PETS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PETS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

