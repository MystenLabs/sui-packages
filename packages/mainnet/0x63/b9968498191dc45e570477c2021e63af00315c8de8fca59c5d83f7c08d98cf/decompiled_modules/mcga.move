module 0x63b9968498191dc45e570477c2021e63af00315c8de8fca59c5d83f7c08d98cf::mcga {
    struct MCGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MCGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MCGA>(arg0, 6, b"MCGA", b"Make Cetus Great Again", b"Just one mission: Make Cetus Great Again.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeidlchaegw4f6difuu2b3lqcuappyrwkchurxkfckouyyhb5eb3aj4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MCGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MCGA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

