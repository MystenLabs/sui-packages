module 0xd9ac0ac8f36968563138f24ba8499c827fad5a8a51810cd89613bf42a5f9c1cd::key {
    struct KEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: KEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KEY>(arg0, 6, b"KEY", b"Keyston", b"i.m a KEY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1738501783640.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KEY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KEY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

