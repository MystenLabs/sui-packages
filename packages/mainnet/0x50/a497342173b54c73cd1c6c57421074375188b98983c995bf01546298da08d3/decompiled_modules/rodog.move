module 0x50a497342173b54c73cd1c6c57421074375188b98983c995bf01546298da08d3::rodog {
    struct RODOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: RODOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RODOG>(arg0, 6, b"RoDog", b"Joe Rogan Dog", b"Joe Rogan Dog is a meme token on the Sui blockchain, blending humor and community with fast, scalable transactions. Built for meme lovers, it brings a playful twist to decentralized finance.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000399_5f95bc3355.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RODOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RODOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

