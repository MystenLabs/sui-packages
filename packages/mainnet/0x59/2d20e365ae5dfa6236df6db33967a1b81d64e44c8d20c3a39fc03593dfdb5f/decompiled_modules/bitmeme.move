module 0x592d20e365ae5dfa6236df6db33967a1b81d64e44c8d20c3a39fc03593dfdb5f::bitmeme {
    struct BITMEME has drop {
        dummy_field: bool,
    }

    fun init(arg0: BITMEME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BITMEME>(arg0, 6, b"BITMEME", b"believe in the memes", x"62656c6965766520696e20746865206d656d65730a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Zm_Fd_OYW_4_A_Ul_Sx_X_5dd00433ab.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BITMEME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BITMEME>>(v1);
    }

    // decompiled from Move bytecode v6
}

