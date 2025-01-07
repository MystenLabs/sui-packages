module 0x9b2af133b25f3cece248e4e3008c9127c480861dea4b0c5afc8b0e1e45a8e6d5::suyk {
    struct SUYK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUYK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUYK>(arg0, 6, b"SUYK", b"SUYKKUNO", b"Make femboys great again...Not actually a bottom", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/qxma_Y99_400x400_6cdc1894c0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUYK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUYK>>(v1);
    }

    // decompiled from Move bytecode v6
}

