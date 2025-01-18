module 0x87c704f504ecc75ada44769bc9cf9664d5757f454810d09e03172b104103f57f::donald {
    struct DONALD has drop {
        dummy_field: bool,
    }

    fun init(arg0: DONALD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<DONALD>(arg0, 6, b"DONALD", b"UNOFFICIAL DONALD TRUMP by SuiAI", b"UNOFFICIAL DONALD TRUMP COIN.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_5653_a4c43be553.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DONALD>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DONALD>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

