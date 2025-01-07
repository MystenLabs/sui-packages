module 0xd46f8f973a83a397419355e63fac6b4bf9c518301b60513fc92eb05312204221::toskov {
    struct TOSKOV has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOSKOV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOSKOV>(arg0, 6, b"Toskov", b"Toskovat", b"The AI agent Toskovat represents a cutting-edge exploration into how artificial intelligence can derive inspiration from the unsettling aspects of human fear.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_12_14_214519_0b8d789e87.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOSKOV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOSKOV>>(v1);
    }

    // decompiled from Move bytecode v6
}

