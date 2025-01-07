module 0x8448fe76e1105c9829eaa9e0e5dbff459ffa3563a6ec66ff35b81787b683adaf::rock {
    struct ROCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROCK>(arg0, 6, b"ROCK", b"The Rock", b"It's Just a Rock", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_9980_8fe774e530.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ROCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

