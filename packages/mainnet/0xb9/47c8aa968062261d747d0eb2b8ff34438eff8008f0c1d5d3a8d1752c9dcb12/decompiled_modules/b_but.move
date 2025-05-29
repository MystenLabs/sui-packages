module 0xb947c8aa968062261d747d0eb2b8ff34438eff8008f0c1d5d3a8d1752c9dcb12::b_but {
    struct B_BUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_BUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_BUT>(arg0, 9, b"bBUT", b"bToken BUT", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_BUT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_BUT>>(v1);
    }

    // decompiled from Move bytecode v6
}

