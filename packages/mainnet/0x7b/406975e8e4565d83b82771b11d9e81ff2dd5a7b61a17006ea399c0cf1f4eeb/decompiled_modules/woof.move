module 0x7b406975e8e4565d83b82771b11d9e81ff2dd5a7b61a17006ea399c0cf1f4eeb::woof {
    struct WOOF has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOOF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOOF>(arg0, 6, b"WOOF", b"SUIWOOF", b"SUI's most popular blockchain dog, don't miss it !", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/f761bc_6b716a70c0134cd5ad8f289679ccaa67_mv2_d42ab8fc39.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOOF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WOOF>>(v1);
    }

    // decompiled from Move bytecode v6
}

