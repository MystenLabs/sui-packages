module 0x2463f7cf73dac0f5d38e4468b512caab00aefa2f5bb9c093b456f1d044bf12e5::willy {
    struct WILLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: WILLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WILLY>(arg0, 6, b"WILLY", b"willy", b"billy's past self", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/willy_b64c800b44.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WILLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WILLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

