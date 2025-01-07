module 0xf12c1ea9c59b5a01b7090d250716375c9f4997f7bc5c3a64a49070e261659795::sassy {
    struct SASSY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SASSY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SASSY>(arg0, 6, b"SASSY", b"SASSY SALMON", b"Swimming upstream and shining bright. Sassy Salmon is the meme fish you cant ignore.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_2024_12_21_040629740_7095f0aee9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SASSY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SASSY>>(v1);
    }

    // decompiled from Move bytecode v6
}

