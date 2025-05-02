module 0xa2dad8ec2ffa51c0f7a069ae1d9ecdcb07aea0caf0438ec3425c151411040879::b_test_wal {
    struct B_TEST_WAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_TEST_WAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_TEST_WAL>(arg0, 9, b"btWAL", b"bToken tWAL", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_TEST_WAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_TEST_WAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

