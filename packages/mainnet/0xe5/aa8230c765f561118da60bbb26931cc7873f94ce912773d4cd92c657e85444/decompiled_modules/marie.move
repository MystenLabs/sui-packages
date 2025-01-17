module 0xe5aa8230c765f561118da60bbb26931cc7873f94ce912773d4cd92c657e85444::marie {
    struct MARIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MARIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MARIE>(arg0, 6, b"MARIE", b"Marie Rose", b"The mascot behind SPX6900", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250117_235619_800_f9fa7145b9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MARIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MARIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

