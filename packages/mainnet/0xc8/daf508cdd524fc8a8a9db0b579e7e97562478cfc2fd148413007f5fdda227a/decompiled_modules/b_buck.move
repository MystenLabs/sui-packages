module 0xc8daf508cdd524fc8a8a9db0b579e7e97562478cfc2fd148413007f5fdda227a::b_buck {
    struct B_BUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_BUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_BUCK>(arg0, 9, b"bBUCK", b"bToken BUCK", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_BUCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_BUCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

