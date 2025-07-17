module 0x602a6b3c8d5898260c55a0747ff25298f286d6e527d3051401e49b4b7fc0fb68::b_t {
    struct B_T has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_T, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_T>(arg0, 9, b"bT", b"bToken T", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_T>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_T>>(v1);
    }

    // decompiled from Move bytecode v6
}

