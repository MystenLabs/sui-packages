module 0x5794ca0e9ef0d1e020bdbba0bff97d95ef6e6b62c9907a0cc5645d2dde95ce4a::b_n0d0 {
    struct B_N0D0 has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_N0D0, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_N0D0>(arg0, 9, b"bN0D0", b"bToken N0D0", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_N0D0>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_N0D0>>(v1);
    }

    // decompiled from Move bytecode v6
}

