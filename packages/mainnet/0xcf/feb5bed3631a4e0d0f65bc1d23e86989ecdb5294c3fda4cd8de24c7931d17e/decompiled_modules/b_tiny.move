module 0xcffeb5bed3631a4e0d0f65bc1d23e86989ecdb5294c3fda4cd8de24c7931d17e::b_tiny {
    struct B_TINY has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_TINY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_TINY>(arg0, 9, b"bTINY", b"bToken TINY", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_TINY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_TINY>>(v1);
    }

    // decompiled from Move bytecode v6
}

