module 0x826c93bb9f1bab5a591237df600af210f1f96f5ed2c77e74574a83915ffc9ac4::suizzy {
    struct SUIZZY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIZZY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIZZY>(arg0, 6, b"SUIZZY", b"SUIZZY THE DUCK", b"quack quack quack quack quack quack quack quack quack quack quack quack quack quack quack quack", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suizzy_8a70d88dd8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIZZY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIZZY>>(v1);
    }

    // decompiled from Move bytecode v6
}

