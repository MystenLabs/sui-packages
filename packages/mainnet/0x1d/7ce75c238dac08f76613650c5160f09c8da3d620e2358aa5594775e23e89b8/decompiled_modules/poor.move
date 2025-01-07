module 0x1d7ce75c238dac08f76613650c5160f09c8da3d620e2358aa5594775e23e89b8::poor {
    struct POOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: POOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POOR>(arg0, 6, b"Poor", b"PoorMeme", b"It's just a poor meme.If you buy it, you will become as poor as he is", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/OIG_3_9a7271f6e9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POOR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POOR>>(v1);
    }

    // decompiled from Move bytecode v6
}

