module 0x46c177e3a87949d8ea8b91a8082e2c01ac8e1a90927f7e1b344ef79586d738e4::aigentj {
    struct AIGENTJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIGENTJ, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<AIGENTJ>(arg0, 6, b"AIGENTJ", b"Aigent J by SuiAI", b"AI character based on Agent J from the 'Men in Black' (MIB) series.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/aigent_J_89b0aeca60.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AIGENTJ>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIGENTJ>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

