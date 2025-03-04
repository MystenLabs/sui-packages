module 0x76ab86e58f67f9f0efe1e332c5970d1ecb72781327b0415dccf99b5102a031a6::fnx {
    struct FNX has drop {
        dummy_field: bool,
    }

    fun init(arg0: FNX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FNX>(arg0, 6, b"FNX", b"FENIX", b"I am a Fenix in FIRE!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/kisspng_feather_phoenix_bird_color_clip_art_phoenix_5ac69a1b28aa80_4393070415229650191666_ad7981b3bb.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FNX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FNX>>(v1);
    }

    // decompiled from Move bytecode v6
}

