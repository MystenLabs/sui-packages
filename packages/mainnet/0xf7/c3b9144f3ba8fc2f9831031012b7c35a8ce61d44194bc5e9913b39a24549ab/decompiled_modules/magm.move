module 0xf7c3b9144f3ba8fc2f9831031012b7c35a8ce61d44194bc5e9913b39a24549ab::magm {
    struct MAGM has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAGM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAGM>(arg0, 6, b"MAGM", b"MagaMusk", b"Ticker MAGM Making Memes Graet Again!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3745_8d496543cd.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAGM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAGM>>(v1);
    }

    // decompiled from Move bytecode v6
}

