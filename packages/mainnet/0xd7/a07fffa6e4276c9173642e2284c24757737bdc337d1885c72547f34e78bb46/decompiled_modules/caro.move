module 0xd7a07fffa6e4276c9173642e2284c24757737bdc337d1885c72547f34e78bb46::caro {
    struct CARO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CARO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CARO>(arg0, 6, b"CARO", b"CapyRock", b"Rock rock I make stock. Small start to the moon baby Capybara", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/67d353d66c9ee71a193696006388787d_92c43f8077.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CARO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CARO>>(v1);
    }

    // decompiled from Move bytecode v6
}

