module 0xeff2cc6699de3d57248f487cd24d6e72f6a987c13847846c4b05cd82aba52bd8::wht {
    struct WHT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WHT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WHT>(arg0, 6, b"WHT", b"White House Trump", b"A return to the White House?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_15_17_45_39_b1e7543aa7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WHT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WHT>>(v1);
    }

    // decompiled from Move bytecode v6
}

