module 0x64e4273f981deb55cc0430321dcd8267c50fba0f62bc5737b7c9268e01d84d17::test {
    struct TEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v0, 0x2::url::new_unsafe_from_bytes(b""));
        let (v1, v2) = 0x2::coin::create_currency<TEST>(arg0, 6, b"TT", b"Test", b"", v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TEST>>(v2);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<TEST>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TEST>>(arg0);
    }

    // decompiled from Move bytecode v6
}

