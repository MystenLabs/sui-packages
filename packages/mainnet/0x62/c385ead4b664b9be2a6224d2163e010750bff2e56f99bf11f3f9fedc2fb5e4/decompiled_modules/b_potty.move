module 0x62c385ead4b664b9be2a6224d2163e010750bff2e56f99bf11f3f9fedc2fb5e4::b_potty {
    struct B_POTTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_POTTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_POTTY>(arg0, 9, b"bPOTTY", b"bToken POTTY", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_POTTY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_POTTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

