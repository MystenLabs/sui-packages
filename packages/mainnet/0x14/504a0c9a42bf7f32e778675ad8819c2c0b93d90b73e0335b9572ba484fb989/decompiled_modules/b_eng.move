module 0x14504a0c9a42bf7f32e778675ad8819c2c0b93d90b73e0335b9572ba484fb989::b_eng {
    struct B_ENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_ENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_ENG>(arg0, 9, b"bENG", b"bToken ENG", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_ENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_ENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

