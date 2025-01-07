module 0x6b1df84977d04da3e01f62baeb7656c1c1d7d2e7434acae7e7a135a561306d35::smc {
    struct SMC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMC, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SMC>(arg0, 6, b"SMC", b"Sui Meme Cat", b"This is just for fun nothing to expect! It's up to  you if you want to support this 100% memecoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/e83fe73a_6ab2_46e9_abe1_99a08f1a9274_22d42596fa.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SMC>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMC>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

