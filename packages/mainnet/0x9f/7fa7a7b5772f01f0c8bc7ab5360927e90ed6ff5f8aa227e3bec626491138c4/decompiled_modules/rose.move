module 0x9f7fa7a7b5772f01f0c8bc7ab5360927e90ed6ff5f8aa227e3bec626491138c4::rose {
    struct ROSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROSE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROSE>(arg0, 6, b"ROSE", b"Rose on Sui", b"A community-driven first floral fragrant meme coin on the Sui blockchain. Join the Rose garden and watch your tokens bloom! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3649_3c9ca4b24d.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROSE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ROSE>>(v1);
    }

    // decompiled from Move bytecode v6
}

