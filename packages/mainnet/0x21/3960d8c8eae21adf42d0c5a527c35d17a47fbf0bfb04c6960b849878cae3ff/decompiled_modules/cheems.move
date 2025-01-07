module 0x213960d8c8eae21adf42d0c5a527c35d17a47fbf0bfb04c6960b849878cae3ff::cheems {
    struct CHEEMS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHEEMS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHEEMS>(arg0, 6, b"CHEEMS", b"SUI CHEEMS", b"Cheems $CHEEMS not only embodies the spirit of the iconic Shiba Inu meme but also harnesses its meme potential to create a dynamic and engaging community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/catclub_7e173cc471_2bf5c5d7a8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHEEMS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHEEMS>>(v1);
    }

    // decompiled from Move bytecode v6
}

