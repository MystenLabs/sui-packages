module 0xedfbd76644d750e3b3bc88f3ffa53bc1608f63297c2e73f681aca3fb8caa0da2::trumpsui {
    struct TRUMPSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<TRUMPSUI>(arg0, 6, b"TRUMPSUI", b"Trump on sui by SuiAI", b"Just a meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1000111997_1b7c721f31.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TRUMPSUI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPSUI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

