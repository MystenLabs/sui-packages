module 0xfc66677787cb4aea6d3119b1dec5ed7eef80a5bf3cb566c4e32c1d6cb8f8de03::b__suits {
    struct B__SUITS has drop {
        dummy_field: bool,
    }

    fun init(arg0: B__SUITS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B__SUITS>(arg0, 9, b"b$SUITS", b"bToken $SUITS", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B__SUITS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B__SUITS>>(v1);
    }

    // decompiled from Move bytecode v6
}

