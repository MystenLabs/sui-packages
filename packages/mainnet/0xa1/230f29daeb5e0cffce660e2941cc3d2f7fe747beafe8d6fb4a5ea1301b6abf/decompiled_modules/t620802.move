module 0xa1230f29daeb5e0cffce660e2941cc3d2f7fe747beafe8d6fb4a5ea1301b6abf::t620802 {
    struct T620802 has drop {
        dummy_field: bool,
    }

    fun init(arg0: T620802, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<T620802>(arg0, 9, b"T620802", b"Test 620802", b"Integration test token 2025-10-24T02:23:40.802Z", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T620802>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T620802>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

