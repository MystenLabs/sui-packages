module 0xc510058731d0a9e78dd62244509bdbfd1504a6afb1db83fcca1a6dddd209badf::b_test {
    struct B_TEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_TEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_TEST>(arg0, 9, b"bTEST", b"bToken TEST", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_TEST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_TEST>>(v1);
    }

    // decompiled from Move bytecode v6
}

