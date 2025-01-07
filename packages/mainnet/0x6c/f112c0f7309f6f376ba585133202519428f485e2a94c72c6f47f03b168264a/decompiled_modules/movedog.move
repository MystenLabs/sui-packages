module 0x6cf112c0f7309f6f376ba585133202519428f485e2a94c72c6f47f03b168264a::movedog {
    struct MOVEDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOVEDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOVEDOG>(arg0, 6, b"MOVEDOG", b"movedog_sui", x"4d4f564520444f47202d206d656d65636f696e206f6e200a40535549", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730953711230.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOVEDOG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOVEDOG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

