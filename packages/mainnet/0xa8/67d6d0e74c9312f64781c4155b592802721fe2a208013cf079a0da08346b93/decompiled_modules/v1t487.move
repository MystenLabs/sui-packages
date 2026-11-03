module 0xa867d6d0e74c9312f64781c4155b592802721fe2a208013cf079a0da08346b93::v1t487 {
    struct V1T487 has drop {
        dummy_field: bool,
    }

    fun init(arg0: V1T487, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<V1T487>(arg0, 9, b"V1T487", b"V1T487", b"V1T487 LP coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aftermath.finance/coins/perpetuals/default.svg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<V1T487>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<V1T487>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

