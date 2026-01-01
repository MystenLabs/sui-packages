module 0x807b6a86eb2147a2b53de0e70e9926d0d0aa8c0a96c1b620291157aa54b3042b::infinity {
    struct INFINITY has drop {
        dummy_field: bool,
    }

    fun init(arg0: INFINITY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<INFINITY>(arg0, 6, b"INFINITY", b"infinity money", b" ", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<INFINITY>(&mut v2, 10000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<INFINITY>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<INFINITY>>(v2);
    }

    // decompiled from Move bytecode v6
}

