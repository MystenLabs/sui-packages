module 0xdbd5f10067837625fd94086c913da678ea129288f657a850a933a5d1ce0c0668::b_ok {
    struct B_OK has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_OK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_OK>(arg0, 9, b"bOK", b"bToken OK", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_OK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_OK>>(v1);
    }

    // decompiled from Move bytecode v6
}

