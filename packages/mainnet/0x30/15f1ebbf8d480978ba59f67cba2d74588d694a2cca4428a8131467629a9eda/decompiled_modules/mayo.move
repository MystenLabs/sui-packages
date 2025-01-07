module 0x3015f1ebbf8d480978ba59f67cba2d74588d694a2cca4428a8131467629a9eda::mayo {
    struct MAYO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAYO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAYO>(arg0, 6, b"MAYO", b"Mayo the Frenchie", b"IRL frenchie. How high can you send it?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_8775_5b29e65dfe.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAYO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAYO>>(v1);
    }

    // decompiled from Move bytecode v6
}

