module 0xa54e6beff7d14b15513121117f31b00036c2621488467559e0c3b7e767013389::t230047 {
    struct T230047 has drop {
        dummy_field: bool,
    }

    fun init(arg0: T230047, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<T230047>(arg0, 9, b"T230047", b"Test 230047", b"Integration test token 2025-10-19T22:50:30.047Z", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T230047>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T230047>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

