module 0x4b663a697fa0dd3e166510bb6509e0af796dd4b1bebd1f494dfa203342031f4d::bells {
    struct BELLS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BELLS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BELLS>(arg0, 6, b"BELLS", b"BELLS SUI", x"497473206f6674656e2073616964206279206e6f726d696573207468617420746865206669727374206d656d65636f696e2077617320446f6765636f696e2c206372656174656420696e20446563656d62657220323031332e20427574207468617473206e6f74207468652077686f6c652074727574682e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0xba2a3dad197d6fee75471215efd5c30c8c854e11_8a8338394d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BELLS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BELLS>>(v1);
    }

    // decompiled from Move bytecode v6
}

