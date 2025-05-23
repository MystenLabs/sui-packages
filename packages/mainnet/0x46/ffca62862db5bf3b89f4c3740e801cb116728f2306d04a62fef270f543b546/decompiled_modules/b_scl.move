module 0x46ffca62862db5bf3b89f4c3740e801cb116728f2306d04a62fef270f543b546::b_scl {
    struct B_SCL has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_SCL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_SCL>(arg0, 9, b"bSCL", b"bToken SCL", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_SCL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_SCL>>(v1);
    }

    // decompiled from Move bytecode v6
}

