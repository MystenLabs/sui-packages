module 0x4e3ce459821429c2a7845148e60d37cab26a237634931bea0f1854eb7670f2eb::extra_metadata {
    struct EXTRA_METADATA has drop {
        dummy_field: bool,
    }

    fun init(arg0: EXTRA_METADATA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EXTRA_METADATA>(arg0, 9, b"EMD", b"extra metadata", b"coin with extra metadata", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa-dev.sgp1.cdn.digitaloceanspaces.com/kappa-dev/coins/7c603f80-5120-4964-97d8-c28434382c04.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EXTRA_METADATA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EXTRA_METADATA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

