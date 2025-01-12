module 0x31790abcfc98dfee78a3b64d0bec2fed7988dca6d8a6638ed30c52c4130ff6eb::ada {
    struct ADA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ADA>(arg0, 6, b"ADA", b"Cardano", b"Cardano is meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://akasui-statics.sgp1.cdn.digitaloceanspaces.com/images/466a94c7-6a86-4b3d-b0a1-39017726071e.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ADA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

