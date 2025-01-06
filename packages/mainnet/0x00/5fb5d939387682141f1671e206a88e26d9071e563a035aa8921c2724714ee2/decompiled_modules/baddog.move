module 0x5fb5d939387682141f1671e206a88e26d9071e563a035aa8921c2724714ee2::baddog {
    struct BADDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BADDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BADDOG>(arg0, 6, b"BADDOG", b"BAD DOGS", b"BADDOGS is a memecoin inspired by fierce attitude, unwavering loyalty, and unstoppable strength. With an engaged community and a rebellious spirit, this coin is designed to conquer the crypto markets with the same character of an alpha dog in militar", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736122186122.49")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BADDOG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BADDOG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

