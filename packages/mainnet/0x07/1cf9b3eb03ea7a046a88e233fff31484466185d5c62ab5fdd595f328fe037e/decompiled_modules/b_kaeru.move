module 0x71cf9b3eb03ea7a046a88e233fff31484466185d5c62ab5fdd595f328fe037e::b_kaeru {
    struct B_KAERU has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_KAERU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_KAERU>(arg0, 9, b"bKaeru", b"bToken Kaeru", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_KAERU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_KAERU>>(v1);
    }

    // decompiled from Move bytecode v6
}

