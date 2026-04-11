module 0xa092811148f2c37b0b7ea3e45ef8d49081a393290108d09c85e6346ee02f1e20::spartans {
    struct SPARTANS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPARTANS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPARTANS>(arg0, 6, b"SPARTANS", b"SPARTANS", b"Launched on Odyssey", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPARTANS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SPARTANS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

