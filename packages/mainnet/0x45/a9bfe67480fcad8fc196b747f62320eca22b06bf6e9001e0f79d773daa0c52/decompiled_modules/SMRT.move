module 0x45a9bfe67480fcad8fc196b747f62320eca22b06bf6e9001e0f79d773daa0c52::SMRT {
    struct SMRT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMRT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMRT>(arg0, 6, b"SMRT", b"Samurai Attack", b"Samurai Attack No once can beat me", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://uptos-pump.myfilebase.com/ipfs/QmSXtZD4gBjvHhVqUcgYkEy3JpHWNDnxX7Fmr7dJG7i32A")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SMRT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMRT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

