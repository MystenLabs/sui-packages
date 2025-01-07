module 0x88fdd87b60b2333466dc70446b7785c07c7d0addc673449b957790e90fb083f::hello {
    struct HELLO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HELLO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HELLO>(arg0, 6, b"HELLO", b"HELLO COIN", b"TICKER: HELLO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/aa8936c2d825aadffd7aededa661f9a4_1685366026_edacff8129.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HELLO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HELLO>>(v1);
    }

    // decompiled from Move bytecode v6
}

