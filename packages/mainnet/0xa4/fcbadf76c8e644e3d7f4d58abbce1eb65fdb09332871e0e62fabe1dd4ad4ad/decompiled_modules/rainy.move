module 0xa4fcbadf76c8e644e3d7f4d58abbce1eb65fdb09332871e0e62fabe1dd4ad4ad::rainy {
    struct RAINY has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAINY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RAINY>(arg0, 6, b"RAINY", b"RAIN", b"RAIN ON ME", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/water_a00cea56b5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAINY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RAINY>>(v1);
    }

    // decompiled from Move bytecode v6
}

