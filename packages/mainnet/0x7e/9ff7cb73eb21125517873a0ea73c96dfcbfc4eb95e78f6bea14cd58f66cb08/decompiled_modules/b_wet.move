module 0x7e9ff7cb73eb21125517873a0ea73c96dfcbfc4eb95e78f6bea14cd58f66cb08::b_wet {
    struct B_WET has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_WET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_WET>(arg0, 9, b"bWET", b"bToken WET", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_WET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_WET>>(v1);
    }

    // decompiled from Move bytecode v6
}

