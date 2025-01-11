module 0x27d08f0c0c373272827dc4fb67857b0c875619af9784c347674935f2084284c::fa {
    struct FA has drop {
        dummy_field: bool,
    }

    fun init(arg0: FA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<FA>(arg0, 6, b"FA", b"Financial Advice by SuiAI", b"Buy now", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_3077_d1759a6591.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

