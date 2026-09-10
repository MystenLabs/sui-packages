module 0xe90d4691aae921f2549b1047e7a199f592808e2b7e42e9dc001357e4b7dc0d2a::facebuk {
    struct FACEBUK has drop {
        dummy_field: bool,
    }

    fun init(arg0: FACEBUK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FACEBUK>(arg0, 6, b"FACEBUK", b"facebuk", b"facebuk", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suipad.online/api/images/0624886a312014f9f5286b71806e01d09af87d9234569486bc31ae120f5f96ac.png")), arg1);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FACEBUK>>(v0, v2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FACEBUK>>(v1, v2);
    }

    // decompiled from Move bytecode v7
}

