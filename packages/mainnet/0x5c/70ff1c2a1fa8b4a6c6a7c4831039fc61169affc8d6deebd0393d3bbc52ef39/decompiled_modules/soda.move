module 0x5c70ff1c2a1fa8b4a6c6a7c4831039fc61169affc8d6deebd0393d3bbc52ef39::soda {
    struct SODA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SODA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SODA>(arg0, 6, b"Soda", b"SodaOnSui", b"$Soda Ready to buy ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730984690251.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SODA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SODA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

