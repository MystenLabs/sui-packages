module 0x8a431d57075290c7a78542dbcd3f27c9ae8b4d6741b8892ad791337903ea323d::texas {
    struct TEXAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEXAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEXAS>(arg0, 6, b"Texas", b"Texas Calvo", b"Texas, ngmi number one cocksucker, he will suck his tiny dick for make him happy. Illegal mexican on USA. Collecting money to pay him a hair transplant in Turkey. Tejas calvo.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5607_9768459b0b.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEXAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TEXAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

