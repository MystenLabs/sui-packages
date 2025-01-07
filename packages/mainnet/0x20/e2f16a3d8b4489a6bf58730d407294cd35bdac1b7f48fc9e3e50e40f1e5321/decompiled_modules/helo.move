module 0x20e2f16a3d8b4489a6bf58730d407294cd35bdac1b7f48fc9e3e50e40f1e5321::helo {
    struct HELO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HELO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HELO>(arg0, 6, b"HELO", b"StaringFish", b"Helo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_9160_1117d943e8.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HELO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HELO>>(v1);
    }

    // decompiled from Move bytecode v6
}

