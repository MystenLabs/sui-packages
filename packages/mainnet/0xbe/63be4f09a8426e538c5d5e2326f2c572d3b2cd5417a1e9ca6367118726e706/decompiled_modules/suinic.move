module 0xbe63be4f09a8426e538c5d5e2326f2c572d3b2cd5417a1e9ca6367118726e706::suinic {
    struct SUINIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINIC>(arg0, 6, b"SUINIC", b"Suinic", b"SUINIC, inspired by the 2010 YouTube video \"How 2 Draw Sanic Hegehog\" by 0nyx, embraces the humor of misspelled, crudely drawn characters, much like the original Sanic meme that spread across the internet through parodies and memes with the iconic phrase \"Gotta Go Fast.\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_16_16_43_01_ae71f123a8_cb2fb27773.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINIC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINIC>>(v1);
    }

    // decompiled from Move bytecode v6
}

