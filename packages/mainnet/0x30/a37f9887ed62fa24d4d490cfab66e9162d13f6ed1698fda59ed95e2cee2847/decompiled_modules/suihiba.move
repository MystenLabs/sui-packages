module 0x30a37f9887ed62fa24d4d490cfab66e9162d13f6ed1698fda59ed95e2cee2847::suihiba {
    struct SUIHIBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIHIBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIHIBA>(arg0, 6, b"SUIHIBA", b"SUIHIBA WIF HAT", b"Beautiful meme token on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_26_16_47_38_b44b006c5c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIHIBA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIHIBA>>(v1);
    }

    // decompiled from Move bytecode v6
}

