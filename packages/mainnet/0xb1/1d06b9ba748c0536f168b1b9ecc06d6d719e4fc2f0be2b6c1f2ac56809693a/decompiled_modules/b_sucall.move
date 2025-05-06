module 0xb11d06b9ba748c0536f168b1b9ecc06d6d719e4fc2f0be2b6c1f2ac56809693a::b_sucall {
    struct B_SUCALL has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_SUCALL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_SUCALL>(arg0, 9, b"bSUCALL", b"bToken SUCALL", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_SUCALL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_SUCALL>>(v1);
    }

    // decompiled from Move bytecode v6
}

