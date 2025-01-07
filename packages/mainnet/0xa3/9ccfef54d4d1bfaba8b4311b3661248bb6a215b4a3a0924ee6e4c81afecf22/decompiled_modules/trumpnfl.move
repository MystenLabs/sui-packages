module 0xa39ccfef54d4d1bfaba8b4311b3661248bb6a215b4a3a0924ee6e4c81afecf22::trumpnfl {
    struct TRUMPNFL has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPNFL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPNFL>(arg0, 6, b"TrumpNFL", b"Trump Quarterback", b"America need a Trump quarterback ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000061341_42b273c5a1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPNFL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUMPNFL>>(v1);
    }

    // decompiled from Move bytecode v6
}

