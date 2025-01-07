module 0xe3c7e02de6c2240fbf2cef636c40cc2d08f6aaabab1f6a31f9a45868bf2e641d::suiprize {
    struct SUIPRIZE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPRIZE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPRIZE>(arg0, 6, b"SUIPRIZE", b"SURPRIZE", b"Here is a SUIPRIZE for you", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5988_854e877fb5.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPRIZE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPRIZE>>(v1);
    }

    // decompiled from Move bytecode v6
}

