module 0x60c314e8d581aae7b65cad125b3129e19af81e8d2f20dec87d1ac83269a425fb::b_mola {
    struct B_MOLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_MOLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_MOLA>(arg0, 9, b"bMOLA", b"bToken MOLA", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_MOLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_MOLA>>(v1);
    }

    // decompiled from Move bytecode v6
}

