module 0xfc6a680e9a594f5640e40bd1595961622fadd7c6dbbdb9da2483d7bbf2755e11::hunk {
    struct HUNK has drop {
        dummy_field: bool,
    }

    fun init(arg0: HUNK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HUNK>(arg0, 6, b"HUNK", b"Sui Hunk", b"Hi i'm a $HUNK and i'm a first goose on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241009_132315_13fa4e36b6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HUNK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HUNK>>(v1);
    }

    // decompiled from Move bytecode v6
}

