module 0x21ef3f42f70f358f355f66c9b4168dbba93a9c67c863be744b4f059af1ac357a::willy {
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

