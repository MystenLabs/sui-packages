module 0xb4782130a80ef7d13e92445a6db13d385a6bf51fe85bff5bee4fe17003fa8394::FIX {
    struct FIX has drop {
        dummy_field: bool,
    }

    fun init(arg0: FIX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FIX>(arg0, 6, b"Dubai Chocolate", b"FIX", b"The Original Dubai Chocolate", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"ICoN_URL_STRING_PLACEHOLDER")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FIX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FIX>>(v1);
    }

    // decompiled from Move bytecode v6
}

