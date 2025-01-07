module 0x374da8c29568276d0cf95ca9616836217321e00e712ad4e39a8242f149b83235::cm {
    struct CM has drop {
        dummy_field: bool,
    }

    fun init(arg0: CM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CM>(arg0, 6, b"CM", b"Carlo Maximus", b"Carlo is bringing a whole new level of entertainment with high quality 2D and 3D content to meme projects on Sui Chain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2025_01_02_at_2_01_29a_pm_b2befc0195.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CM>>(v1);
    }

    // decompiled from Move bytecode v6
}

