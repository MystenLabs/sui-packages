module 0x44e9e5102c62eacdbcdfbebcf7402d39eaf32557ef53a31080213f51893e6880::b_wood {
    struct B_WOOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_WOOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_WOOD>(arg0, 9, b"bWOOD", b"bToken WOOD", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_WOOD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_WOOD>>(v1);
    }

    // decompiled from Move bytecode v6
}

