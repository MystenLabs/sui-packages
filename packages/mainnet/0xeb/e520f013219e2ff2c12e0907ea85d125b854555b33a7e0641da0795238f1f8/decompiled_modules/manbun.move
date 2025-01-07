module 0xebe520f013219e2ff2c12e0907ea85d125b854555b33a7e0641da0795238f1f8::manbun {
    struct MANBUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MANBUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MANBUN>(arg0, 6, b"MANBUN", b"Sam's Man Bun", x"696e2064656469636174696f6e20746f207468652062657374206d616e2d62756e206f6e205355490a74686520626573742068616972637574206f6e207468652066616365206f662074686520706c616e6574", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/manbun_3002f3947d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MANBUN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MANBUN>>(v1);
    }

    // decompiled from Move bytecode v6
}

