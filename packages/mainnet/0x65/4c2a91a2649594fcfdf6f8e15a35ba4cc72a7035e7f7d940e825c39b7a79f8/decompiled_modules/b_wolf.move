module 0x654c2a91a2649594fcfdf6f8e15a35ba4cc72a7035e7f7d940e825c39b7a79f8::b_wolf {
    struct B_WOLF has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_WOLF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_WOLF>(arg0, 9, b"bWOLF", b"bToken WOLF", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_WOLF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_WOLF>>(v1);
    }

    // decompiled from Move bytecode v6
}

