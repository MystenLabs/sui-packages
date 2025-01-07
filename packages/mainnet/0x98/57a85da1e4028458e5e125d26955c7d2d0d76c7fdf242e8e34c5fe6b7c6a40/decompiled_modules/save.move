module 0x9857a85da1e4028458e5e125d26955c7d2d0d76c7fdf242e8e34c5fe6b7c6a40::save {
    struct SAVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAVE>(arg0, 6, b"SAVE", b"SAVE SUI", b"Welcome to new degens who've found me", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_11_10_24_18_0199126188.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAVE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAVE>>(v1);
    }

    // decompiled from Move bytecode v6
}

