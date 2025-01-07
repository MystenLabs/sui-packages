module 0x672014ac695c2ec09c54cd5be863400205145c4d26904a2c5ecf870f25433fa0::uniwolfy {
    struct UNIWOLFY has drop {
        dummy_field: bool,
    }

    fun init(arg0: UNIWOLFY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UNIWOLFY>(arg0, 6, b"UNIWOLFY", b"Wolfy", b"the only real wolfy dratar", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Whats_App_Image_2024_12_11_at_21_51_25_849fde138f.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UNIWOLFY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UNIWOLFY>>(v1);
    }

    // decompiled from Move bytecode v6
}

