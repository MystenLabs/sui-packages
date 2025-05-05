module 0xc5f4173ce754002af63b1c4622487b48ae5eddabf5781d44105aae447a100b75::b_cnn {
    struct B_CNN has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_CNN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_CNN>(arg0, 9, b"bCNN", b"bToken CNN", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_CNN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_CNN>>(v1);
    }

    // decompiled from Move bytecode v6
}

