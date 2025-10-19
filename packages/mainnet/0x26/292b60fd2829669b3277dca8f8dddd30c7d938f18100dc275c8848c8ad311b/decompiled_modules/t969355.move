module 0x26292b60fd2829669b3277dca8f8dddd30c7d938f18100dc275c8848c8ad311b::t969355 {
    struct T969355 has drop {
        dummy_field: bool,
    }

    fun init(arg0: T969355, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<T969355>(arg0, 9, b"T969355", b"Test 969355", b"Integration test token 2025-10-19T23:19:29.355Z", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T969355>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T969355>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

