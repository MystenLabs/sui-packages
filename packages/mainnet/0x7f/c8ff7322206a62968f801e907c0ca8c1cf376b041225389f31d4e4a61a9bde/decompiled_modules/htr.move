module 0x7fc8ff7322206a62968f801e907c0ca8c1cf376b041225389f31d4e4a61a9bde::htr {
    struct HTR has drop {
        dummy_field: bool,
    }

    fun init(arg0: HTR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HTR>(arg0, 6, b"HTR", b"Hunter Sui", b"Hunter For Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/images_5f47b3ed9e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HTR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HTR>>(v1);
    }

    // decompiled from Move bytecode v6
}

