module 0xd7d3ddefffdc4dff0c0d8959cf3463fe9997ec4fe030d71f2324eba97fbe3d94::aaal {
    struct AAAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAAL>(arg0, 6, b"AAAL", b"aaa loopy", b"AAAAAAAAAA Can't stop, won't stop (cheering for Sui).", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_6354c9ec6c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

