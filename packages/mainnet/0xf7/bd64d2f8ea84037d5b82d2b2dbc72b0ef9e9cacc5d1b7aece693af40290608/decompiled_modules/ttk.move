module 0xf7bd64d2f8ea84037d5b82d2b2dbc72b0ef9e9cacc5d1b7aece693af40290608::ttk {
    struct TTK has drop {
        dummy_field: bool,
    }

    fun init(arg0: TTK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TTK>(arg0, 6, b"TTK", b"Tok and tak", b"Meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731048919619.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TTK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TTK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

