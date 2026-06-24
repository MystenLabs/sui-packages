module 0xc519f256338b123e04b19020dae90d04a6967a000049f9b79fba02b0a543a2d3::b_test2 {
    struct B_TEST2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_TEST2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_TEST2>(arg0, 9, b"bTEST2", b"bToken TEST2", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_TEST2>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_TEST2>>(v1);
    }

    // decompiled from Move bytecode v6
}

