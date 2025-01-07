module 0x64f5741fb4b7d2f895dc2f9483813ceeb139639a3a84d412c41a293634cf011e::alove {
    struct ALOVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALOVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALOVE>(arg0, 6, b"ALOVE", b"ALPACA LOVE", b"Alpaca love", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/love_a17e0a09d3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALOVE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ALOVE>>(v1);
    }

    // decompiled from Move bytecode v6
}

