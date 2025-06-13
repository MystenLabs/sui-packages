module 0x6ccdbe32e437d2ca0415f12ef74c91b4163a336c147185f398c4e4d2a0e06521::b_tard {
    struct B_TARD has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_TARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_TARD>(arg0, 9, b"bTARD", b"bToken TARD", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_TARD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_TARD>>(v1);
    }

    // decompiled from Move bytecode v6
}

