module 0x1defdcd8017cbb9fdc2d68dc6c45d161a47ecd78d7bade867b2cf15b23278917::hog {
    struct HOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOG>(arg0, 6, b"HOG", b"Hippo Dog", b"Dog? Hippo? Who cares when its a sendooor", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_eslahi_copy_8a6d1d2fee.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

