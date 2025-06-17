module 0xd14ff0b162ec26732dc5de5da787d4aa7e2168e15cf5d5f52c750be54d7fdcd1::exp {
    struct EXP has drop {
        dummy_field: bool,
    }

    fun init(arg0: EXP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EXP>(arg0, 6, b"EXP", b"Espresso macchiato", b"Espresso macchiato porfavore", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihfplmxmsq6upbkjkr6jmzhmsgdfknjhzffwuogorskx34qmokr4m")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EXP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<EXP>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

