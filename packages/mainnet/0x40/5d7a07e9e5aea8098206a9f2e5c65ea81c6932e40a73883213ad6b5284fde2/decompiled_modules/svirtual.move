module 0x405d7a07e9e5aea8098206a9f2e5c65ea81c6932e40a73883213ad6b5284fde2::svirtual {
    struct SVIRTUAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SVIRTUAL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SVIRTUAL>(arg0, 6, b"SVIRTUAL", b"SVIRTUAL by SuiAI", b"VIRTUAL on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/virtual_protocol1709913329667_a3295849c5.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SVIRTUAL>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SVIRTUAL>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

