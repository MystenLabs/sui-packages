module 0x8f87c669e2162d59979cd571b8d79f7b856f09c146dfd4a3b5527e7bc26b9036::b_thai_sui {
    struct B_THAI_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_THAI_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_THAI_SUI>(arg0, 9, b"bthaiSUI", b"bToken thaiSUI", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_THAI_SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_THAI_SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

