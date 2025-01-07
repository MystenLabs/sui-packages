module 0x124b932246a5be957813a23ae9d9e832efa916c60b18d4b8b5487940bb3e4cb::cd {
    struct CD has drop {
        dummy_field: bool,
    }

    fun init(arg0: CD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CD>(arg0, 6, b"CD", b"Chinese dragon", b"The Chinese dragon has magical powers", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pngtree_chinese_dragon_green_traditional_illustration_png_image_7507957_f838c96f50.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CD>>(v1);
    }

    // decompiled from Move bytecode v6
}

