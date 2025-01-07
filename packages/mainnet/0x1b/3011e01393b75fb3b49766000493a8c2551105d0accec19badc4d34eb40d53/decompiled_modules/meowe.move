module 0x1b3011e01393b75fb3b49766000493a8c2551105d0accec19badc4d34eb40d53::meowe {
    struct MEOWE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEOWE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEOWE>(arg0, 6, b"MEOWE", b"Meowecoin", b"making CryptoCat not just a protector, but a symbol of hope in the cyber realm.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000055791_5fbfc7230a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEOWE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEOWE>>(v1);
    }

    // decompiled from Move bytecode v6
}

