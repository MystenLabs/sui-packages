module 0x81737734890384c4b0d5ffe913d851795048f274ee973892eaabc295916ea631::flippy {
    struct FLIPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLIPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLIPPY>(arg0, 6, b"FLIPPY", b"Flippy", b"Hey, I am Flippy the Dolphin and I am here to flip some tokens.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_25_13_41_34_51827fb955.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLIPPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLIPPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

