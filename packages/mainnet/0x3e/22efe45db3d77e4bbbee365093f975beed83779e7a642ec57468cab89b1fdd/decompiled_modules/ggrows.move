module 0x3e22efe45db3d77e4bbbee365093f975beed83779e7a642ec57468cab89b1fdd::ggrows {
    struct GGROWS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GGROWS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GGROWS>(arg0, 6, b"GGROWS", b"SuiTreeGrow", b"The golden tree on SUI - $GGROWS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_14_11_02_18_b263ff709d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GGROWS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GGROWS>>(v1);
    }

    // decompiled from Move bytecode v6
}

