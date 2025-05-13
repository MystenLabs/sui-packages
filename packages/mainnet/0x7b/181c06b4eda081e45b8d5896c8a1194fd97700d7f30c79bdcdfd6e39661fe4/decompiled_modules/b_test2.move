module 0x7b181c06b4eda081e45b8d5896c8a1194fd97700d7f30c79bdcdfd6e39661fe4::b_test2 {
    struct B_TEST2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_TEST2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_TEST2>(arg0, 9, b"bTEST2", b"bToken TEST2", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_TEST2>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_TEST2>>(v1);
    }

    // decompiled from Move bytecode v6
}

