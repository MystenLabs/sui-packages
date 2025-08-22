module 0x835433aa0cdb603e307c2bef730a3ca17338e67e5cffe96172cfc5f81a454d62::b_suilders {
    struct B_SUILDERS has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_SUILDERS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_SUILDERS>(arg0, 9, b"bSUILDERS", b"bToken SUILDERS", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_SUILDERS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_SUILDERS>>(v1);
    }

    // decompiled from Move bytecode v6
}

