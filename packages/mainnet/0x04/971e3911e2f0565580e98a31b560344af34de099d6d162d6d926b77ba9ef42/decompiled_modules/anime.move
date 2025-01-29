module 0x4971e3911e2f0565580e98a31b560344af34de099d6d162d6d926b77ba9ef42::anime {
    struct ANIME has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANIME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANIME>(arg0, 6, b"DIM", b"DIM", b"DIM ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://assets.artistfirst.in/uploads/1737714071132-Anime.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANIME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ANIME>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

