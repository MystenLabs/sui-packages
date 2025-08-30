module 0xa1b5a46ddbe5de0f387695680b2f02e16659e6b8fd4a4d50bd7b6108e3e2b8b7::b_trump {
    struct B_TRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_TRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_TRUMP>(arg0, 9, b"bTRUMP", b"bToken TRUMP", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_TRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_TRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

