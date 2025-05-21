module 0x9c241ed0eb09dc5173e6a1211e2836401a5937ef847073c17f115360c5c3d49f::b_attn {
    struct B_ATTN has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_ATTN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_ATTN>(arg0, 9, b"bATTN", b"bToken ATTN", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_ATTN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_ATTN>>(v1);
    }

    // decompiled from Move bytecode v6
}

