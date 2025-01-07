module 0x87913b57250d957cc8f418fcaaacf121e75e087a96a1f9da17388e0fd692c4e5::kui {
    struct KUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KUI>(arg0, 6, b"KUI", b"SHARKUI_SUI", x"4b5549206973206e6f74206a75737420612063727970746f63757272656e63792c2069742773206e6f74206a7573742061206d656d653b20697427732061205245564f4c5554494f4e210a4865726520776520676f21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Whats_App_Image_2024_12_13_at_16_29_09_removebg_preview_be536e0861.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

