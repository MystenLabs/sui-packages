module 0x36da83fb092188ebc05d48c8f1b0c1aa802117a00a1bfe1cf8c85778a5c65bfb::abc {
    struct ABC has drop {
        dummy_field: bool,
    }

    fun init(arg0: ABC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ABC>(arg0, 6, b"ABC", b"ABC", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ABC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ABC>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

