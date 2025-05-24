module 0x3b546096244c7f546a46c2f9bcf9b914f1473e02a28ac9927493646a456267f0::b_dickdog {
    struct B_DICKDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_DICKDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_DICKDOG>(arg0, 9, b"bDICKDOG", b"bToken DICKDOG", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_DICKDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_DICKDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

