module 0xc219636ca875e7b2f874defd79fcb1eb272dac5b7d27bc005cd1a177c3377871::spsy {
    struct SPSY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPSY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPSY>(arg0, 6, b"SPSY", b"SHINY PSYDUCK", b"Yes I know it's crazy - as crazy as SHINY PSYDUCK is crazy! We just had SHINY PSYDUCK born in the SUI network! Let's go the same way as PSYDUCK! Those who know Pokemon - know that SHINY PSYDUCK will be great!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreic5cawvga46sjhr4laczuhzkobcuu2vra5gcy6x5l6v7ugl6xpoj4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPSY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SPSY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

