module 0x4f6bba5f37afc8d755129306aa3d3c1e033331e22b7a587645ec301ca138c03c::b_pop {
    struct B_POP has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_POP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_POP>(arg0, 9, b"bPOP", b"bToken POP", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_POP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_POP>>(v1);
    }

    // decompiled from Move bytecode v6
}

