module 0xe9680dd2427834f18adef151265e8e1c52f016f950cd5597754c23a0f6ce6e2c::rml {
    struct RML has drop {
        dummy_field: bool,
    }

    fun init(arg0: RML, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RML>(arg0, 6, b"Rml", b"Rookie", b"Rookie (ROOK) is a next-generation Sui-based token designed to empower newcomers in the world of blockchain and cryptocurrency. With its simple yet powerful utility, Rookie is the perfect starting point for those looking to enter the Sui ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736557071198.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RML>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RML>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

