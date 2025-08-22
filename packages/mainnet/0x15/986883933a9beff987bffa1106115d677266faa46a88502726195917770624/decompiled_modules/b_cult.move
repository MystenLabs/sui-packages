module 0x15986883933a9beff987bffa1106115d677266faa46a88502726195917770624::b_cult {
    struct B_CULT has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_CULT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_CULT>(arg0, 9, b"bCULT", b"bToken CULT", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_CULT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_CULT>>(v1);
    }

    // decompiled from Move bytecode v6
}

