module 0xd47b329c03d4fa07c2f90800615836c52c55572636d643558479e5be1d6f257::scake {
    struct SCAKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCAKE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SCAKE>(arg0, 6, b"SCAKE", b"SuiCake", b"Just a cake", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1000260487_219787aa9f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SCAKE>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCAKE>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

