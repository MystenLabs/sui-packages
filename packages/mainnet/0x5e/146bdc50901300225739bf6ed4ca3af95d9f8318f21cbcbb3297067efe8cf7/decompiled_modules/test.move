module 0x5e146bdc50901300225739bf6ed4ca3af95d9f8318f21cbcbb3297067efe8cf7::test {
    struct TEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<TEST>(arg0, 6, b"TEST", b"test by SuiAI", b"noting", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_2028_28f33223d7.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TEST>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

