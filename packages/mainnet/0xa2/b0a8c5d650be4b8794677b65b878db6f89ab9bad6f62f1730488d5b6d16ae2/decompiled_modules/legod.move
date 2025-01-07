module 0xa2b0a8c5d650be4b8794677b65b878db6f89ab9bad6f62f1730488d5b6d16ae2::legod {
    struct LEGOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: LEGOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LEGOD>(arg0, 6, b"LEGOD", b"Lego God", b"Building faith, one block at a time. LEGOD is a divine twist on classic construction, blending timeless wisdom with timeless bricks. Join the journey to piece together miracles, mysteries, and maybe even a few heavenly laughs.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241209_155219_923_2c470799ea.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LEGOD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LEGOD>>(v1);
    }

    // decompiled from Move bytecode v6
}

