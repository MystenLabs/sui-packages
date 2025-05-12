module 0xde0dd28af9cd508470e7a8bceaa8e84687d13b0314c70d2f03c7721c0930abcf::test {
    struct TEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST>(arg0, 6, b"TEST", b"dontbuyme", b"awdaw", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1747049570128.avif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEST>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

