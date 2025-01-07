module 0x756ab4a692298c72b8d9e6fdfb7da0b1c02454b2bced308561cae6b4c4e3d48e::catsuu {
    struct CATSUU has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATSUU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATSUU>(arg0, 6, b"CATSUU", b"Cat Sui", b"Community driven meme Project ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000029280_a9d6c8bf9c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATSUU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATSUU>>(v1);
    }

    // decompiled from Move bytecode v6
}

