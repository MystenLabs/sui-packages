module 0xfa3b4e56e0b230ef07ecc3995ced6e6a10d7b9b2cfba52abed21c88768ba2a19::b_musy {
    struct B_MUSY has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_MUSY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_MUSY>(arg0, 9, b"bMUSY", b"bToken MUSY", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_MUSY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_MUSY>>(v1);
    }

    // decompiled from Move bytecode v6
}

