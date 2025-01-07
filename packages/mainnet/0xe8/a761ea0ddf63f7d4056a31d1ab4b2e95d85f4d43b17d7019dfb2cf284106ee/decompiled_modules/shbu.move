module 0xe8a761ea0ddf63f7d4056a31d1ab4b2e95d85f4d43b17d7019dfb2cf284106ee::shbu {
    struct SHBU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHBU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHBU>(arg0, 6, b"SHBU", b"shbu", b"SHIBU is the DOGE mascot drawn by the artist Fantoumi, itis endorsed by the neiro/kabosu owner", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000375_64d60eda80.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHBU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHBU>>(v1);
    }

    // decompiled from Move bytecode v6
}

