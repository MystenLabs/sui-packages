module 0x42f2c8947764434cb4351a20e62fd9515441e18d33bba10d4f88428686fa3f15::x {
    struct X has drop {
        dummy_field: bool,
    }

    fun init(arg0: X, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<X>(arg0, 6, b"X", b"xxx", b"hello", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pikaso_text_to_image_Candid_image_photography_natural_textures_highly_r_3_18c99ac872.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<X>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<X>>(v1);
    }

    // decompiled from Move bytecode v6
}

