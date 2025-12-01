module 0x6b1fb7fb64adb6082245b885de2322c90f5e9c77ddd333a6ca127eb454edd30b::b_trtl {
    struct B_TRTL has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_TRTL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_TRTL>(arg0, 9, b"bTRTL", b"bToken TRTL", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_TRTL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_TRTL>>(v1);
    }

    // decompiled from Move bytecode v6
}

