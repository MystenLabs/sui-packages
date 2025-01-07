module 0x20434098a23337dccd00b931af7050e762eb1ecabcca531b7f507b7b5933bafb::hpepe {
    struct HPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HPEPE>(arg0, 6, b"HPEPE", b"Halloween PEPE", b" Halloween Pepe is launching on movepump.com!  Get ready, everyonegrab some SUI coins and join the spooktacular fun with Pepe this Halloween!  ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/5812328308115883108_fa761f5fd8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HPEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HPEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

