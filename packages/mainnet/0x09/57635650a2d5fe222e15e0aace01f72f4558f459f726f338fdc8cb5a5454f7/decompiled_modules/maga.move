module 0x957635650a2d5fe222e15e0aace01f72f4558f459f726f338fdc8cb5a5454f7::maga {
    struct MAGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAGA>(arg0, 6, b"MAGA", b"MY HERO MAGADEMIA", b"MY HERO MAGADEMIA is here to MAKE COINS GREAT AGAIN.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Pastel_Aesthetic_Minimalist_Guide_Carousel_Instagram_Post_512_x_512_px_7_0ca19e59cc.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

