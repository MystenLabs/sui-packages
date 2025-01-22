module 0x57cd1ccba91a44f3c0f8b377babf23d49465e9dcd6553b95bbb7694fd77004f6::hypeai {
    struct HYPEAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HYPEAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HYPEAI>(arg0, 6, b"HYPEAI", b"Hype AI", b"HYPE AI Sui Project", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000028354_e5217b76ae.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HYPEAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HYPEAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

