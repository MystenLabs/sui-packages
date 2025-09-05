module 0x29afcc65f544ad6751718fa1196735da7618955b7f5185558dbaa0109485d17d::test {
    struct TEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST>(arg0, 9, b"TEST", b"Test Coin", b"This is a test coin.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.interestlabs.io/files/61e311815059ee4c70fbd7d72da6ff7cd7409594330e0b43.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TEST>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEST>>(v1);
    }

    // decompiled from Move bytecode v6
}

