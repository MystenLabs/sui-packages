module 0xd816484fa628f80f3662acc4d59a451bcb7c1cf86f29a32afae640fb9d33a8a::speng {
    struct SPENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPENG>(arg0, 6, b"SPENG", b"Suipeng", b"Meet $SPENG, A penguin on Sui network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_3d9208d252.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

