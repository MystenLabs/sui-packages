module 0xe5d9c7bae6249e19f834c652546bb45c5d820aab2b1d6d0bf22c68fa3ad17a59::z3nai {
    struct Z3NAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: Z3NAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<Z3NAI>(arg0, 6, b"Z3NAI", b"Zen AI", b"Master your trades with AI. Find your Zen, stay balanced, and optimize results.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736266576453.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<Z3NAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<Z3NAI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

