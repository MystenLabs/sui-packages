module 0xc2decf697a3e8edd985c8420d75699e1b2f06e104b56e4550b557096b7e8ef3a::b_not {
    struct B_NOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_NOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_NOT>(arg0, 9, b"bNOT", b"bToken NOT", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_NOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_NOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

