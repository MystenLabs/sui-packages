module 0x45a1d3875121d3116b3c891e877b8287922c8b26967b2233821927f8ddab2b59::cetusback {
    struct CETUSBACK has drop {
        dummy_field: bool,
    }

    fun init(arg0: CETUSBACK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CETUSBACK>(arg0, 6, b"CETUSBACK", b"CETUS IS BACK", b"Cetus back atvfew hours", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeibewiqkl3e4sz3wqh7oyvqhc2c6kxzphx7dhb5irxihykqv7g6uhi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CETUSBACK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CETUSBACK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

