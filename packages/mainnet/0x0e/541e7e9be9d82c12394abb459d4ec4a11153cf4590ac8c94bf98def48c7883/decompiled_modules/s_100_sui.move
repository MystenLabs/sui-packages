module 0xe541e7e9be9d82c12394abb459d4ec4a11153cf4590ac8c94bf98def48c7883::s_100_sui {
    struct S_100_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: S_100_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<S_100_SUI>(arg0, 9, b"s100SUI", b"sui100 Staked SUI", b"test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.tusky.io/files/ab02870b-e5ab-4646-b1e6-49e0a37eb9f9/data")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<S_100_SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<S_100_SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

