module 0x128d7fe868057aa8a1f9b8c477102e4f26973284c8bfda58f6ea6f681c99dd8f::sgd {
    struct SGD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SGD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SGD>(arg0, 6, b"SGD", b"SUIGOD", b"MEME TOKENS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/openart_image_5_Nsq_G_Bwb_1728585579849_raw_8ecb50634f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SGD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SGD>>(v1);
    }

    // decompiled from Move bytecode v6
}

