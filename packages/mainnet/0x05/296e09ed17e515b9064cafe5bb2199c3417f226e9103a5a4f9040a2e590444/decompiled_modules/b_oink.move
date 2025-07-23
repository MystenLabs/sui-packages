module 0x5296e09ed17e515b9064cafe5bb2199c3417f226e9103a5a4f9040a2e590444::b_oink {
    struct B_OINK has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_OINK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_OINK>(arg0, 9, b"bOINK", b"bToken OINK", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_OINK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_OINK>>(v1);
    }

    // decompiled from Move bytecode v6
}

