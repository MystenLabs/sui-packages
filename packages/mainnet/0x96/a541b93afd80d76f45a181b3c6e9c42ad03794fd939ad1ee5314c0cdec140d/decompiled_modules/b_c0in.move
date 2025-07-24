module 0x96a541b93afd80d76f45a181b3c6e9c42ad03794fd939ad1ee5314c0cdec140d::b_c0in {
    struct B_C0IN has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_C0IN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_C0IN>(arg0, 9, b"bC0IN", b"bToken C0IN", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_C0IN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_C0IN>>(v1);
    }

    // decompiled from Move bytecode v6
}

