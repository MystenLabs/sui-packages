module 0x578ad544a88545a89c45fde7ae45cd497fd4797f3adca55858abe421d0ae55a::b_fud {
    struct B_FUD has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_FUD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_FUD>(arg0, 9, b"bFUD", b"bToken FUD", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_FUD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_FUD>>(v1);
    }

    // decompiled from Move bytecode v6
}

