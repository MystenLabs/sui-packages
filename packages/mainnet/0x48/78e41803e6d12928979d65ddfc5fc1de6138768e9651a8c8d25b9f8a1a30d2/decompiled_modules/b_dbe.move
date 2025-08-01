module 0x4878e41803e6d12928979d65ddfc5fc1de6138768e9651a8c8d25b9f8a1a30d2::b_dbe {
    struct B_DBE has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_DBE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_DBE>(arg0, 9, b"bDBE", b"bToken DBE", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_DBE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_DBE>>(v1);
    }

    // decompiled from Move bytecode v6
}

