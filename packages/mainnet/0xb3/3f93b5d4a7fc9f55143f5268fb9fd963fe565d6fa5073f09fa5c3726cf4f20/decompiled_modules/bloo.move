module 0xb33f93b5d4a7fc9f55143f5268fb9fd963fe565d6fa5073f09fa5c3726cf4f20::bloo {
    struct BLOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLOO>(arg0, 6, b"Bloo", b"Suiper Bloo", x"48692c20426c6f6f2048657265212120546865206d6f73742064616e6765726f75732066697368206f6e20737569206e6574776f726b21210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bloo_85da471cba.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

