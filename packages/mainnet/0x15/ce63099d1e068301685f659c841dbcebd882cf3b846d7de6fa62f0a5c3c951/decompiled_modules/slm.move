module 0x15ce63099d1e068301685f659c841dbcebd882cf3b846d7de6fa62f0a5c3c951::slm {
    struct SLM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLM>(arg0, 6, b"SLM", b"Long Mao", b"Sui Longmao is a community-driven decentralized meme token with a dedicated team, pushing and developing behind the scenes to make this the biggest Grow coin of 2024!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/memes_images_1719819243387_image_1ac6fe40fa.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLM>>(v1);
    }

    // decompiled from Move bytecode v6
}

