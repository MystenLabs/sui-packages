module 0xb480c8413cb9af3d1612c35b62e7ab66b52a3f56e8ce2b6e079e3ba46866c5d4::b_ika {
    struct B_IKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_IKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_IKA>(arg0, 9, b"bIKA", b"bToken IKA", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_IKA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_IKA>>(v1);
    }

    // decompiled from Move bytecode v6
}

