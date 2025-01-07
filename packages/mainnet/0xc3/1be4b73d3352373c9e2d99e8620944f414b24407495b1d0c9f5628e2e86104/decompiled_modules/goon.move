module 0xc31be4b73d3352373c9e2d99e8620944f414b24407495b1d0c9f5628e2e86104::goon {
    struct GOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOON>(arg0, 6, b"GOON", b"GOONIES", b"I'm tired of you wack ass animals. Time to bring some real culture to this meme shit.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734047960624.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GOON>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOON>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

