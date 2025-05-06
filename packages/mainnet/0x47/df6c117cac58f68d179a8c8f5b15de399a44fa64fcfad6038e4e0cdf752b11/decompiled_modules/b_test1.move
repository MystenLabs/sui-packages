module 0x47df6c117cac58f68d179a8c8f5b15de399a44fa64fcfad6038e4e0cdf752b11::b_test1 {
    struct B_TEST1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_TEST1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_TEST1>(arg0, 9, b"bTEST1", b"bToken TEST1", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_TEST1>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_TEST1>>(v1);
    }

    // decompiled from Move bytecode v6
}

