module 0x9bd745d692dde1bea82844d8bdbf59956cafc525750488983facf82374a04edf::b_usdb {
    struct B_USDB has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_USDB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_USDB>(arg0, 9, b"bUSDB", b"bToken USDB", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_USDB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_USDB>>(v1);
    }

    // decompiled from Move bytecode v6
}

