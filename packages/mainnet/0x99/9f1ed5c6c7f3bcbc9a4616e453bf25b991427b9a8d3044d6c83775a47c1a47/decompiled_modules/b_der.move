module 0x999f1ed5c6c7f3bcbc9a4616e453bf25b991427b9a8d3044d6c83775a47c1a47::b_der {
    struct B_DER has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_DER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_DER>(arg0, 9, b"bDER", b"bToken DER", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_DER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_DER>>(v1);
    }

    // decompiled from Move bytecode v6
}

