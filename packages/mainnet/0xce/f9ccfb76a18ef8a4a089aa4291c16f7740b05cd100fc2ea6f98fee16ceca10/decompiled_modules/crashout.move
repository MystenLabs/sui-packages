module 0xcef9ccfb76a18ef8a4a089aa4291c16f7740b05cd100fc2ea6f98fee16ceca10::crashout {
    struct CRASHOUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRASHOUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRASHOUT>(arg0, 6, b"CRASHOUT", b"CRASHOUTTT", b"IM GOING TO CRASHOUTTT!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7089_436ab0b754.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRASHOUT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CRASHOUT>>(v1);
    }

    // decompiled from Move bytecode v6
}

