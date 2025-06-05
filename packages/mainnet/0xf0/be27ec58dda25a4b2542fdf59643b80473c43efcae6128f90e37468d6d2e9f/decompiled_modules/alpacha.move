module 0xf0be27ec58dda25a4b2542fdf59643b80473c43efcae6128f90e37468d6d2e9f::alpacha {
    struct ALPACHA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALPACHA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALPACHA>(arg0, 6, b"ALPACHA", b"AlpachART", b"Cheers to Alpacha for bringing spirits and spreading happiness throughout the Sui community!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiaruxxzg5rjoorkzi6z2vuo4bk2jgaespvp3x3zrymsiha3sdjamq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALPACHA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ALPACHA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

