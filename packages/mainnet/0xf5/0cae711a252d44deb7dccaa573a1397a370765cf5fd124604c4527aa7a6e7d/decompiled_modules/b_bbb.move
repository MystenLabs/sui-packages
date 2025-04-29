module 0xf50cae711a252d44deb7dccaa573a1397a370765cf5fd124604c4527aa7a6e7d::b_bbb {
    struct B_BBB has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_BBB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_BBB>(arg0, 9, b"bBBB", b"bToken BBB", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_BBB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_BBB>>(v1);
    }

    // decompiled from Move bytecode v6
}

