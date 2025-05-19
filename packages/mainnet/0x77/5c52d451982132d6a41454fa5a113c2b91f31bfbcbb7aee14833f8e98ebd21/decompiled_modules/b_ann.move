module 0x775c52d451982132d6a41454fa5a113c2b91f31bfbcbb7aee14833f8e98ebd21::b_ann {
    struct B_ANN has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_ANN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_ANN>(arg0, 9, b"bANN", b"bToken ANN", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_ANN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_ANN>>(v1);
    }

    // decompiled from Move bytecode v6
}

