module 0x9dac4a28ad8ffc32636f2e8ddf017c09212126daabf6db0511f116c583d1006::cha {
    struct CHA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHA>(arg0, 6, b"CHA", b"CHARLIE", b"The one and only non-official Charlie token. We want Charlie on SUI!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/R_ebe2fc131a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHA>>(v1);
    }

    // decompiled from Move bytecode v6
}

