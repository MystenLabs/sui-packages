module 0x432ab320ad93ddc54b20b092067cbc384a393dc9fbafdc40930e866c96261a83::rickroll {
    struct RICKROLL has drop {
        dummy_field: bool,
    }

    fun init(arg0: RICKROLL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<RICKROLL>(arg0, 6, b"RICKROLL", b"RickRoll", b"Make a song like rickroll", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/rick_29b6c2fd7d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<RICKROLL>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RICKROLL>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

