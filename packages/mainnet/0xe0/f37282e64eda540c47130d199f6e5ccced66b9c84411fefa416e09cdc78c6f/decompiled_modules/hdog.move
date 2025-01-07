module 0xe0f37282e64eda540c47130d199f6e5ccced66b9c84411fefa416e09cdc78c6f::hdog {
    struct HDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: HDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HDOG>(arg0, 6, b"HDOG", b"HOPDOG", b"Sui's and Hop's best dog! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730950028249.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HDOG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HDOG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

