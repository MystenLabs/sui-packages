module 0xe6d1857d063be553ba1b5d5e7a0a60373b960d8aafa5875b62ff08bb485ed9e7::lopy {
    struct LOPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOPY>(arg0, 6, b"LOPY", b"Loopycto", b"The one and only community for Loopy Coin on the Sui chain. Breaking the caba", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6437_72a040e55f.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LOPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

