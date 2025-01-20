module 0x2b8caf542ae14e5bb11a84eae69c5eb60ee8ce2852f3ba9c33897c9f91cf2a67::golden {
    struct GOLDEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOLDEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOLDEN>(arg0, 6, b"GOLDEN", b"The Golden Age Of America", x"54686520476f6c64656e20416765204f6620416d65726963610a0a24474f4c44454e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250121_030010_014_5ec4007fd3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOLDEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOLDEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

