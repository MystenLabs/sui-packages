module 0x29698705e009740a84d79f82d607ee08c4031aed135c1979f4bba5ef74fb4cf::frog {
    struct FROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FROG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FROG>(arg0, 6, b"FROG", b"HopFrog", b"First Frog on Hop Fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731177737249.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FROG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FROG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

