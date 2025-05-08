module 0x275f9288008497e5b8ec619e0291ed4518c03b961dd2ef3fea6e8f2a73151f6e::b_ok {
    struct B_OK has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_OK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_OK>(arg0, 9, b"bOK", b"bToken OK", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_OK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_OK>>(v1);
    }

    // decompiled from Move bytecode v6
}

