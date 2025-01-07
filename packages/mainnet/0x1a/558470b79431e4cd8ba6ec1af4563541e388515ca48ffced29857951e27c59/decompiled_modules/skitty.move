module 0x1a558470b79431e4cd8ba6ec1af4563541e388515ca48ffced29857951e27c59::skitty {
    struct SKITTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKITTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKITTY>(arg0, 6, b"Skitty", b"Suikitty", b"The hello kitty of the Sui network! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_9406_0cd9f20be4.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKITTY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SKITTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

