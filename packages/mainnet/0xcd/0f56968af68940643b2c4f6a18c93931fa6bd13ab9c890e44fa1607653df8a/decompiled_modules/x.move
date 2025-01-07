module 0xcd0f56968af68940643b2c4f6a18c93931fa6bd13ab9c890e44fa1607653df8a::x {
    struct X has drop {
        dummy_field: bool,
    }

    fun init(arg0: X, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<X>(arg0, 6, b"X", b"Token X", b"Unique token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731599731963.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<X>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<X>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

