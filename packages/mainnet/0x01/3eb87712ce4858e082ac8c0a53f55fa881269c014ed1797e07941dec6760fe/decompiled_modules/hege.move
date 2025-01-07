module 0x13eb87712ce4858e082ac8c0a53f55fa881269c014ed1797e07941dec6760fe::hege {
    struct HEGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HEGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HEGE>(arg0, 6, b"HEGE", b"Hege Coin", b"A meme with a dream... ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/hege_313729300c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HEGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HEGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

