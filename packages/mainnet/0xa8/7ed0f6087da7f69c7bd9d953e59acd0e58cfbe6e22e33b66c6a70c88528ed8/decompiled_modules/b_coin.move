module 0xa87ed0f6087da7f69c7bd9d953e59acd0e58cfbe6e22e33b66c6a70c88528ed8::b_coin {
    struct B_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_COIN>(arg0, 9, b"bwUSDC", b"bToken wUSDC", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_COIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_COIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

