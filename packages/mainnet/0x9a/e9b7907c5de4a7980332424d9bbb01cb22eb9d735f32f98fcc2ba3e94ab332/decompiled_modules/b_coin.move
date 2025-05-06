module 0x9ae9b7907c5de4a7980332424d9bbb01cb22eb9d735f32f98fcc2ba3e94ab332::b_coin {
    struct B_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_COIN>(arg0, 9, b"bSOL", b"bToken SOL", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_COIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_COIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

