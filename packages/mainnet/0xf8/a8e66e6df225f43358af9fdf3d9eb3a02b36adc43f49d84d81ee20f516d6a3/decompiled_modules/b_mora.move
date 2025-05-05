module 0xf8a8e66e6df225f43358af9fdf3d9eb3a02b36adc43f49d84d81ee20f516d6a3::b_mora {
    struct B_MORA has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_MORA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_MORA>(arg0, 9, b"bMORA", b"bToken MORA", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_MORA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_MORA>>(v1);
    }

    // decompiled from Move bytecode v6
}

