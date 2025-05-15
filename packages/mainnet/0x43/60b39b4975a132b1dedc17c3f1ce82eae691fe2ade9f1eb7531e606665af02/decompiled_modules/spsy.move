module 0x4360b39b4975a132b1dedc17c3f1ce82eae691fe2ade9f1eb7531e606665af02::spsy {
    struct SPSY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPSY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPSY>(arg0, 6, b"SPSY", b"SHINY PSYDUCK", b"Yes - I know it's a crazy idea - but I'll do it! Shiny PSYDUCK just got brought to life in SUI BLOCKCHAIN!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreic5cawvga46sjhr4laczuhzkobcuu2vra5gcy6x5l6v7ugl6xpoj4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPSY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SPSY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

