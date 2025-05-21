module 0x42ed593abfe3fe3cb04b7f612331f39453f5dd5fa19faebfc350b6c14b1c98d2::b_over {
    struct B_OVER has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_OVER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_OVER>(arg0, 9, b"bOVER", b"bToken OVER", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_OVER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_OVER>>(v1);
    }

    // decompiled from Move bytecode v6
}

