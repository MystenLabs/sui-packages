module 0xd7942fa09ec03f46990cb48f12312720b8a1cbf0c6d7ea21dd19ac66ac92442e::b_us {
    struct B_US has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_US, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_US>(arg0, 9, b"bUS", b"bToken US", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_US>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_US>>(v1);
    }

    // decompiled from Move bytecode v6
}

