module 0xed0986ba91072e8abe1e68e3344a7654e6a33b2f6a9a1300b6c41fcf88444943::black {
    struct BLACK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLACK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLACK>(arg0, 6, b"BLACK", b"BLACK COCK", b"BBC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730950966616.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLACK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLACK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

