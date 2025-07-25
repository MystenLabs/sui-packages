module 0xd29ba12cba3ef4841e00da8a77931045c00cf7348b19c743764a0826776f04f9::boss {
    struct BOSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOSS>(arg0, 6, b"BOSS", b"BIG BOSS", b"The Sui Network's Big Smoker Boss Arrives", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihyk2favxhu262q7ylhmoufsruoc5gscc7thhg7wga7lm5v53sun4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOSS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BOSS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

