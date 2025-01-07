module 0x3b81ceb934c21250dba60e5b8f383e76fc1b60294ff5460a122268c77966fda3::turtai {
    struct TURTAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TURTAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TURTAI>(arg0, 6, b"TURTAI", b"TURTLE AI", b"Turtle AI is a blockchain turtle-based coin, we are developing a game with a telegram bot", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736015603552.29")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TURTAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TURTAI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

