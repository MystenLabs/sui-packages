module 0xc03adcebfce03bc7296f61308565a8c938c34551699886f6b906679081c34ba9::b_sdf {
    struct B_SDF has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_SDF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_SDF>(arg0, 9, b"bSDF", b"bToken SDF", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_SDF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_SDF>>(v1);
    }

    // decompiled from Move bytecode v6
}

